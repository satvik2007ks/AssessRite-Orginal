<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/DE/de.Master" AutoEventWireup="true" CodeBehind="Objectives.aspx.cs" Inherits="AssessRite.DE.Objectives" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }

        .hideGridColumn {
            display: none;
        }

        #loading {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(228, 228, 228, 0.31);
            z-index: 9999;
        }

        #loader {
            position: absolute;
            left: 50%;
            top: 40%;
            width: 100px;
            height: 100px;
            margin-left: -50px;
        }
         .dataTables_wrapper{
            margin-bottom:20px !important;
        }
    </style>
    <script type="text/javascript">
        function runEffect1() {
            //alert("working");
            $("#<%=myMessage1.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage1.ClientID%>").hide();
            }, 8000);
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Objectives</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Objective</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Objective</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Objective Saved Successfully"></asp:Label>
            </div>
            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnObjectivesSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary hide" Text="New" OnClick="btnNew_Click" />
                            <button id="btnNewObjective" class="btn btn-primary">New</button>

                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblClassName" runat="server" Text="Class"></asp:Label>
                        <asp:DropDownList ID="ddlClassName" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblConcepts" runat="server" Text="Concepts"></asp:Label>
                        <asp:DropDownList ID="ddlConcepts" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblObjectives" runat="server" Text="Objectives"></asp:Label>
                        <asp:TextBox ID="txtObjectives" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnObjectiveId" />
                    <a href="#" id="btnSaveObjective" class="btn btn-primary">Save</a>
                    <asp:Button ID="btnObjectivesSave" runat="server" Text="Save" CssClass="btn btn-primary hide" OnClick="btnObjectivesSave_Click" />
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive hide">
                        <asp:GridView ID="gridObjective" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridObjective_RowDataBound" OnSelectedIndexChanged="gridObjective_SelectedIndexChanged" DataKeyNames="ObjectiveId">
                            <Columns>
                                <asp:BoundField DataField="ClassName" HeaderText="Class" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="SubjectName" HeaderText="Subject" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ConceptName" HeaderText="Concept" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ObjectiveName" HeaderText="Objective" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ClassId" HeaderText="ClassId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="SubjectId" HeaderText="SubjectId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="ConceptId" HeaderText="ConceptId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">ObjectiveId</th>
                                    <th style="display: none">ConceptId</th>
                                    <th style="display: none">SubjectId</th>
                                    <th style="display: none">ClassId</th>
                                    <th>ClassName</th>
                                    <th>SubjectName</th>
                                    <th>ConceptName</th>
                                    <th>ObjectiveName</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-1"></div>
                        <div class="col-md-10" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteObjective" style="display: none; margin: 0 auto">Delete</button>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="H3">Delete ?</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
                                <div class="modal-body">Deleting this Objective might impact all its dependencies. Are you sure you want to delete this Objective?</div>
                                <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary hide" OnClick="btnYes_Click" />
                                    <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
            </div>
            <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>
    <script type="text/javascript">
        function openModal() {
            //  jQuery.noConflict();
            $("#myModal").modal("show");
        }
    </script>
    <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            $('#liObjectives').addClass('current-menu-item');
            //$('#liObjectives1').addClass('current-menu-item');
            $('#subjectname').addClass('active');

        });
    </script>
    <%-- <script>
        function pageLoad(sender, args) {
            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();

            $(".dataTable").DataTable();
            //  $(".dataTable").tablesorter({ sortList: [[1, 0]] });
        }
    </script>--%>
    <script>
        var table;
        $(document).ready(function () {
            loadClass();
            loadtable(0);
            $(document).ajaxStart(function () {
               
               // $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                // window.clearTimeout($("#loading").hide().data('timeout'));
                //if($("#myTable_filter").find('[type=search]').val()!='')
                //{
                //    $("#myTable_filter").find('[type=search]').val('');
                //    loadtable(0);
                //}
            });
          
           
            //$("#myTable").on('page.dt', function () {
            //    var info = table.page.info();
            //    alert('Currently showing page ' + (info.page + 1) + ' of ' + info.pages + ' pages.');
            //});
        });



        function loadClass() {
            var ddlClassDropDownListXML = $('#<%=ddlClassName.ClientID%>');
            ddlClassDropDownListXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/LoadObjectiveDropdownsClass",
                data: '{tableName: "' + tableName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    //  console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('ClassId').text();
                        var OptionText = $(this).find('ClassName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlClassDropDownListXML.append(option);
                    });
                    $('#<%=ddlClassName.ClientID%>').prepend('<option value="-1" selected="selected">--Select Class--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $('#<%=ddlClassName.ClientID%>').change(function () {
            var getclassid = $('#<%=ddlClassName.ClientID%>').val();
            loadSubject(getclassid, "-1");
        });

        function loadSubject(classid, selectvalue) {
            var ddlSubjectDropDownListXML = $('#<%=ddlSubject.ClientID%>');
            ddlSubjectDropDownListXML.empty();
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/LoadObjectiveDropdownsSubject",
                data: '{classid: "' + classid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // console.log(response.d);
                     $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table2').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('SubjectId').text();
                        var OptionText = $(this).find('SubjectName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlSubjectDropDownListXML.append(option);
                    });
                    $('#<%=ddlSubject.ClientID%>').prepend('<option value="-1" selected="selected">--Select Subject--</option>');
                },
                error: function (response) {
                     $("#<%=lblError.ClientID%>").html('No Subjects Found For This Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlSubject.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlSubject.ClientID%>").val(selectvalue);
                    if (selectvalue != "-1") {
                        loadConcept(selectvalue);
                    }
                }
            }, 200);
        }

        $('#<%=ddlSubject.ClientID%>').change(function () {
            var getSubjectid = $('#<%=ddlSubject.ClientID%>').val();
            loadConcept(getSubjectid);
        });

        function loadConcept(subjectid) {
            var ddlConceptDropDownListXML = $('#<%=ddlConcepts.ClientID%>');
             ddlConceptDropDownListXML.empty();
             $.ajax({
                 type: "POST",
                 url: "../WebMethods/GetData.asmx/LoadObjectiveDropdownsConcept",
                 data: '{subjectid: "' + subjectid + '"}',
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     // console.log(response.d);
                       $("#<%=divError.ClientID%>").css("display", "none");
                     var xmlDoc = $.parseXML(response.d);
                     // console.log(xmlDoc);
                     // Now find the Table from response and loop through each item (row).
                     $(xmlDoc).find('Table3').each(function () {
                         // Get the OptionValue and OptionText Column values.
                         var OptionValue = $(this).find('ConceptId').text();
                         var OptionText = $(this).find('ConceptName').text();
                         // Create an Option for DropDownList.
                         var option = $("<option>" + OptionText + "</option>");
                         option.attr("value", OptionValue);
                         ddlConceptDropDownListXML.append(option);
                     });
                     $('#<%=ddlConcepts.ClientID%>').prepend('<option value="-1" selected="selected">--Select Concept--</option>');
                },
                error: function (response) {
                      $("#<%=lblError.ClientID%>").html('No Concepts Found For This Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });

        }

        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetObjectiveData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        stateSave: false,
                        columns: [
        { className: "hide", data: 'ObjectiveId' },
        { className: "hide", data: 'ConceptId' },
         { className: "hide", data: 'SubjectId' },
         { className: "hide", data: 'ClassId' },
        { data: 'ClassName' },
        { data: 'SubjectName' },
        { data: 'ConceptName' },
        { data: 'ObjectiveName' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            //$(this).siblings('.selected').removeClass('selected');
            //$(this).addClass('selected');
            if ($(this).hasClass('selected')) {
             //   $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveObjective").html('Update');
            // $("#id").css("display", "none");
            $("#btnDeleteObjective").css("display", "block");
            var classId = $(this).find('td:nth-child(4)').text();
            var subjectId = $(this).find('td:nth-child(3)').text();
            var conceptId = $(this).find('td:nth-child(2)').text();
            $('#hdnObjectiveId').val($(this).find('td:nth-child(1)').text());
            $("#<%=ddlClassName.ClientID%>").val(classId);
            loadSubject(classId, subjectId);
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlConcepts.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlConcepts.ClientID%>").val(conceptId);
                  }
            }, 600);
            $('#<%=txtObjectives.ClientID%>').val($(this).find('td:nth-child(8)').text());
            //   $("#myTable").on('page.dt', function () {
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
            //  alert('currently showing ' + $('#hdnpage').val());
            //  alert('Currently showing page ' + (info.page + 1) + ' of ' + info.pages + ' pages.');
            //  });
        });

        $(function () {
            $("[id*=btnSaveObjective]").click(function () {
                //  alert('fd');
                var trimmedValue = jQuery.trim($('#<%=txtObjectives.ClientID%>').val());
                if ($("#<%=ddlClassName.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlSubject.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlConcepts.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Concept');
                      $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                  }
                  else if ($("#<%=txtObjectives.ClientID%>").val() == '') {
                      $("#<%=lblError.ClientID%>").html('Please Enter Objective');
                    $("#<%=divError.ClientID%>").css("display", "block");
                      return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Objective Cannot Be Blank');
                          $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                      }
                      else {
                          $("#<%=divError.ClientID%>").css("display", "none");
                      }
                var obj = {};
                //obj.ids = [];
                obj.classid = $.trim($("[id*=<%=ddlClassName.ClientID%>]").val());
                obj.subjectid = $.trim($("[id*=<%=ddlSubject.ClientID%>]").val());
                obj.conceptid = $.trim($("[id*=<%=ddlConcepts.ClientID%>]").val());
                obj.objective = $.trim($("[id*=<%=txtObjectives.ClientID%>]").val());
                obj.buttontext = $("#btnSaveObjective").html();
                obj.objectiveid = "0";
                if ($('#hdnObjectiveId').val() != '') {
                    obj.objectiveid = $.trim($("[id*=hdnObjectiveId]").val());
                }
                $.ajax({
                    type: "POST",
                    url: "Objectives.aspx/SendParameters",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                      

                        if (r.d == 'Objective Already Found') {
                            $("#<%=lblError.ClientID%>").html('Objective Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Objective Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Objective Updated Successfully');
                          }
                        if (r.d == 'Objective Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Objective Saved Successfully');
                          }
                        runEffect1();
                        clear();
                        loadClass();
                    }
                });
                return false;
            });
        });


          $(function () {
              $("[id*=btnDeleteYes]").click(function () {
                  // alert('fd');
                  var objDelete = {};
                  objDelete.objectiveid = $.trim($("[id*=hdnObjectiveId]").val());
                  $.ajax({
                      type: "POST",
                      url: "Objectives.aspx/DeleteObjective",
                      data: JSON.stringify(objDelete),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (r) {
                          // alert(r.d);
                          $('#myTable').DataTable().destroy();
                          $('#myTable tbody').empty();
                          var pagenum = parseInt($('#hdnpage').val()) - 1;
                          loadtable(pagenum);
                          loadClass();
                          if (r.d == 'Objective Deleted Successfully') {
                              $("#<%=lblMsg.ClientID%>").html('Objective Deleted Successfully');
                            runEffect1();
                        }
                    }
                });
                $('#myModal1').modal('hide');
                clear();
                return false;
            });
        });


        $(function () {
            $("[id*=btnNewObjective]").click(function () {
                clear();
                return false;
            });
        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveObjective").html('Save');
            $("#btnDeleteObjective").css("display", "none");
            $("#<%=ddlClassName.ClientID%>").val('-1');
            //  $("#<%=ddlSubject.ClientID%>").val('-1');
            $('#<%=ddlSubject.ClientID%>').empty();
            $('#<%=ddlConcepts.ClientID%>').empty();
            $('#<%=txtObjectives.ClientID%>').val('');
            $("[id*=hdnObjectiveId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
        }
    </script>
</asp:Content>
