const cp = require('child_process');
const replace = require('replace');

function writePhpIni () {
  cp.execSync('cp ./php.template.ini ./php.ini');
  replace({
    regex: '{{LOGPATH}}',
    replacement: `${process.cwd()}/php_error.log`,
    paths: ['./php.ini'],
    silent: true,
  });
}

writePhpIni();
