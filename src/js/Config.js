const buildTarget = process.env.BUILD_TARGET; // Will be injected by webpack

const env = (() => {
  // Don't try to be clever and simplify this into a dynamic expression
  // inside the call to require() as that will make webpack choke
  switch (buildTarget) {
    case 'prod':
      return require('../../config.prod.json');
    case 'stage':
      return require('../../config.stage.json');
    default:
      return require('../../config.json');
  }
})();

export const config = {
  ...env,
  url: function (service, endpoint) {
    return `${this.services[service].url}${this.services[service][endpoint]}`;
  },
};
