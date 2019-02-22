import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import Button from '~/js/app/components/common/Button';
import classNames from 'classnames';
import {copyToClipboard} from '~/js/utils/Clipboard';
import Modal from '~/js/app/components/common/Modal';
import PropTypes from 'prop-types';
import './ErrorModal.scss';

export default class ErrorModal extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.state = {};
    this.btnRef = React.createRef();
  }

  componentDidUpdate (prevProps) {
    if (this.props.visible && !prevProps.visible && this.btnRef.current) {
      this.btnRef.current.querySelector('button').focus();
    }
  }

  toggleExtended () {
    copyToClipboard(this.props.error.extendedInfo);
    this.setState({extended: !this.state.extended});
  }

  render () {
    const {error, onClose, visible} = this.props;
    const {extended} = this.state;

    return (
      <Modal visible={visible} onClose={onClose} className='error-modal'>
        {error &&
          <React.Fragment>
            <p>{error.message}</p>
            {error.extendedInfo &&
              <div className={classNames('extendedinfo', {extended})}>
                <a onClick={this.toggleExtended}>Visa utökad felinformation</a>
                <textarea rows={4} readOnly
                  value={error.extendedInfo} />
              </div>
            }
          </React.Fragment>
        }
        <div ref={this.btnRef}>
          <Button primary onClick={onClose}>OK</Button>
        </div>
      </Modal>
    );
  }
}

ErrorModal.propTypes = {
  error: PropTypes.object,
  onClose: PropTypes.func.isRequired,
  visible: PropTypes.bool,
};
