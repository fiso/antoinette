const cp = require('child_process');
const fs = require('fs');
const {packageNameOk} = require('./checkconfig.js');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

if (!packageNameOk) {
  process.exit(1);
}

let localEnvironment = {};

try {
  localEnvironment = JSON.parse(fs.readFileSync('akademi-env.json', 'utf8'));
} catch (error) {
  console.log('Local environment not set up!\n');
  process.exit(1);
}

console.log(`mysqldump -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} --databases ${pkg.name} > dump.sql`);
cp.execSync(`mysql -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} ${pkg.name} -e "delete from wp_options where option_name like '%_transient_%'"`);
cp.execSync(`mysqldump -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} --databases ${pkg.name} > dump.sql`);
