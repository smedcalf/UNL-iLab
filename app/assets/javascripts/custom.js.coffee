jQuery ->
  $('table#projects').dataTable(
    sDom: 'T<"clear">lfrtip'
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
    oTableTools: {
    aButtons: [
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
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

  $('table#students').dataTable(
    sDom: 'T<"clear">lfrtip',
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      null,
      null,
      null,
#      null,
      null,
      {"bSortable": false}
    ]
    oTableTools: {
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
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

  $('table#teams').dataTable(
    sDom: 'T<"clear">lfrtip',
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      {"bSortable": false},
      {"bSortable": false}
      {"bSortable": false}
    ]
    oTableTools: {
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
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

  $('table#sponsors').dataTable(
    sDom: 'T<"clear">lfrtip',
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      {"bSortable": false},
      {"bSortable": false}
      {"bSortable": false}
    ]
    oTableTools: {
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
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

  $('table#users').dataTable(
    sDom: 'T<"clear">lfrtip',
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      {"bSortable": false}
    ]
    oTableTools: {
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
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

