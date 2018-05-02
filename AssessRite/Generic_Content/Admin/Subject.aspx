<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="Subject.aspx.cs" EnableEventValidation="false" Inherits="AssessRite.Generic_Content.Admin.Subject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .table1 tr, td, th {
            text-align: center !important;
        }

        label {
            font-weight: normal !important;
        }

        .hideGridColumn {
            display: none;
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
        <h5 class="breadcrumbheading">Add/View/Update/Delete Subject</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Subject</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Subject</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Subject Saved Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewSubject" class="btn btn-primary">New</button>
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
                    <div class="form-group">
                        <asp:Label ID="lblClassName" runat="server" Text="Sub-Level"></asp:Label>
                        <asp:DropDownList ID="ddlSubLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:CheckBox ID="chkLanguage" runat="server" Text="Check this if language is other than English" CssClass="checkbox" />
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Subject"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnSubId" />
                    <a href="#" id="btnSaveSubject" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">SubjectId</th>
                                    <th style="display: none">SubLevelId</th>
                                    <th>Sub-Level</th>
                                    <th>Subject</th>
                                    <th style="display: none">IsOtherLanguage</th>
                                </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteSubject" style="display: none;">Delete</button>

                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="H3">Delete ?</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
                                <div class="modal-body">Deleting this Subject might impact all its dependencies. Are you sure you want to delete this Subject?</div>
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
        </div>
        <div class="card-footer small text-muted">
        </div>
    </div>
    <input type="hidden" id="hdnpage" />
     <asp:HiddenField ID="hdnCountry" runat="server" />
    <asp:HiddenField ID="hdnState" runat="server" />
    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liSubject').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');
        });
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadInstitutionType();
            loadtable(0);
            $(document).ajaxStart(function () {
                // $("#loading").show();
                //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                // $("#loading").hide();
                //window.clearTimeout($("#loading").hide().data('timeout'));
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
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
            $("#<%=ddlLevel.ClientID%>").empty();
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

          $('#<%=ddlLevel.ClientID%>').change(function () {
            var levelid = $('#<%=ddlLevel.ClientID%>').val();
            loadSubLevels(levelid, "1");
        });

        function loadSubLevels(levelid, selectvalue) {
            var ddlSubLevelDropDownXML = $('#<%=ddlSubLevel.ClientID%>');
            ddlSubLevelDropDownXML.empty();
            var paramobj = {};
            paramobj.levelid = levelid;
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/LoadDropDownSubLevels",
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
                        ddlSubLevelDropDownXML.append(option);
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


        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetSubjectData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,

                        select: true,
                        columns: [
        { className: "hide", data: 'SubjectId' },
        { className: "hide", data: 'ClassId' },
        { data: 'ClassName' },
        { data: 'SubjectName' },
        { className: "hide", data: 'IsOtherLanguage' }
                        ]

                    });
                    table.page(defaultpage).draw(false);

                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //     $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveSubject").html('Update');
            // $("#id").css("display", "none");
            $("#btnDeleteSubject").css("display", "block");
            var classId = $(this).find('td:nth-child(2)').text();
            $('#hdnSubId').val($(this).find('td:first').text());
            $('#<%=txtSubject.ClientID%>').val($(this).find('td:nth-child(4)').text());
            $("#<%=ddlSubLevel.ClientID%>").val(classId);
            var ischecked = $(this).find('td:nth-child(5)').text();
            if (ischecked == "true") {
                $('#<%=chkLanguage.ClientID%>').prop('checked', true); // Checks it
            }
            else {
                $('#<%=chkLanguage.ClientID%>').prop('checked', false); // Checks it
            }
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });
    </script>

    <script type="text/javascript">
        $(function () {
            $("[id*=btnSaveSubject]").click(function () {
                //  alert('fd');
                var english = /^[A-Za-z0-9 ]*$/;
                var trimmedValue = jQuery.trim($('#<%=txtSubject.ClientID%>').val());
                if ($("#<%=ddlSubLevel.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtSubject.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Subject Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (!english.test($("#<%=txtSubject.ClientID%>").val())) {
                    if ($('#<%=chkLanguage.ClientID%>').is(":checked")) {
                    }
                    else {
                        $("#<%=lblError.ClientID%>").html('If Subject Is Other Than English, Please Select The checkbox');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.subjectid = "0";
                if ($('#hdnSubId').val() != '') {
                    obj.subjectid = $.trim($("[id*=hdnSubId]").val());
                }
                obj.subject = $.trim($("[id*=<%=txtSubject.ClientID%>]").val());
                obj.classid = $.trim($("[id*=<%=ddlSubLevel.ClientID%>]").val());
                obj.buttontext = $("#btnSaveSubject").html();
                obj.isotherlanguage = "0";
                if ($('#<%=chkLanguage.ClientID%>').is(":checked")) {
                    // it is checked
                    obj.isotherlanguage = "1";
                }
                $.ajax({
                    type: "POST",
                    url: "Subject.aspx/SendParameters",
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
                        if (r.d == 'Subject Already Found') {
                            $("#<%=lblError.ClientID%>").html('Subject Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Subject Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Updated Successfully');
                        }
                        if (r.d == 'Subject Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Saved Successfully');
                        }
                        clear();
                        runEffect1();

                    }
                });
                return false;
            });
        });


        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.subjectid = $.trim($("[id*=hdnSubId]").val());
                $.ajax({
                    type: "POST",
                    url: "Subject.aspx/DeleteSubject",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Subject Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Deleted Successfully');
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
            $("[id*=btnNewSubject]").click(function () {
                clear();
                return false;
            });
        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveSubject").html('Save');
            $("#btnDeleteSubject").css("display", "none");
            $("#<%=ddlSubLevel.ClientID%>").val('-1');
            $('#<%=txtSubject.ClientID%>').val('');
            $('#<%=chkLanguage.ClientID%>').prop('checked', false);
            $("[id*=hdnSubId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
       }
    </script>
</asp:Content>
