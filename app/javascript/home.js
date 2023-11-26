window.onload = function(){
  console.log('loaded')
  const formElem = document.getElementById("form_letter")
  const pbButton = document.getElementById("show_pb_number")

  formElem.onsubmit = async (e) => {
    e.preventDefault();
    console.log('wow');
    var url = formElem.getAttribute("action");
    var data =  new FormData(formElem);
    data.append("submit", "Submit");
    await fetch(url, { method: 'POST', body: data }).then((response) => {
      if (response.status >= 400 && response.status < 600) {
        throw new Error("Сталась помилка. Будь ласка надішли листа на warm_hearts@uncommercial.org");
      }
      return response;
    }).then(() => {
      document.getElementById("letter_front_side").style.display = "none";
      document.getElementById("letter_back_side").style.display = "block";
    }).catch((error) => {
      alert(error)
    });
  };

  pbButton.onclick = function () {
    pbButton.innerHTML = "5168 7520 1327 7994";
  }
};
