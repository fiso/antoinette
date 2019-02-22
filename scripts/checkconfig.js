let projectId = '';
let localEnvironment = {};

function checkConfig () {
  const fs = require('fs');
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

  if (!pkg.akademiId) {
    console.log('Project id not set!\n');
    return false;
  }

  projectId = pkg.akademiId;

  try {
    localEnvironment = JSON.parse(fs.readFileSync('akademi-env.json', 'utf8'));
  } catch (error) {
    console.log('Local environment not set up!\n');
    return false;
  }

  if (!localEnvironment
    || !localEnvironment.mysqlHost
    || !localEnvironment.mysqlUser
    || typeof localEnvironment.mysqlPass === 'undefined') {
    console.log('Local environment not set up!\n');
    return false;
  }

  if (!fs.existsSync('src/wp-config.php')) {
    console.log('wp-config missing!\n');
    configure(projectId,
        localEnvironment.mysqlHost,
        localEnvironment.mysqlUser,
        localEnvironment.mysqlPass);
  }

  return true;
}

function configure (projectId, mysqlHost, mysqlUser, mysqlPass) {
  const cp = require('child_process');
  cp.execSync(`json -I -f package.json -e 'this.akademiId="${projectId}"'`);
  cp.execSync('echo {} > akademi-env.json');
  cp.execSync(`json -I -f akademi-env.json -e 'this.mysqlHost="${mysqlHost}";this.mysqlUser="${mysqlUser}";this.mysqlPass="${mysqlPass}"'`);

  const replace = require('replace');

  // For some reason, the replace package refuses to work with files ending
  // in .sql, so we need to make a temporary copy to modify
  cp.execSync('cp ./src/meta/wp-fresh-install.sql ./sqldump.txt');
  replace({
    regex: '{{PROJECT_ID}}',
    replacement: projectId,
    paths: ['./sqldump.txt'],
    silent: true,
  });
  cp.execSync(`mysql -u ${mysqlUser} --password=${mysqlPass} < ./sqldump.txt`);
  cp.execSync('rm ./sqldump.txt');

  const crypto = require('crypto');
  const generateTokenString = () => {
    return crypto.randomBytes(64).toString('hex');
  };

  const replacements = {
    '{{DATABASE_NAME}}': projectId,
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

if (checkConfig()) {
  process.exit(0);
} else {
  const rl = require('readline-sync');

  console.log('🚀   Akademi WordPress template boilerplate configurator to the rescue!');
  console.log(
      '☎️   Hang on, summoning a wise owl to help guide you through the configuration process...\n');
  console.log('🦉 — Hoot! Hello, Pie person!');
  console.log('🦉 — Your project seems to be lacking some basic configuration...');
  console.log(
      '🦉 — Please humour me by answering a couple of simple questions to get started\n');

  if (!projectId) {
    projectId = rl.question('🦉 — First off, give me a project id for this exciting new project: ');
  }

  if (Object.keys(localEnvironment).length < 3) {
    localEnvironment.mysqlHost = rl.question('🦉 — Thank you. Now, what\'s your mysql host address? (127.0.0.1(:3306)) ');
    localEnvironment.mysqlUser = rl.question('🦉 — Right, and what\'s the mysql username then? (root) ');
    localEnvironment.mysqlPass = rl.question('🦉 — Wow, really? All right then. So finally, the mysql password? () ', {
      hideEchoBack: true,
    });
  }

  console.log('🦉 — Much obliged! That should be all for now, please have a seat while I set everything up for you...');
  console.log('🦉 — If you don\'t hear from me again, everything went just fine!');
  console.log('🦉 — Hoot!');
  console.log('     The owl flies off into the distance...\n\n');

  if (!localEnvironment.mysqlHost || !localEnvironment.mysqlHost.trim()) {
    localEnvironment.mysqlHost = '127.0.0.1';
  }
  if (!localEnvironment.mysqlUser || !localEnvironment.mysqlUser.trim()) {
    localEnvironment.mysqlUser = 'root';
  }
  if (!localEnvironment.mysqlPass || !localEnvironment.mysqlPass.trim()) {
    localEnvironment.mysqlPass = '';
  }

  configure(projectId,
      localEnvironment.mysqlHost,
      localEnvironment.mysqlUser,
      localEnvironment.mysqlPass);

  process.exit(checkConfig() ? 0 : 1);
}
