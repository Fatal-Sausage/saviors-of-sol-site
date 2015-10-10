// Super simple script for searching

$(document).ready(function(){

  $platform_pic = $("#platform-pic");
  $gamertag = $("#gamertag");

  // Listener on the gamertag search button
  $("#gamertag-search").on("click", function(){

    // Send a get request to be handle by the platers controller index method
    $.ajax({
      path: '/',
      method: "GET",
      dataType: "json",
      data: { gamertag: $("#gamertag-input").val(), platform: $("input[name=platform]:checked").val() },
      success: function(response) {
        var player = response.player
        console.log(player);

        // Popluate the platform picture with the player icon
        $platform_pic.attr('src', 'http://www.bungie.net' + player.icon_path);

        // Set the text of the gamertag element to the correct name
        $gamertag.text(player.display_name);

        var html = "";

        // Iterate through each character for that player
        $.each(player.characters, function() {

          // Add a div for the character id and background image
          html += "<div class='character' data-cid='" + this.character_id + "' style='background-image: url(" + this.background + ")'>";

          // Add a div for the emblem
          html += "<div class='emblem'><img height='87' src='" + this.emblem + "'></div>";

          // Add a div for the class and race
          html += "<div class='details'><h2>" + this.cls + "</h2><h5>" + this.race + "</h5></div>";

          // Add a div for the base and light levels
          html += "<div class='levels'><span class='baselvl'>" + this.base_level + "</span><span class='light'>" + this.light_level + "</span></div>";
          html += "</div>"
        });

        // Append the character box element with the new chracter html string
        $("#charbox").html(html);
        $("#chars").show();
      }
    });
  });
});
