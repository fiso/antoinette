#!/usr/bin/env node

const ncp = require('ncp');
const cp = require('child_process');

if (process.argv.length < 3) {
  console.error('Need a project ID (string)');
  process.exit();
}

const projectId = process.argv[2];

ncp('./', `../${projectId}`, (error) => {
  if (error) {
    console.log('Error while copying!\n');
    process.exit();
  }

  cp.execSync(`rm -Rf ../${projectId}/.git/`);
  cp.execSync(`rm -Rf ../${projectId}/build/`);
  cp.execSync(`rm -Rf ../${projectId}/node_modules/`);
  cp.execSync(`rm -f ../${projectId}/akademi-env.json`);
  cp.execSync(`rm -f ../${projectId}/README.md`);
  cp.execSync(`mv ../${projectId}/README_COPY.md ../${projectId}/README.md`);
  cp.execSync('git init', {cwd: `../${projectId}`});
  cp.execSync(`cp ../${projectId}/config.example.json ../${projectId}/config.json`);

  console.log(`Project created in ../${projectId}`);
});
