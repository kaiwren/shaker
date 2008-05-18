// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function initJQueryExtensions() {
  jQuery.extend(jQuery.expr[':'], {
    containsIgnoreCase: "(a.textContent||a.innerText||jQuery(a).text()||'').toLowerCase().indexOf((m[3]||'').toLowerCase())>=0"
  });
}

function adjustCss() {
  $(".instruction > img").addClass('inline-image');
  $(".guess-count > img").addClass('inline-image');
}

function doFilter(value){
  $("tr.row").removeClass('visible').addClass('hidden');
  $("tr.row:containsIgnoreCase('" + value + "')").removeClass('hidden').addClass('visible');
}

