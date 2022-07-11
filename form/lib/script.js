const subButt = document.querySelector('#createAccount');
const pass = document.querySelector('#pass').value;
const confirmPass = document.querySelector('#confirmPass').value;
const passMatch = document.querySelector('#passMatch');

subButt.addEventListener('click', passCheck);

function passCheck() {
  if (pass != confirmPass) {
    passMatch.style.visibility = 'visible';
  }
  
}