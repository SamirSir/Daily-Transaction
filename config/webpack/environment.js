
// in config/webpack/environment.js
const { environment } = require('@rails/webpacker');

const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  }));

const config = environment.toWebpackConfig();

config.resolve.alias = {
  jquery: 'jquery/src/jquery'
};

module.exports = environment;  