jQuery(document).ready(function() {

  $('.top_link').click(function() {
    window.scroll(0,0);
  });

  ////// drop downs:
  $('.drop_down_component').each(  function() {
    // hide drop down's to start
    $(this).find('.drop_down').hide();

    $(this).find('.drop_down_link').click( function() {
      var dropDownComponent = $(this).parent();
      var arrowImage = $(this).children().eq(0);
      if (/shown/.exec(dropDownComponent.attr('class') ) == null) {
        dropDownComponent.addClass('shown');
        $(this).next('.drop_down').slideToggle();
        $(this).find('.show_hide_toggle').text('Hide:');
        arrowImage.rotateRight();
      } else {
        hideDropDown($(this).next('.drop_down'));
      }

    });
  } );

  $('.drop_down_get_started').each(function() {
    $(this).click( function() {
      var clicked = $(this);
      // first unslide toggle whatever was open before it:
      var previously_shown = $('.shown_get_started_drop_down');
      if (previously_shown.length == 1) {
        // something is shown, remove it:
        previously_shown.eq(0).removeClass('shown_get_started_drop_down');
        var previously_clicked = $('.clicked_get_started_icon');
        previously_clicked.removeClass('clicked_get_started_icon');
        previously_shown.eq(0).slideToggle('normal', function() {
          slideUp(previously_clicked, clicked);
        });
      }
      else {
        slideUp(null,$(this));
      }

    })
  });

  $('.hide_box_button').each(function() {
    $(this).click( function() {
      var dropDown = $(this).parent();
      hideDropDown(dropDown);
    });
  });

  $('.hide_box_button_get_started').each(function() {
    $(this).click( function() {
      drop_down.addClass('shown_get_started_drop_down');
      clicked.addClass('clicked_get_started_icon');
      slideUp(null,$(this));

    });
  });

});

function slideUp(previously_clicked, clicked) {
  if ((previously_clicked != null) && previously_clicked.attr('id') == clicked.attr('id')) {
    return;
  }
  var drop_down = $("#drop_down_for_" + clicked.attr('id'));
  drop_down.addClass('shown_get_started_drop_down');
  clicked.addClass('clicked_get_started_icon');
  drop_down.slideToggle('normal');
}

function hideDropDown(dropDown) {
  var dropDownLink = dropDown.prev();
  var dropDownComponent = dropDownLink.parent();
  var arrowImage = dropDownLink.children().eq(0);
  dropDownComponent.removeClass('shown');
  arrowImage.rotateLeft();
  dropDown.slideToggle();
  dropDownLink.find('.show_hide_toggle').text('Show:');
}