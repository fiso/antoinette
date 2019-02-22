import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import classNames from 'classnames';
import PropTypes from 'prop-types';
import './Modal.scss';

export default class Modal extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
  }

  componentDidMount () {
    window.addEventListener('keydown', this.onKey);
  }

  componentWillUnmount () {
    window.removeEventListener('keydown', this.onKey);
  }

  onKey (e) {
    const {visible, allowClose, onClose} = this.props;
    if (!visible || !allowClose) {
      return;
    }

    if (e.key && e.key.toUpperCase() === 'ESCAPE') {
      e.stopPropagation();
      onClose && onClose(e);
    }
  }

  onClick (e) {
    const {allowClose, onClose} = this.props;

    if (allowClose && onClose) {
      onClose(e);
    }
  }

  stopPropagation (e) {
    e.stopPropagation();
  }

  render () {
    const {visible, children, className} = this.props;

    return (
      <aside className={classNames('modal', {visible})} onClick={this.onClick}>
        <main className={className} onClick={this.stopPropagation}>
          {children}
        </main>
      </aside>
    );
  }
}

Modal.propTypes = {
  allowClose: PropTypes.bool,
  children: PropTypes.node,
  className: PropTypes.string,
  onClose: PropTypes.func,
  visible: PropTypes.bool,
};

Modal.defaultProps = {
  allowClose: true,
  children: [],
  className: '',
};
