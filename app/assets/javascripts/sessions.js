'use strict';

$(document).ready(function() {
  // jQuery v 1.12.4

  $('.sorting-arrows').click(function() {
    $('#sorting-dialog').modal();
  });

  $('.btn-primary').click(sortRows);

});  // end- document.ready


function sortRows() {
  var $rows = $('.row');
  $rows.sort(compareFunction);
  $('.rows-container').html($rows);
}

function compareFunction(row1, row2) {
  var comp1 = getInOut(row1);
  var comp2 = getInOut(row2);
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

