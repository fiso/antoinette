import React, {PureComponent} from 'react';
import PropTypes from 'prop-types';
import './Example.scss';

class Example extends PureComponent {
  constructor (props) {
    super(props);
  }

  render () {
    const {theText} = this.props;

    return (
      <section className='section-example'>
        Example — {theText}
      </section>
    );
  }
}

export default Example;

Example.propTypes = {
  theText: PropTypes.string.isRequired,
};
