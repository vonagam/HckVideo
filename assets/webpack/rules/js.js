'use strict';

const _ = require( 'lodash' );


module.exports = function ( { isDev } ) {

  return {

    test: /\.js$/i,

    exclude: /node_modules/,

    use: [

      {

        loader: 'babel-loader',

        options: {

          cacheDirectory: true,

          presets: [

            [ require( 'babel-preset-env' ), { modules: false, targets: { browsers: '> 1%', uglify: true }, useBuiltIns: true } ],

          ],

          plugins: _.compact( [

            require( 'babel-plugin-syntax-dynamic-import' )(),

            require( 'babel-plugin-transform-class-properties' )( { spec: true } ),

            require( 'babel-plugin-lodash' ),

            isDev && require( 'react-hot-loader/babel' ),

          ] ),

        },

      },

    ],

  };

};
