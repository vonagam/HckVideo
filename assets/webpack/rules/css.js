'use strict';


module.exports = function ( { isProd, isDev } ) {

  return {

    test: /\.css$/i,

    use: require( 'extract-text-webpack-plugin' ).extract( {

      fallback: 'style-loader',

      use: [

        { loader: 'css-loader', options: { minimize: isProd, sourceMap: isDev } },

        {

          loader: 'postcss-loader',

          options: {

            sourceMap: true,

            plugins: ( loader ) => [

              require( 'iconfont-webpack-plugin' )( loader ),

              require( 'postcss-smart-import' )(),

              require( 'autoprefixer' )(),

            ],

          },

        },

        { loader: 'resolve-url-loader', options: { sourceMap: true } },

      ],

    } ),

  };

};
