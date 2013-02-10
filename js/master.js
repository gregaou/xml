$(".menunav").click(function () {
	$(".parcours, .specialite").hide();
	$(".menunav").parent().removeClass("active");
	$(this).parent().addClass("active");
	$($(this).attr("href")).fadeIn();
});

$(document).ready(function() {
	$(".parcours, .specialite").hide();
	$('.navbar').affix();
	$('[data-spy="affix"]').each(function () {
  $(this).affix('refresh')
});
});