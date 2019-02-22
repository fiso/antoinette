import React, {PureComponent} from 'react';
import autoBind from 'react-autobind';
import classNames from 'classnames';
import iconLinkArrow from '~/images/link-arrow.svg';
import Image from '~/js/app/components/common/Image';
import PropTypes from 'prop-types';
import styleVars from '~/scss/_variables.scss';
import './Carousel.scss';

const breakTablet = parseInt(styleVars.breakTablet, 10);

export default class Carousel extends PureComponent {
  constructor (props) {
    super(props);
    autoBind(this);
    this.state = {
      currentSlideOffset: 0,
      windowWidth: window.innerWidth,
    };
    this.ref = React.createRef();
  }

  componentDidMount () {
    const el = this.ref.current;
    el.addEventListener('swipeleft', this.onSwipeLeft);
    el.addEventListener('swiperight', this.onSwipeRight);
    window.addEventListener('resize', this.onResize);
  }

  componentWillUnmount () {
    const el = this.ref.current;
    el.removeEventListener('swipeleft', this.onSwipeLeft);
    el.removeEventListener('swiperight', this.onSwipeRight);
    window.removeEventListener('resize', this.onResize);
  }

  onSwipeLeft (event) {
    event.stopPropagation();
    this.nextSlide();
  }

  onSwipeRight (event) {
    event.stopPropagation();
    this.prevSlide();
  }

  onResize () {
    this.setState({windowWidth: window.innerWidth});
  }

  nextSlide () {
    const {currentSlideOffset} = this.state;
    this.setSlide(currentSlideOffset + 1);
  }

  prevSlide () {
    const {currentSlideOffset} = this.state;
    this.setSlide(currentSlideOffset - 1);
  }

  setSlide (index) {
    const {children, onChangeSlide} = this.props;
    const slots = this.getDisplayedSlots();

    const maxAllowed = children.length - slots;
    if (index < 0 || index > maxAllowed) {
      return;
    }

    this.setState({currentSlideOffset: index});
    if (onChangeSlide) {
      onChangeSlide(index);
    }
  }

  onClickIndicator (e) {
    this.setSlide(Number(e.target.dataset.index));
  }

  onClickArrow (e) {
    if (e.target.dataset.direction === 'left') {
      this.prevSlide();
    } else {
      this.nextSlide();
    }
  }

  getDisplayedSlots () {
    const {windowWidth} = this.state;
    const {slots} = this.props;
    if (this.state.windowWidth <= breakTablet) {
      return 1;
    } else if (windowWidth <= 1200) {
      return Math.min(slots, 2);
    }

    return slots;
  }

  render () {
    const {arrows, children, className, fastAdvance, onChangeSlide: _,
      indicators} = this.props;
    const {currentSlideOffset} = this.state;
    const slots = this.getDisplayedSlots();
    const offset = -(100 / slots) * currentSlideOffset;
    const lastVisible = currentSlideOffset + slots - 1;
    const arrowsVisible = arrows && children.length > slots;

    return (
      <div
        ref={this.ref}
        onClick={fastAdvance ? this.nextSlide : null}
        className={`carousel ${className || ''}`}
      >
        <div
          className='carousel-inner'
          style={{
            transform: `translateX(${offset}%)`,
          }}
        >
          {children.map((child, i) =>
            <div key={i} style={{flexBasis: `calc(100% / ${slots})`}}
              className={classNames('carousel-element', {
                'in-view': i >= currentSlideOffset && i <= lastVisible,
                'first-visible': i === currentSlideOffset,
                'last-visible': i === lastVisible,
              })}>
              {child}
            </div>
          )}
        </div>
        {indicators &&
          <div className='position-indicators'>
            {children.map((_, i) =>
              <div key={i} className={i === currentSlideOffset ? 'active' : ''}
                data-index={i}
                onClick={this.onClickIndicator} />
            )}
          </div>
        }
        {arrowsVisible &&
          <React.Fragment>
            <div className='nav-arrow' data-direction='left'
              onClick={this.onClickArrow}>
              <Image url={iconLinkArrow} /></div>
            <div className='nav-arrow' data-direction='right'
              onClick={this.onClickArrow}>
              <Image url={iconLinkArrow} /></div>
          </React.Fragment>
        }
      </div>
    );
  }
}

Carousel.propTypes = {
  arrows: PropTypes.bool,
  children: PropTypes.node,
  className: PropTypes.string,
  fastAdvance: PropTypes.bool,
  indicators: PropTypes.bool,
  onChangeSlide: PropTypes.func,
  slots: PropTypes.number,
};

Carousel.defaultProps = {
  children: [],
  slots: 3,
};
