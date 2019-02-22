export function copyToClipboard (text) {
  const temp = document.createElement('textarea');
  document.body.appendChild(temp);
  temp.value = text;
  temp.select();
  document.execCommand('copy');
  temp.remove();
}
