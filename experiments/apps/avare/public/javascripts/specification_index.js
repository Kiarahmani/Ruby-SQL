$(document).ready(function(){
	$('#button_approve').button();
	$('#button_accept').button();
	$('#button_decline').button();	

        $('.datepicker').datepicker({ dateFormat:'dd.mm.yy', firstDay:1, autoSize:true});


	$('#mass').click(function(){
    if (this.checked){
      $('input[name]="specification_ids"').prop("checked", true);
    }
    else{
      $('input[name]="specification_ids"').prop("checked", false);
    }
  });
});
