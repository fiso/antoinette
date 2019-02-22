import classNames from 'classnames';
import PropTypes from 'prop-types';
import React from 'react';
import './Button.scss';

const Button = React.memo(({linkTo, submit, reset, primary, secondary,
  className, inverted, ...props}) => {
  const isType = submit ? 'submit' : reset ? 'reset' : 'button';
  const btn =
    <button {...props} type={isType}
      className={classNames(className, {primary, inverted, secondary})}>
      {props.children}
    </button>;

  return linkTo
    ? <a href={linkTo} className={classNames('button-wrapper',
        {disabled: props.disabled})}>
      {btn}
    </a>
    : btn;
});

export default Button;

Button.propTypes = {
  children: PropTypes.node,
  className: PropTypes.string,
  disabled: PropTypes.bool,
  inverted: PropTypes.bool,
  linkTo: PropTypes.string,
  primary: PropTypes.bool,
  reset: PropTypes.bool,
  secondary: PropTypes.bool,
  submit: PropTypes.bool,
};

Button.defaultProps = {
  children: [],
};
