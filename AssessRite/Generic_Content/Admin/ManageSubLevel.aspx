<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="ManageSubLevel.aspx.cs" Inherits="AssessRite.Generic_Content.Admin.ManageSubLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
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
        .custom-checkbox td{
            padding:5px;
        }
        .custom-checkbox td label{
            margin-left:2px;
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
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Delete Sub-Level</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-6" style="text-align: center">Add Sub-Level</div>
                <div class="col-lg-6" style="text-align: center">View / Delete Sub-Level</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="sub-Level Saved Successfully"></asp:Label>
            </div>
            <asp:HiddenField ID="hdnvalue" runat="server" />
            <div class="row">
                <div class="col-lg-6">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewSubLevel" class="btn btn-primary hide">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblInstitutionType" runat="server" Text="Institution Type"></asp:Label>
                        <asp:DropDownList ID="ddlInstitutionType" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Curriculum Type"></asp:Label>
                        <asp:DropDownList ID="ddlCurriculumType" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Level"></asp:Label>
                        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group" id="divClass" style="display:none">
                        <asp:Label ID="Label3" runat="server" Text="Class"></asp:Label>
                        <asp:CheckBoxList ID="chkClass" runat="server" RepeatDirection="Horizontal" CssClass="custom-checkbox">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div class="form-group" id="divSubLevel">
                        <asp:Label ID="lblSubLevel" runat="server" Text="Sub-Level"></asp:Label>
                        <asp:TextBox ID="txtSubLevel" runat="server" CssClass="form-control" ValidationGroup="g" MaxLength="25" placeholder="Enter Sub-Level"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnSubLevelId" />
                    <a href="#" id="btnSaveSubLevel" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-6" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Sub-Level</th>
                                    <th style="display: none">SubLevelId</th>
                                    <th style="display: none">MasterClassId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteClass" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H3">Delete ?</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">Deleting this sub-Level might impact all its dependencies. Are you sure you want to delete this Sub-Level?</div>
                            <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
            </div>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <asp:HiddenField ID="hdnCountry" runat="server" />
    <asp:HiddenField ID="hdnState" runat="server" />
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
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liClass').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');
        });
    </script>
    <script>
        function pageLoad(sender, args) {
            $('.onlynumber').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39) ||
                    (e.keyCode == 189 || e.keyCode == 107)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });
        }
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadInstitutionType();
            loadtable(0);
            $(document).ajaxStart(function () {
                // $("#loading").show();
                $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                // $("#loading").hide();
                window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });

         function loadInstitutionType() {
            var ddlInstitutionTypeXML = $('#<%=ddlInstitutionType.ClientID%>');
            ddlInstitutionTypeXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../../WebService/SuperAdminWebService.asmx/GetInstitutionTypesForDropDown",
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
                        var OptionValue = $(this).find('InstitutionTypeId').text();
                        var OptionText = $(this).find('InstitutionType').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlInstitutionTypeXML.append(option);
                    });
                    $('#<%=ddlInstitutionType.ClientID%>').prepend('<option value="-1" selected="selected">--Select Institution Type--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $('#<%=ddlInstitutionType.ClientID%>').change(function () {
            var CountryId = $('#<%=hdnCountry.ClientID%>').val();
            var StateId = $('#<%=hdnState.ClientID%>').val();
            var InstitutionTypeId = $('#<%=ddlInstitutionType.ClientID%>').val();
            loadCurriculumType(InstitutionTypeId, CountryId, StateId, "-1");
        });

         function loadCurriculumType(institutiontypeid, countryid, stateid, selectvalue) {
            var ddlCurriculumTypeDropDownListXML = $('#<%=ddlCurriculumType.ClientID%>');
            ddlCurriculumTypeDropDownListXML.empty();
            var paramobj = {};
            paramobj.countryid = countryid;
            paramobj.stateid = stateid;
            paramobj.institutionTypeId = institutiontypeid;
            $.ajax({
                type: "POST",
                url: "../../WebService/SuperAdminWebService.asmx/LoadDropDownCurriculumType",
                data: JSON.stringify(paramobj),
                //  data: '{institutiontypeid: "' + institutiontypeid + '",countryid="' + countryid + '",stateid="' + stateid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // console.log(response.d);
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('CurriculumTypeId').text();
                        var OptionText = $(this).find('CurriculumType').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlCurriculumTypeDropDownListXML.append(option);
                    });
                    $('#<%=ddlCurriculumType.ClientID%>').prepend('<option value="-1" selected="selected">--Select Curriculum Type--</option>');
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No Curriculum Type Found');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlCurriculumType.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlCurriculumType.ClientID%>").val(selectvalue);
                }
            }, 200);
        }

          $('#<%=ddlCurriculumType.ClientID%>').change(function () {
           
            var curriculumtypeId = $('#<%=ddlCurriculumType.ClientID%>').val();
            loadLevels(curriculumtypeId, "1");
        });
         function loadLevels(curriculumtypeId, selectvalue) {
            var ddlLevelDropDownXML = $('#<%=ddlLevel.ClientID%>');
            ddlLevelDropDownXML.empty();
            var paramobj = {};
            paramobj.curriculumtypeId = curriculumtypeId;
            $.ajax({
                type: "POST",
                url: "../../WebService/SuperAdminWebService.asmx/LoadDropDownLevels",
                data: JSON.stringify(paramobj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    $(xmlDoc).find('Table').each(function () {
                        var OptionValue = $(this).find('LevelId').text();
                        var OptionText = $(this).find('LevelName').text();
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlLevelDropDownXML.append(option);
                    });
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No Level Found');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlCurriculumType.ClientID%> option').length > 0) {
                    clearInterval(interval);
                    $("#<%=ddlLevel.ClientID%>").val(selectvalue);
                }
            }, 200);
        }


        $("#<%=ddlInstitutionType.ClientID%>").change(function () {
            if ($("#<%=ddlInstitutionType.ClientID%> option:selected").text() == "School") {
                $('#divClass').show();
                $('#divSubLevel').hide();
            }
            else {
                $('#divClass').hide();
                $('#divSubLevel').show();
            }
        });

        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetClassData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //  console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        order: [[2, "asc"]],
                        columns: [
                            { data: 'ClassName' },
                            { className: "hide", data: 'ClassId' },
                            { className: "hide", data: 'MasterClassId' }
                        ]

                    });
                    table.page(defaultpage).draw(false);
                    $('#myTable_length').parent().parent().remove();
                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //  $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }

            // $("#btnSaveClass").html('Update');
            $("#btnDeleteClass").css("display", "block");

            $('#hdnClassId').val($(this).find('td:nth-child(2)').text());
            //  $('#<%=chkClass.ClientID%>').val($(this).find('td:nth-child(3)').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });

        $(function () {
            $("[id*=btnSaveClass]").click(function () {
                if ($("#<%=chkClass.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                 <%-- else if ($("#<%=txtClass.ClientID%>").val() > 12) {
                      $("#<%=lblError.ClientID%>").html('Class Cannot Be Greater Than 12');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
                else if ($("#<%=txtClass.ClientID%>").val() == 0) {
                    $("#<%=lblError.ClientID%>").html('Class Cannot Be 0');
                         $("#<%=divError.ClientID%>").css("display", "block");
                         return;
                     }
                     else if ($("#<%=txtClass.ClientID%>").val().indexOf("-") > -1) {
                         $("#<%=lblError.ClientID%>").html('Invalid Characters in Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }--%>
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.classid = $.trim($("[id*=<%=chkClass.ClientID%>]").val());
                if ($("#btnSaveClass").html() == 'Update') {
                    if ($('#hdnClassId').val() != '') {
                        obj.classid = $.trim($("[id*=hdnClassId]").val());
                    }
                }
                obj.classname = $.trim($("[id*=<%=chkClass.ClientID%>] option:selected").text());
                obj.buttontext = $("#btnSaveClass").html();
                $.ajax({
                    type: "POST",
                    url: "Class.aspx/SendParameters",
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
                        if (r.d == 'Class Already Exists') {
                            $("#<%=lblError.ClientID%>").html('Class Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Class Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Class Updated Successfully');
                        }
                        if (r.d == 'Class Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Class Saved Successfully');
                        }
                        runEffect1();
                        clear();
                    }
                });
                return false;
            });
        });

        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //   alert('fd');
                var objDelete = {};
                objDelete.classid = $.trim($("[id*=hdnClassId]").val());
                $.ajax({
                    type: "POST",
                    url: "Class.aspx/DeleteClass",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Class Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Class Deleted Successfully');
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
            $("[id*=btnNewClass]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveClass").html('Add');
            $('#<%=chkClass.ClientID%>').val('-1');
            $("[id*=hdnClassId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteClass").css("display", "none");
        }
    </script>
</asp:Content>
