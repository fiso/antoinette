import moment from 'moment';

export const t = datetimeString => datetimeString
  ? Number(new Date(datetimeString))
  : Number(new Date())
;

function capitalizeFirstLetter (string) {
  return string.charAt(0).toUpperCase() + string.slice(1);
}

export const dateTimeAgo = (dt, {capitalizeInitial = true} = {}) => {
  const str = moment(dt, 'YYYY-MM-DDTHH:mm:ss.SSS').fromNow();
  return capitalizeInitial
    ? capitalizeFirstLetter(str)
    : str;
};
