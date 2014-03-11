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

    bStateSave: true
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
    iDisplayLength : -1
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
    bStateSave: true
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
    iDisplayLength : -1
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
    bStateSave: true
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
    iDisplayLength : -1
  )

  $('table#sponsors').dataTable(
    sDom: 'T<"clear">lfrtip',
    aoColumns: [
      {"bSortable": false},
      null,
      null,
      null,
      {"bSortable": false}
      {"bSortable": false}
    ]
    bStateSave: true
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
    iDisplayLength : -1
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
    bStateSave: true
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
    iDisplayLength : -1
    bJQueryUI: true
    aaSorting: [[ 1, "asc" ]]
    sPaginationType: "full_numbers",
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  )

  $('table#incomplete_tasks').dataTable(
    sDom: '<"clear">lfrtip',
    aoColumns: [
      null,
      null,
      null,
      null,
      {"bSortable": false}
    ]
    bStateSave: true
#    oTableTools: {
#      "aButtons": [
#        "copy",
#        "print",
#        {
#          "sExtends":    "collection",
#          "sButtonText": 'Export <span class="caret" />',
#          "aButtons":    [ "csv", "xls", "pdf" ],
#          "sSwfPath": "media/swf/copy_csv_xls_pdf.swf"
#        }
#      ]
#    }
    bJQueryUI: true
    aaSorting: [[ 0, "desc" ]]
    sPaginationType: "full_numbers",
    aLengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
    iDisplayLength : -1
  )
  $(".date_picker").datepicker()

