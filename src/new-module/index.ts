import { Rule, SchematicContext, Tree } from '@angular-devkit/schematics';
  
export function newModule(_options: any): Rule {
  
 console.log('generating a new module based on a template')
  
 return (tree: Tree, _context: SchematicContext) => {
   return tree;
 };
}