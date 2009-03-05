// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

initializeScrollTos = function() {
	$$('a').select(function(link) {
		return link.readAttribute('href').match(/#.*/);
	}).each(function(link) {
		link.writeAttribute('onclick', 'return false;');
		link.observe('click', function() { Effect.ScrollTo($(link.readAttribute('href').gsub('#', ''))) });
	});
}
document.observe('dom:loaded', initializeScrollTos);
