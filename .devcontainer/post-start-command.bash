#!/bin/bash

npm install --save-dev --save-exact @biomejs/biome && npx @biomejs/biome init;

npm install --save-dev lint-staged;

npm install --save-dev @commitlint/config-conventional @commitlint/cli \
&& echo "export default { extends: ['@commitlint/config-conventional'], rules: {'scope-empty': [2, 'never']} };" > commitlint.config.js;

rm -fr .git;
git init && npm install --save-dev husky && npx husky init && npm run prepare;
echo "#!/bin/sh" > .husky/pre-commit && echo "npx lint-staged" >> .husky/pre-commit;
echo "#!/bin/sh" > .husky/commit-msg && echo "npx --no -- commitlint --edit \$1" >> .husky/commit-msg;

npm install --save-dev commitizen && npx commitizen init cz-conventional-changelog --save-dev --save-exact;
