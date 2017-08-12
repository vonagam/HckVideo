'use strict';


module.exports = function ( { isProd } ) {

  return {

    test: /\.(jpe?g|png|gif|svg)$/i,

    use: [

      { loader: 'url-loader', options: { limit: 3000, name: isProd ? '[name].[hash].[ext]' : '[name].[ext]' } },

      { loader: 'image-webpack-loader', options: {} },

    ],

  };

};
