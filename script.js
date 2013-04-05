$(main);

var image_width;

function main() {
    $("a.img_link").click(load_image);
    $("body").addClass("loaded");
    $("td.text p").map(mfm_to_highlights);
    $("td.lnum").map(add_line_numbers);
    standardize_widths();
    $("tr.notes ul").css("display", "block");
};


function standardize_widths() {
    var max_width = 0;
    function test_width() {
        max_width = Math.max(max_width, $(this).width());
    }
    $("td.text").map(test_width);
    var em_size = parseFloat($("body").css("font-size"));
    var text_width =  max_width/em_size;
    if(text_width > 40) {text_width = 40;}
    $("td.text").width(text_width + "em");
    $("tr.notes ul").width(text_width + 5 + "em");
    image_width = (text_width) + "em";
    $("#title, .note_block").width($("table").width());
}


function add_line_numbers() {
    //find text
    var text = $(this).siblings("td:last").text();
    var line_count = text.split("\n").length;
    var count = 1;
    var line_num_string = "";
    while(count < line_count) {
        line_num_string += count + "\n";
        count++;
    }
    $(this).append($("<p>" + line_num_string + "</p>"));
}

function load_image(ev) {
    $(this).parent().removeClass("img_ph");
    var src = $(this).attr("href");
    var img = $("<div class='img_cont'><a href='" + src +"\'><img src='" + src + "'/></a></div>");
    img.width(image_width);
    $(this).replaceWith(img);
    return false;
};


function mfm_to_highlights() {
    var text = $(this).html();
    if(text.search(/{{|}}/) == -1) {return;}
    text = text.replace(/{{/g, "<span class='highlight'>");
    text = text.replace(/}}/g, "</span>");
    $(this).replaceWith($("<p>" + text + "</p>"));
};


function hide_simple() {
    $("table.page").hide();
    $("table.block_formatting").show();
}