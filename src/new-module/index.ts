import { join, normalize } from '@angular-devkit/core';
import { apply, chain, FileEntry, forEach, MergeStrategy, mergeWith, move, Rule, SchematicContext, SchematicsException, Source, Tree, url } from '@angular-devkit/schematics';
import { render, createContext } from '@scaffdog/engine';
import { getWorkspace } from '@schematics/angular/utility/workspace';
import * as ts from 'typescript';
import { InsertChange } from '@schematics/angular/utility/change';
import { addRouteDeclarationToModule } from '@schematics/angular/utility/ast-utils';
import { Schema } from './schema';

export function newModule(options: Schema): Rule {
  return async (tree: Tree, _context: SchematicContext) => {
    await setupOptions(tree, options);
    options.columns = options.displayedColumns.split(",").map(String);
    const moduleSource = apply(url('./template'), [
      forEach(entry => template(entry, options)),
      move(normalize(options.path + '/app/' + options.directory + "/" + options.plural))
    ]);
    options.columns = options.columns.filter((column: any) => column != options.primaryKey);
    const modelSource = apply(url('./model'), [
      forEach(entry => template(entry, options)),
      move(normalize(options.path + '/app/model'))
    ]);
    return chain([mergeWith(moduleSource, MergeStrategy.Overwrite),
    mergeWith(modelSource, MergeStrategy.Overwrite),
    mergeWith(addRoute(tree, options), MergeStrategy.Overwrite)]);
  };
}

export async function setupOptions(tree: Tree, options: Schema): Promise<Tree> {
  const workspace = await getWorkspace(tree);
  if (!options.project) {
    options.project = workspace.projects.keys().next().value;
  }
  const project = workspace.projects.get(options.project);
  if (!project) {
    throw new SchematicsException(`Invalid project name: ${options.project}`);
  }
  options.path = join(normalize(project.root), 'src');
  return tree;
}

export function template(entry: FileEntry, options: Schema) {
  if (entry.path.endsWith(".tpl")) {
    const entity = options.entity;
    const plural = options.plural;
    const content = String(entry.content)
      .replace(/entitys/g, plural)
      .replace(/Entitys/g, plural.charAt(0).toUpperCase() + plural.slice(1))
      .replace(/entity/g, entity)
      .replace(/Entity/g, entity.charAt(0).toUpperCase() + entity.slice(1));
    const context = createContext({
      tags: ['<%', '%>'],
      variables: new Map([['displayedColumns', options.columns as any],
      ['primaryKey', options.primaryKey], ['primaryKeyType', options.primaryKeyType]])
    });
    return {
      content: Buffer.from(render(content, context)),
      path: normalize(entry.path.replace(/entity/g, entity).replace(".tpl", ""))
    };
  }
  return entry;
}

export function addRoute(tree: Tree, options: Schema): Source {
  if (options.routing) {
    const modulePath = normalize(options.path + '/app/app-routing.module.ts');
    const moduleContent = String(tree.read(modulePath));
    const source = ts.createSourceFile(modulePath, moduleContent, ts.ScriptTarget.Latest, true);
    const updateRecorder = tree.beginUpdate(modulePath);
    const name = options.entity.charAt(0).toUpperCase() + options.entity.slice(1);
    const change = addRouteDeclarationToModule(
      source,
      "./src/app",
      `{
      path: '${options.plural}',
      component: LayoutComponent,
      loadChildren: () => import('./modules/${options.plural}/${options.entity}.module').then(m => m.${name}Module),
      canActivate: [AuthGuard]
     }`
    ) as InsertChange;
    updateRecorder.insertLeft(change.pos, change.toAdd);
    tree.commitUpdate(updateRecorder);
  }
  return () => tree;
}