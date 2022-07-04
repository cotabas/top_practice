const themeButton = document.querySelector('#theme-toggle');
let root = document.documentElement;
let counter = 1;

themeButton.addEventListener('click', toggle);

function toggle() {

  if (counter % 2 == 0) {
    root.style.setProperty('--img_filt', ' ');
  } else {
    root.style.setProperty('--img_filt', 'sepia()');
  }
  counter++
}
