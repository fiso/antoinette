const cp = require('child_process');
const fs = require('fs');
const wget = require('node-wget');

console.log('Downloading and installing wordpress...');

process.chdir(`${__dirname}/..`);

try {
  fs.mkdirSync('build');
} catch (e) {
  // Will throw if directory exists, this is fine
}

process.chdir('build');

const fileName = 'wordpress-5.0.3.zip';
cp.execSync('rm -Rf *');
wget(`https://wordpress.org/${fileName}`, () => {
  cp.execSync(`unzip ${fileName} > /dev/null`);
  cp.execSync(`rm ${fileName}`);
  cp.execSync('mv wordpress/* .');
  cp.execSync('rmdir wordpress');
  cp.execSync('rm -Rf wp-content/themes/twenty*');
  cp.execSync('rm -Rf wp-content/plugins/*');
});
