function hideall() {
	$(".parcours, .specialite, .intervenants, .intervenant, .unite").hide();
}

$(".menunav").click(function () {
	hideall();
	$(".menunav").parent().removeClass("active");
	$(this).parent().addClass("active");
	$($(this).attr("href")).fadeIn();
});

$(".lien").click(function () {
	hideall();
	$($(this).attr("href")).fadeIn();
});


$(document).ready(function() {
	hideall();
});