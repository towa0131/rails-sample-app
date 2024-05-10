$(document).on('turbo:load', function () {
  document.getElementById('profile').addEventListener('click', () => {
    $('.ui.modal').modal('show')
  });
})