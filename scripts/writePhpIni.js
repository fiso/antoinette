const cp = require('child_process');
const replace = require('replace');

function writePhpIni () {
  const logFilePath = `${process.cwd()}/php_error.log`;
  cp.execSync('cp ./php.template.ini ./php.ini');
  cp.execSync(`touch ${logFilePath}`);
  replace({
    regex: '{{LOGPATH}}',
    replacement: `${logFilePath}`,
    paths: ['./php.ini'],
    silent: true,
  });
}

writePhpIni();
