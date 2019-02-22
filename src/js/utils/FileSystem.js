function readFile (fileEntry, resolve, reject) {
  fileEntry.file((file) => {
    const reader = new FileReader();

    reader.onloadend = function () {
      console.info(`Read file ${fileEntry.fullPath}`);
      resolve(this.result);
    };

    reader.readAsArrayBuffer(file);
  }, (error) => {
    reject(error);
  });
}

function writeFile (fileEntry, dataObj, resolve, reject) {
  fileEntry.createWriter((fileWriter) => {
    fileWriter.onwriteend = () => {
      console.info(`Wrote file ${fileEntry.fullPath}`);
      resolve(`cdvfile://localhost/persistent${fileEntry.fullPath}`);
    };

    fileWriter.onerror = (e) => {
      reject(`Failed to write file — ${e.toString()}`);
    };

    fileWriter.write(dataObj);
  });
}

export function savePersistentFile (filename, data) {
  return new Promise((resolve, reject) => {
    window.requestFileSystem(window.LocalFileSystem.PERSISTENT, 0,
        (fs) => {
          console.info(`Saving file ${filename}…`);
          fs.root.getFile(
              filename,
              {create: true, exclusive: false},
              (fileEntry) => {
                writeFile(fileEntry, data, resolve, reject);
              },
              (error) => {
                reject(error);
              });
        }, (error) => {
          reject(error);
        }
    );
  });
}

export function loadFile (filename) {
  return new Promise((resolve, reject) => {
    window.requestFileSystem(window.LocalFileSystem.PERSISTENT, 0,
        (fs) => {
          fs.root.getFile(filename, {create: false, exclusive: false},
              (fileEntry) => {
                readFile(fileEntry, resolve);
              }, (error) => {
                reject(error);
              }
          );
        }, (error) => {
          reject(error);
        });
  });
}

window.loadPersistentFile = loadFile;
