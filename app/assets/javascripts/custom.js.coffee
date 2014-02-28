jQuery ->
  $('#projects').dataTable(
    "sDom": 'T<"clear">lfrtip',
    "oTableTools": {
      sSwfPath: "dataTables/extras/TableTools/media/swf/copy_csv_xls_pdf.swf"
    }
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      {"bSortable": false}
    ]
#    "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "oTableTools": {
    "aButtons": [
      "copy",
      "print",
      {
        "sExtends":    "collection",
        "sButtonText": 'Export <span class="caret" />',
        "aButtons":    [ "csv", "xls", "pdf" ],
        "sSwfPath": "media/swf/copy_csv_xls_pdf.swf"
      }
    ]
    }
    bJQueryUI: true
    aaSorting: [[ 1, "asc" ]]
    sPaginationType: "full_numbers",
    oLanguage: { "sLengthMenu": 'Display Records<select>'+
    '<option value="10">10</option>'+
    '<option value="20">20</option>'+
    '<option value="30">30</option>'+
    '<option value="40">40</option>'+
    '<option value="50">50</option>'+
    '<option value="-1">All</option>'+
    '</select>' }

  )

