const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

if (!pkg.akademiId) {
  console.log('Project id not set!\n');
  process.exit();
}

const cp = require('child_process');

let localEnvironment = {};

try {
  localEnvironment = JSON.parse(fs.readFileSync('akademi-env.json', 'utf8'));
} catch (error) {
  console.log('Local environment not set up!\n');
  process.exit(1);
}

cp.execSync(`mysql -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} ${pkg.akademiId} -e "delete from wp_options where option_name like '%_transient_%'"`);
cp.execSync(`mysqldump -u ${localEnvironment.mysqlUser} --password=${localEnvironment.mysqlPass} --databases ${pkg.akademiId} > dump.sql`);
