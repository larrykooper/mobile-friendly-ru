'use strict';
// jQuery v 1.12.4

// Because we are using Turbolinks, we can't use jQuery
// document.ready and must use this
document.addEventListener("turbolinks:load",(doOnDocumentReady));

function doOnDocumentReady() {
  // Set up events and handlers

  $('.sorting-arrows').click(function() {
    $('#sorting-dialog').modal();
  });

  // button in the sort dialog
  $('.btn-primary').click(sortRows);

  // When user touches a row on the main page
  $('.row').click(showRow);

  // User touches the magnifying glass
  $('.magnifier-span').click(showSearchPage);

  $(document).on("keypress", "input#search-box", function(e){
    if (e.which == 13) {
      doSearch(this.value);
    }
  });

} // doOnDocumentReady

function doSearch(query) {
  var html, i, item, keys, longdesc, num_items;
  query = query.toLowerCase();
  keys = Object.keys(localStorage);
  num_items = keys.length;

  for (i = 0; i < num_items; i++) {
    item = localStorage.getItem(keys[i]);
    if (item && item != 'undefined') {
      item = JSON.parse(item);
      longdesc = item.long_description;
      if (longdesc.toLowerCase().indexOf(query) > -1) {
        html = HandlebarsTemplates['search_result']({long_description: longdesc});
        $('.results').append(html);
      }
    }
  }

}

function sortRows() {
  closeDialog();
  var $rows = $('.row');
  $rows.sort(compareFunction);
  $('.rows-container').html($rows);
}

function showRow(event) {
  var item, ruNumber, state;
  ruNumber = $(this).data("item-number");
  item = localStorage.getItem(ruNumber);
  item = JSON.parse(item);
  state = {page: "mainpage"};
  history.pushState(state, "Item Page", "item/" + ruNumber);
  renderRow(item);
}

function renderRow(item) {
  var html;
  html = HandlebarsTemplates['full_item'](item);
  $("body").html(html);
}

function showSearchPage() {
  var state;
  var html = HandlebarsTemplates['search_page']();
  state = {page: "mainpage"};
  history.pushState(state, "Search", "search");
  $("body").html(html);
}

function closeDialog() {
  $('#sorting-dialog').modal('hide')
};

function compareFunction(row1, row2) {
  var comp1 = getInOut(row1);
  var comp2 = getInOut(row2);
  var comp1Outside = isOutside(comp1);
  var comp2Outside = isOutside(comp2);
  if (comp1Outside && !comp2Outside) {
    return -1;
  }
  if (!comp1Outside && comp2Outside) {
    return 1;
  }
  if (comp1 > comp2) {
    return 1;
  };
  if (comp1 < comp2) {
    return -1;
  } else {
    return 0;
  }
}

function getInOut(row) {
  var $j = $(row);
  var text =  $j.find('.outside-inside').html();
  return text.trim();
}

function isOutside(str) {
  var beginning = str.substring(0, 7);
  return beginning.toLowerCase() == 'outside';
}

function writeToLocalIfNeeded(item) {
  // TODO: IF WE HAVE ALREADY CACHED THE LIST in the last 24 hours, RETURN
  localStorage.setItem(item.ru_number, JSON.stringify(item));
}
