$(function(){
  $(".tab a").click(function(){
    var $tabs = $(this).parents(".tabs");
    $tabs.find(".tab").removeClass('selected');
    $(this).parent('li').addClass('selected');
    $tabs.find(".pane").removeClass("selected");
    $($(this).attr("href")).addClass('selected');
    return false;
  });
});
