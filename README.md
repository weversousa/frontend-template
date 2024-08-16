# Frontend Template

## Sobre

Configurações básicas para começar um projeto Frontend.

## Bibliotecas JS

### [package.json](https://gabrieluizramos.com.br/entendendo-o-package-json)

```Shell
npm init --yes
```

```JSON
// package.json
{
  "type": "module"
}
```

### [Biome](https://biomejs.dev/pt-br/)

```Shell
npm install --save-dev --save-exact @biomejs/biome
npx @biomejs/biome init
```

```JSON
// biomejs
{
  "formatter": {
    "enabled": true,
    "indentStyle": "space",
    "indentWidth": 2
  },
  "javascript": {
    "formatter": {
      "quoteStyle": "single"
    }
  }
}
```

### [lint-staged](https://github.com/lint-staged/lint-staged)

```Shell
npm install --save-dev lint-staged
```

```JSON
// package.json
{
  "lint-staged": {
    "*.ts": ["npx biome check --write --no-errors-on-unmatched"]
  }
}
```

### [commitlint](https://commitlint.js.org/)

```Shell
npm install --save-dev @commitlint/config-conventional @commitlint/cli
echo "export default { extends: ['@commitlint/config-conventional'] };" > commitlint.config.js
```

```JavaScript
// commitlint.config.js
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {'scope-empty': [2, 'never']}
};
```

### [Husky](https://typicode.github.io/husky/)

```Shell
npm install --save-dev husky
git init
npm run prepare # requer git init
npx husky init
```

```Shell
echo "#!/bin/sh" > .husky/pre-commit
echo "npx lint-staged" >> .husky/pre-commit
```

```Shell
echo "#!/bin/sh" > .husky/commit-msg
echo "npx --no -- commitlint --edit \$1" >> .husky/commit-msg
```

### [Commitizen](https://commitizen-tools.github.io/commitizen/) ou [gitmoji](https://gitmoji.dev/)

```Shell
npm install --save-dev commitizen
npx commitizen init cz-conventional-changelog --save-dev --save-exact
```

```JSON
// package.json
{
  "scripts": {
    "commit": "cz"
  }
}
```

```Shell
npm run commit # ao invés de git: commit -m ""
```

### TypeScript

```Shell
npm install typescript --save-dev
npx tsc --init
```
