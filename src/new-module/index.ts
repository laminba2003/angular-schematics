import { Rule, SchematicContext, Tree } from '@angular-devkit/schematics';

export function newModule(options: any): Rule {

  console.log('generating a new module based on a template')

  return (tree: Tree, _context: SchematicContext) => {
    console.log("name " + options.name);
    createFiles(tree, "./src/new-module/template", options.name);
    return tree;
  };

}

export function createFiles(tree: Tree, root: string, entity: string) {
  const dir = "src/app/modules";
  tree.getDir(root)
    .visit(filePath => {
      console.log("file : " + filePath);
      if (filePath.endsWith(".txt")) {
        let content = ""+ tree.read(filePath);
        content = content.replace(/entity/g, entity).replace(/Entity/g, entity.charAt(0).toUpperCase() + entity.slice(1))
        const name = filePath.replace("/src/new-module/template/", "").replace(/entity/g, entity).replace(".txt", "")
        tree.create(dir + "/" + name, "" + content);
      } else {
        createFiles(tree, filePath, entity);
      }
    });
}