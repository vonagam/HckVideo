'use strict';


module.exports = function ( { isProd } ) {

  return {

    test: /\.(eot|ttf|woff|woff2)$/i,

    use: [

      { loader: 'url-loader', options: { limit: 3000, name: isProd ? '[name].[hash].[ext]' : '[name].[ext]' } },

    ],

  };

};
