import 'select2/dist/js/select2.full.js'
import 'select2/dist/js/i18n/pl.js'
import 'select2/dist/css/select2.min.css'

document.addEventListener('turbolinks:load', function() {
  const data = document.body.dataset
  if(data.controller === "users" && data.action === "edit"){
    $('#user_team_id').select2();
    $('#user_player_id').select2({
      minimumInputLength: 2,
      language: 'pl'
    });
  }
})