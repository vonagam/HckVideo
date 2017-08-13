import { Card } from 'antd';


export default class PhxHeader extends React.Component {

  render() {

    let { subject } = this.props;


    if ( subject ) {

      return (

        <Card

          className='phx-header_subject'

          title={ subject.name }

          style={ { marginBottom: 16, backgroundImage: `url(${ subject.image })` } }

          children={ subject.description }

        />

      );

    } else {

      return (

        <Card

          title='О проекте'

          style={ { marginBottom: 16 } }

          children='Описание'

        />

      );

    }

  }

}
