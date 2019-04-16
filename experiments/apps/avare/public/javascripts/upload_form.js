$(document).ready(function(){
  $('#mass').click(function(){
    if (this.checked){
      $('input[name]="upload_ids"').prop("checked", true);
    }
    else{
      $('input[name]="upload_ids"').prop("checked", false);
    }
  });
});
