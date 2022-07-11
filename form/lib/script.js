
const passMatch = document.querySelector('#passMatch');
const theForm = document.querySelector('#theForm');

theForm.addEventListener('submit', passCheck);

function passCheck(form) {
  const whatAPain = form.target;

  if (theForm.pass.value != theForm.confirmPass.value) {  
    passMatch.style.visibility = 'visible';
  }
  if (whatAPain.checkValidity()) {
    if (theForm.pass.value != theForm.confirmPass.value) {  
      passMatch.style.visibility = 'visible';
      form.preventDefault();
    }
  } else {
    form.preventDefault();
  }
 
  
  
}