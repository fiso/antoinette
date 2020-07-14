const cp = require('child_process');
const fs = require('fs');
const wget = require('node-wget');

const fileName = 'wordpress-5.2.3.zip';
const cacheDir = '.wp-cache';

console.log('Downloading and installing wordpress…');

process.chdir(`${__dirname}/..`);

try {
  fs.mkdirSync('build');
} catch (e) {
  // Will throw if directory exists, this is fine
}

try {
  fs.mkdirSync(cacheDir);
} catch (e) {
  // Will throw if directory exists, this is fine
}

function getWpFile (fileName, then) {
  if (!fs.existsSync(`${cacheDir}/${fileName}`)) {
    wget(`https://wordpress.org/${fileName}`, () => {
      cp.execSync(`mv ${fileName} ${cacheDir}`);
      then(`${cacheDir}/${fileName}`);
    });
  } else {
    then(`${cacheDir}/${fileName}`);
  }
}

getWpFile(fileName, fileName => {
  process.chdir('build');
  cp.execSync('rm -Rf *');
  cp.execSync(`unzip ../${fileName} > /dev/null`);
  cp.execSync('mv wordpress/* .');
  cp.execSync('rmdir wordpress');
  cp.execSync('rm -Rf wp-content/themes/twenty*');
  cp.execSync('rm -Rf wp-content/plugins/*');
});
