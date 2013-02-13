$(main);

function main() {
    $("a.page_ref").click(toggle_folded);
    $("a.img_link").click(load_image);
}


function toggle_folded(ev) {
    var next_row = $(this).parents("tr:first").next();
    next_row.toggleClass("folded");
    var img_link = next_row.find("a.img_link");
    if(img_link.length) {
        load_image(img_link, $(this).text());
    }
    ev.preventDefault();
}

function load_image(el, t) {
    var src = el.attr("href");
    var img = $("<td class='img' colspan='2' class='img_cont'>"
                + "<a href='" + src +"\'>"
                + "<img src='" + src + "'/>"
                + "</a>"
                + "<p><a href='" + viewer_file() + t + "'>Open page in viewer</a></p>"
                + "</td>");
    el.parents("td:first").replaceWith(img);
};

function viewer_file() {
    var s = window.location.href;
    s = s.slice(0, s.search(/-index.html/));
    s += ".html#pg";
    return s;
}