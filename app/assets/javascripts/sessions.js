// Called when the user asks for
// the Google spreadsheet
var getSheetData = function(event) {
    console.log('Message 6: in getSheetData');
    $.ajax({
        url: '/spreadsheet/getdata',
        success: getdataSuccess,
        error: ajaxError,
        dataType: "json",
        beforeSend: function () {
            $('#spinner').show();
        },
    });
};

// Callback when we get the Google Spreadsheet
var getdataSuccess = function(data, status) {
    var arrayLength, i, key, myobject, snippet, oneRow, $data, bigstring;
    // data is an array of objects
    // The following displays the data on screen
    console.log('Message 22: getting data was successful');
    $('#spinner').hide();

    $data = $('.data');
    bigstring = '';
    bigstring += '<table id="data-area">';
    arrayLength = data.length;
    for (i = 0; i < arrayLength; i++) {
        oneRow = '<tr>';
        myobject = data[i];
        for (key in myobject) {
            if (myobject.hasOwnProperty(key)) {
                // This adds each field
                snippet = '<td>'+ myobject[key] + '</td>';
                oneRow = oneRow + snippet;
            }
        }
        oneRow = oneRow + '</tr>'
        bigstring += oneRow;
    }
    bigstring += '</table>';
    $data.append(bigstring);

};

// Called if there's an error when asking for the Google Spreadsheet
var ajaxError = function(jqXHR, status, error) {
    $('#spinner').hide();
    console.log('Message 14: There has been an Ajax error.');
    console.log('Message 15: Status, responseText, and error follow.');
	console.log(status);
    console.log(jqXHR.responseText);
	console.log(error);
    $data = $('.data');
    $data.append(jqXHR.responseText);
};

$(document).ready(function() {
    console.log( "You are running jQuery version: " + $.fn.jquery );

    $(".get-data").on("click", null, null, getSheetData);

});  // end- document.ready
