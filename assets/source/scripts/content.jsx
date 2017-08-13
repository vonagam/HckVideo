import _ from 'lodash';

import { Modal } from 'antd';


let objectManager;

let myMap;

let videos;

let init = ( onClick ) => {

  myMap = new ymaps.Map( 'map', {

    center: [ 55.76, 37.64 ],

    zoom: 10,

    controls: [ 'zoomControl' ],

  } );

	objectManager = new ymaps.ObjectManager( {

    clusterize: true,

    gridSize: 32,

  } );

  objectManager.objects.options.set( 'preset', 'islands#blueDotIcon' );

  objectManager.clusters.options.set( 'preset', 'islands#blueClusterIcons' );

  objectManager.objects.events.add( 'click', function ( event ) {

    onClick( videos[ event.get( 'objectId' ) ] );

  } );

}

let placeVideos = ( _videos ) => {

  myMap.geoObjects.removeAll();

  objectManager.removeAll();

  videos = _videos;

  let collection = {

    type: 'FeatureCollection',

    features: [],

  };

  _.each( videos, ( video, index ) => {

    if ( ! video.coordinates ) return;

		collection.features.push( {

      type: 'Feature',

      id: index,

      geometry: {

        type: 'Point',

        coordinates: video.coordinates

      }

    } );

  } );

  if ( _.isEmpty( collection.features ) ) return;

  objectManager.add( collection );

  myMap.geoObjects.add( objectManager );

  myMap.setBounds( myMap.geoObjects.getBounds(), { checkZoomRange: true } );

}


class PhxMap extends React.Component {

  shouldComponentUpdate() {

    return false;

  }

  render() {

    return (

      <div id='map' style={ { height: '600px', width: '100%' } } />

    );

  }

}


export default class PhxContent extends React.Component {

  constructor( props ) {

    super( props );

    this.state = {

      video: undefined,

    };

  }

  onClick = ( video ) => {

    this.setState( { video } );

  }

  componentDidMount() {

    ymaps.ready( () => {

      init( this.onClick );

      placeVideos( this.props.view.videos );

    } );

  }

  componentWillReceiveProps( nextProps ) {

    if ( nextProps.view.videos !== this.props.view.videos ) {

      placeVideos( this.props.view.videos );

    }

  }

  render() {

    let { video } = this.state;


    return (

      <div>

        <PhxMap />

        {

          video ?

            <Modal

              className='phx-video_modal'

              style={ { minWidth: "90vw" } }

              visible={ true }

              onOk={ () => this.setState( { video: undefined } ) }

              onCancel={ () => this.setState( { video: undefined } ) }

            >

              <iframe

                id="ytplayer"

                type="text/html"

                src={ 'https://www.youtube.com/embed/' + video.url }

              />

            </Modal>

          : undefined

        }

      </div>

    );

  }

}
