import { Rule, SchematicContext, Tree } from '@angular-devkit/schematics';
import { render, createContext } from '@scaffdog/engine';

export function newModule(options: any): Rule {

  return (tree: Tree, _context: SchematicContext) => {
    console.log('generating a new module');
    createFiles(tree, "./src/new-module/template", options);
    return tree;
  };

}

export function createFiles(tree: Tree, root: string, options: any) {
  const dir = "src/app/modules";
  tree.getDir(root)
    .visit(filePath => {
      if (filePath.endsWith(".tpl")) {
        let content = String(tree.read(filePath));
        const entity = options.entity;
        const plural = options.plural;
        content = content
          .replace(/entitys/g, plural)
          .replace(/Entitys/g, plural.charAt(0).toUpperCase() + plural.slice(1))
          .replace(/entity/g, entity)
          .replace(/Entity/g, entity.charAt(0).toUpperCase() + entity.slice(1))
        const context = createContext({
          tags: ['<%', '%>'],
          variables: new Map([['displayedColumns', options.displayedColumns.split(",").map(String)],
          ['primaryKey', options.primaryKey], ['primaryKeyType', options.primaryKeyType]])
        });
        content = render(content, context);
        const name = filePath.replace("/src/new-module/template/", "").replace(/entity/g, entity).replace(".tpl", "")
        tree.create(dir + "/" + name, content);
      } else {
        createFiles(tree, filePath, options);
      }
    });
}