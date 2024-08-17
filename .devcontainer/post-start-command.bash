#!/bin/bash

PACKAGE_JSON="package.json";
BIOME_JSON="biome.json";

npm init --yes;

npm install --save-dev --save-exact @biomejs/biome && npx @biomejs/biome init;

npm install --save-dev lint-staged;

npm install --save-dev @commitlint/config-conventional @commitlint/cli \
&& echo "export default { extends: ['@commitlint/config-conventional'], rules: {'scope-empty': [2, 'never']} };" > commitlint.config.js;

rm -fr .git;
git init && npm install --save-dev husky && npx husky init && npm run prepare;
echo "#!/bin/sh" > .husky/pre-commit && echo "npx lint-staged" >> .husky/pre-commit;
echo "#!/bin/sh" > .husky/commit-msg && echo "npx --no -- commitlint --edit \$1" >> .husky/commit-msg;

npm install --save-dev commitizen && npx commitizen init cz-conventional-changelog --save-dev --save-exact;

jq 'to_entries | ( .[:(index(.[] | select(.key == "main")) + 1)] + [{"key": "type", "value": "module"}] + .[(index(.[] | select(.key == "main")) + 1):] ) | from_entries' $PACKAGE_JSON > temp.json && mv temp.json $PACKAGE_JSON;
jq 'to_entries | ( .[:(index(.[] | select(.key == "scripts")) + 1)] + [{"key": "lint-staged", "value": {"*.ts": ["npx biome check --write --no-errors-on-unmatched"]}}] + .[(index(.[] | select(.key == "scripts")) + 1):] ) | from_entries' $PACKAGE_JSON > temp.json && mv temp.json $PACKAGE_JSON;
jq '(.scripts |= . + {"commit": "cz"})' $PACKAGE_JSON > temp.json && mv temp.json $PACKAGE_JSON;
jq '. + {"formatter": {"enabled": true, "indentStyle": "space", "indentWidth": 2}, "javascript": {"formatter": {"quoteStyle": "single"}}}' "$BIOME_JSON" > temp.json && mv temp.json "$BIOME_JSON";

npx biome check --write --no-errors-on-unmatched;
