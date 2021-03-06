const cp = require('child_process');
const fs = require('fs');
const {packageNameOk} = require('./checkconfig.js');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

if (!packageNameOk) {
  process.exit(1);
}

let localEnvironment = {};

try {
  localEnvironment = JSON.parse(fs.readFileSync('antoinette-env.json', 'utf8'));
} catch (error) {
  console.log('Local environment not set up!\n');
  process.exit(1);
}

cp.execSync(`mysql -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} -e "drop database if exists \\\`${pkg.name}\\\`"`);
cp.execSync(`mysql -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} < dump.sql`);
