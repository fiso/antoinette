#!/usr/bin/env node
// ------- EDIT THESE AS NEEDED -------
const validFiletypes = ['jpg', 'jpeg', 'png'];
const outSizes = [2560, 1440, 1280, 768, 414, 375, 320];
// ------- EDIT THESE AS NEEDED -------

const execFile = require('child_process').execFile;
const execFileSync = require('child_process').execFileSync;

function getFileEnding (fileName) {
  if (fileName.lastIndexOf('.') === -1) {
    return '';
  }

  return fileName.substr(fileName.lastIndexOf('.') + 1).toLocaleLowerCase();
}

function getBaseFilename (fileName) {
  if (fileName.lastIndexOf('.') === -1) {
    return fileName;
  }

  return fileName.substring(0, fileName.lastIndexOf('.'));
}

function replaceAll (input, search, replacement) {
  return input.replace(new RegExp(search, 'g'), replacement);
}

function convertImage (fileName, outFilename) {
  const ending = getFileEnding(fileName);

  if (outFilename.lastIndexOf('/') !== -1) {
    execFileSync('mkdir', ['-p',
      outFilename.substr(0, outFilename.lastIndexOf('/'))]);
  }

  if (validFiletypes.indexOf(ending) === -1) {
    console.log(`Copying ${fileName} -> ${outFilename}`);
    execFileSync('cp', [fileName, outFilename]);
    return;
  }

  execFileSync('cp', [fileName, outFilename.replace(`.${ending}`,
      `_orig.${ending}`)]);

  execFileSync('convert', [fileName, outFilename.replace(`.${ending}`,
      '_orig.webp')]);

  outSizes.forEach((size) => {
    const sizeName = outFilename.replace(`.${ending}`, `_${size}.${ending}`);
    console.log(`Converting ${fileName} -> ${sizeName} and webp`);
    const webpName = sizeName.replace(ending, 'webp');

    try {
      execFileSync('convert', [
        fileName,
        '-resize',
        `${size}x${size}`,
        sizeName,
      ]);
      execFileSync('convert', [
        sizeName,
        webpName,
      ]);
    } catch (e) {
      console.error(`Error converting ${fileName} to ${sizeName}!`);
    }
  });
}

if (process.argv.length < 3) {
  console.error('Need either --all or a filename');
  process.exit(1);
}

const fileArg = process.argv[2];

const inFolder = './src/images';
const outFolder = './src/assets/img/';

if (fileArg === '--all') {
  execFile('find', [inFolder, '-type', 'f'], function (err, stdout, stderr) {
    const fileList = stdout.split('\n').filter(Boolean);

    console.log(`Starting conversion of ${fileList.length} files...`);

    fileList.forEach((fileName, index) => {
      const base = getBaseFilename(fileName);
      const ending = getFileEnding(fileName);
      let outFilename = replaceAll(
          `${base}.${ending}`.toLocaleLowerCase(),
          ' ', '');
      outFilename = outFolder + outFilename.substr(outFilename.indexOf(inFolder)
        + inFolder.length + 1);

      convertImage(fileName, outFilename);
      const pct = (index + 1) / fileList.length * 100;
      console.log(`- ${index + 1} / ${fileList.length} files converted (${pct.toFixed(1)}%)`);
    });
  });
} else {
  const fileName = fileArg;
  const base = getBaseFilename(fileName);
  const ending = getFileEnding(fileName);
  let outFilename = replaceAll(
      `${base}.${ending}`.toLocaleLowerCase(),
      ' ', '');
  outFilename = outFolder + outFilename.substr(outFilename.indexOf(inFolder)
    + inFolder.length);

  convertImage(fileName, outFilename);
}
