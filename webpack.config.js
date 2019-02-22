module.exports = {
  plugins: [
    new CopyWebpackPlugin([{
      from: 'src/php',
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
};
