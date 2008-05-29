// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function initJQuery() {
    jQuery.extend(jQuery.expr[':'], {
      containsIgnoreCase: "(a.textContent||a.innerText||jQuery(a).text()||'').toLowerCase().indexOf((m[3]||'').toLowerCase())>=0"
    });

    $("#filter-users").bind('keyup', function() {
        $("tr.row").removeClass('visible').addClass('hidden');
        $("tr.row:containsIgnoreCase('" + this.value + "')").removeClass('hidden').addClass('visible');
    });

}

function adjustCss() {
    $(".instruction > img").addClass('inline-image');
    $(".guess-count > img").addClass('inline-image');
}

function watch_user(target_id, listening_id) {
    //$.post("/watchers/create", { target_user: target_id, listening_user: listening_id });
    $.ajax({
        type: "POST",
        data: { target_user: target_id, listening_user: listening_id },
        url: "/watchers/create",
        cache: false,
        success: function(html) {
            $("#ajax_response_"+target_id).replaceWith(html);
        }
    });
}

function unwatch_user(watcher_id, target_id) {
//    $.post("/watchers/" + listening_id, {_method: 'delete'});
    $.ajax({
        type: "POST",
        data: {_method: 'delete'},
        url: "/watchers/" + watcher_id,
        cache: false,
        success: function(html) {
            $("#ajax_response_"+target_id).replaceWith(html);
        }
    });
}
