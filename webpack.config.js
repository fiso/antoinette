const fs = require('fs');
const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const version = require('./package.json').version;
const env = process.env.NODE_ENV || 'development';
const target = process.env.BUILD_TARGET || 'local';

console.log(`${version} ===================`);
console.log(`${env} build started for ${target}`);
console.log('=========================');

if (!fs.existsSync('config.json')) {
  if (target === 'local') {
    console.error('No config.json file found. Aborting build.');
    process.exit(1);
  } else {
    fs.copyFileSync('config.example.json', 'config.json');
  }
}

String.prototype.replaceAll = function (target, replacement) {
  return this.split(target).join(replacement);
};

const production = process.env.NODE_ENV === 'production';
const vstr = version.replaceAll('.', '-');

const extractSass = new ExtractTextPlugin({
  filename: production ? `css/akm-[name]-${vstr}.css` :
                         'css/akm-[name]-[hash].css',
  // This actually makes the fallback style-loader active during development
  disable: !production,
});

module.exports = {
  mode: env,
  entry: ['babel-polyfill', './src/js/index.jsx'],
  output: {
    path: path.resolve(__dirname, 'build/wp-content/themes/akademi'),
    filename: production ? `js/akm-[name]-${vstr}.bundle.js` :
                           'js/akm-[name]-[hash].bundle.js',
  },
  optimization: {
    minimize: production,
  },
  context: __dirname,
  target: 'web',
  module: {
    rules: [
      {
        test: /.(js|jsx)$/,
        loader: 'babel-loader',
        exclude: [path.resolve(__dirname, 'node_modules')],
      },
      {
        test: /\.scss$/,
        use: extractSass.extract({
          use: [{
            loader: 'css-loader',
          }, {
            loader: 'sass-loader',
            options: {
              outputStyle: production ? 'compressed' : 'nested',
            },
          }],
          fallback: 'style-loader',
        }),
      },
      {
        test: /\.(eot|woff|woff2|svg|ttf|png|jpg|gif)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: production ? '../../../' :
                                       '../../../',
            },
          },
        ],
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  plugins: [
    // This injects the process.env.NODE_ENV variable into the bundle,
    // so frontend config can know what environment it is in
    new webpack.DefinePlugin({
      'process.env': {
        BUILD_TARGET: JSON.stringify(process.env.BUILD_TARGET),
        NODE_ENV: JSON.stringify(process.env.NODE_ENV),
      },
    }),
    extractSass,
    new CopyWebpackPlugin([{
      from: 'src/php',
    }]),
    new HtmlWebpackPlugin({
      inject: false,
      filename: 'header.php',
      template: 'src/php/header.php',
    }),
    new HtmlWebpackPlugin({
      inject: false,
      filename: 'footer.php',
      template: 'src/php/footer.php',
    }),
    new CopyWebpackPlugin([{
      from: 'src/assets',
    }]),
    new CopyWebpackPlugin([{
      from: 'src/webroot',
      to: '../../../',
    }]),
    new CopyWebpackPlugin([{
      from: 'src/uploads',
      to: '../../uploads/',
    }]),
    new CopyWebpackPlugin([{
      from: 'src/plugins',
      to: '../../plugins/',
    }]),
    new CopyWebpackPlugin([{
      from: 'src/meta/wp-theme-meta',
      to: '.',
    }]),
    ...production
      ? []
      : [new CopyWebpackPlugin([{
        from: 'src/wp-config.php',
        to: '../../../wp-config.php',
      }])],
  ]
      .concat(production ? [
        // https://webpack.js.org/plugins/module-concatenation-plugin/
        new webpack.optimize.ModuleConcatenationPlugin(),
        new webpack.HashedModuleIdsPlugin(),
      ] : []),
  stats: {
    colors: true,
  },
  devtool: production ? 'cheap-module-source-map' : 'source-map',
  node: {
    fs: 'empty',
    net: 'empty',
    tls: 'empty',
  },
};
