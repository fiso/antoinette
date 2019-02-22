import PropTypes from 'prop-types';
import React from 'react';

const Image = React.memo(({sizes, alt, url, className}) => {
  const srcSet = sizes && Object.keys(sizes).reduce((acc, key) => {
    const value = sizes[key];
    if (typeof value !== 'string') {
      return acc;
    }

    return `${acc}${acc.length > 0 ? ', ' : ''}${value} ${sizes[key + '-width']}w`;
  }, '');

  const ending = url.substr(url.lastIndexOf('.') + 1);
  const sources = [];
  if (['jpg', 'jpeg'].indexOf(ending.toLowerCase()) !== -1) {
    if (process.env.NODE_ENV === 'production') {
      sources.push(
          <source key='webp' srcSet={srcSet.replaceAll(ending, 'webp')}
            type='image/webp' />
      );
    }
  }
  const mime =
    `image/${ending.toLowerCase() === 'jpg' ? 'jpeg' : ending.toLowerCase()}`;
  sources.push(<source key='orig' srcSet={srcSet} type={mime} />);

  return (
    <picture className={className}>
      {sources}
      <img srcSet={srcSet} alt={alt} src={url} />
    </picture>
  );
});

export default Image;

Image.propTypes = {
  alt: PropTypes.string,
  className: PropTypes.string,
  sizes: PropTypes.object,
  url: PropTypes.string,
};

Image.defaultProps = {
  className: '',
};
