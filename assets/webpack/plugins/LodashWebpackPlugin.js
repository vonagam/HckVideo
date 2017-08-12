'use strict';


module.exports = function () {

  return new ( require( 'lodash-webpack-plugin' ) )( {

    shorthands: true,

    collections: true,

    unicode: true,

    memoizing: true,

    flattening: true,

    paths: true,

  } );

};
