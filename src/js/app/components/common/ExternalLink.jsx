import PropTypes from 'prop-types';
import React from 'react';

const ExternalLink = React.memo(({children, to, ...props}) =>
  <a rel='noopener noreferrer' target='_blank' href={to} {...props}>
    {children}
  </a>
);

export default ExternalLink;

ExternalLink.propTypes = {
  children: PropTypes.node,
  to: PropTypes.string,
};

ExternalLink.defaultProps = {
  children: [],
};
