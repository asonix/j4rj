function navDropdown () {
  function setup () {
    var expands = document.getElementsByClassName('expand');
    var eactive = [];
    for (var i = 0; i < expands.length; ++i) {
      eactive[i] = false;
      
      expands[i].onmouseover = (function (dropdown, iter) {
        return function () {
          if (!eactive[iter]) {
            eactive[iter] = true;
            dropdown.getElementsByClassName ('content')[0].className = 'content show';
          }
        }
      })(expands[i], i);
      
      expands[i].onmouseout = (function (dropdown, iter) {
        return function () {
          if (eactive[iter]) {
            dropdown.getElementsByClassName ('content')[0].className = 'content hide';
            eactive[iter] = false;
          }
        }
      })(expands[i], i);
    }
  }
  setup();
}