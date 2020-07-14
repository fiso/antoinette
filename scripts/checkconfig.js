const cp = require('child_process');
const crypto = require('crypto');
const fs = require('fs');
const replace = require('replace');

function packageNameOk () {
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

  if (!pkg.name || pkg.name === 'antoinette') {
    // eslint-disable-next-line max-len
    console.error('You should set the "name" field in your package.json file to something unique for this project');
    return false;
  }

  return true;
}

function checkConfig () {
  if (!packageNameOk()) {
    process.exit(1);
  }

  let localEnvironment = null;
  try {
    localEnvironment = JSON.parse(fs.readFileSync('antoinette-env.json', 'utf8'));
  } catch (error) {
    console.error('Local environment not set up!\n');
    return false;
  }

  if (!localEnvironment
    || !localEnvironment.mysqlHost
    || !localEnvironment.mysqlUser
    || typeof localEnvironment.mysqlPass === 'undefined') {
    console.error('Local environment not set up!\n');
    return false;
  }

  if (!fs.existsSync('src/wp-config.php')) {
    console.error('wp-config missing!\n');
    return false;
  }

  return true;
}

function configure (projectName, mysqlHost, mysqlUser, mysqlPass) {
  if (!fs.existsSync('antoinette-env.json')) {
    cp.execSync('echo {} > antoinette-env.json');
    cp.execSync(`json -I -f antoinette-env.json -e 'this.mysqlHost="${mysqlHost}";this.mysqlUser="${mysqlUser}";this.mysqlPass="${mysqlPass}"'`);
  }

  // For some reason, the replace package refuses to work with files ending
  // in .sql, so we need to make a temporary copy to modify
  cp.execSync('cp ./src/meta/wp-fresh-install.sql ./sqldump.txt');
  replace({
    regex: '{{PROJECT_ID}}',
    replacement: projectName,
    paths: ['./sqldump.txt'],
    silent: true,
  });
  const password = crypto.randomBytes(8).toString('hex');
  replace({
    regex: '{{ADMIN_PASSWORD_HASH}}',
    replacement: crypto.createHash('md5').update(password).digest('hex'),
    paths: ['./sqldump.txt'],
    silent: true,
  });
  cp.execSync(`mysql -u ${mysqlUser} --password=${mysqlPass} < ./sqldump.txt`);
  cp.execSync('rm ./sqldump.txt');

  console.log('== ADMIN PASSWORD GENERATED');
  console.log('');
  console.log('A password for the admin user has been generated for you.');
  console.log('This password is not cryptographically secure, and you should change it before taking your site live.');
  console.log('The password is:');
  console.log(password);
  console.log('');
  console.log('== ADMIN PASSWORD GENERATED');

  const generateTokenString = () => {
    return crypto.randomBytes(64).toString('hex');
  };

  const replacements = {
    '{{DATABASE_NAME}}': projectName,
    '{{DATABASE_USER}}': mysqlUser,
    '{{DATABASE_PASSWORD}}': mysqlPass,
    '{{DATABASE_HOST}}': mysqlHost,
    '{{AUTH_KEY}}': generateTokenString(),
    '{{SECURE_AUTH_KEY}}': generateTokenString(),
    '{{LOGGED_IN_KEY}}': generateTokenString(),
    '{{NONCE_KEY}}': generateTokenString(),
    '{{AUTH_SALT}}': generateTokenString(),
    '{{SECURE_AUTH_SALT}}': generateTokenString(),
    '{{LOGGED_IN_SALT}}': generateTokenString(),
    '{{NONCE_SALT}}': generateTokenString(),
  };

  cp.execSync('cp -f ./src/meta/wp-config-default.php ./src/wp-config.php');
  Object.keys(replacements).forEach((key) => {
    const value = replacements[key];
    replace({
      regex: key,
      replacement: value,
      paths: ['./src/wp-config.php'],
      silent: true,
    });
  });
}

const runningAsScript = !module.parent;

if (runningAsScript) {
  if (checkConfig()) {
    process.exit(0);
  } else {
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    const cfg = (() => {
      try {
        return JSON.parse(fs.readFileSync('antoinette-env.json', 'utf8'));
      } catch (e) {
        return {
          mysqlHost: '127.0.0.1',
          mysqlUser: 'root',
          mysqlPass: ''
        };
      }
    })();

    configure(pkg.name,
        cfg.mysqlHost,
        cfg.mysqlUser,
        cfg.mysqlPass);

    process.exit(checkConfig() ? 0 : 1);
  }
}

module.exports = {
  packageNameOk,
};
