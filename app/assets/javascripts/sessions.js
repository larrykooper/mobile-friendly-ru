'use strict';

$(document).ready(function() {
  // jQuery v 1.12.4

  $('.sorting-arrows').click(function() {
    $('#sorting-dialog').modal();
  });

  $('.btn-primary').click(sortRows);

  $('.row').click(showRow);

});  // end- document.ready


function sortRows() {
  closeDialog();
  var $rows = $('.row');
  $rows.sort(compareFunction);
  $('.rows-container').html($rows);
}

function showRow(event) {

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
  // TODO: IF WE HAVE ALREADY CACHED THE LIST, RETURN
  //console.log("hello from write to local. item follows");
  //console.log(item);
  localStorage.setItem(item.ru_number, JSON.stringify(item));
  var a = 3;  // debug
}
