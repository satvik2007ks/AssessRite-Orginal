<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="ManageSubLevel.aspx.cs" EnableEventValidation="false" Inherits="AssessRite.Generic_Content.Admin.ManageSubLevel" %>

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

        .custom-checkbox td {
            padding: 6px;
        }

            .custom-checkbox td label {
                margin-left: 2px;
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
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewSubLevel" class="btn btn-primary">New</button>
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
                    <div class="form-group" id="divClass" style="display: none">
                        <asp:Label ID="Label3" runat="server" Text="Class"></asp:Label>
                        <asp:CheckBoxList ID="chkClass" runat="server" RepeatDirection="Horizontal" CssClass="custom-checkbox">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="6">6</asp:ListItem>
                            <asp:ListItem Value="7">7</asp:ListItem>
                            <asp:ListItem Value="8">8</asp:ListItem>
                            <asp:ListItem Value="9">9</asp:ListItem>
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="11">11</asp:ListItem>
                            <asp:ListItem Value="12">12</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div class="form-group" id="divSubLevel">
                        <asp:Label ID="lblSubLevel" runat="server" Text="Sub-Level"></asp:Label>
                        <asp:TextBox ID="txtSubLevel" runat="server" CssClass="form-control" ValidationGroup="g" MaxLength="25" placeholder="Enter Sub-Level"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnSubLevelId" />
                    <a href="#" id="btnSaveSubLevel" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-7" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblSubLevel" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Institution Type</th>
                                    <th>Curriculum</th>
                                    <th>Level</th>
                                    <th>Sub-Level</th>
                                    <th style="display: none">SubLevelId</th>
                                    <th style="display: none">LevelId</th>
                                    <th style="display: none">CurriculumTypeId</th>
                                    <th style="display: none">InstitutionTypeId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteSubLevel" style="display: none; margin: 0 auto">
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
                // $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                // $("#loading").hide();
                // window.clearTimeout($("#loading").hide().data('timeout'));
                $('#tblSubLevel_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
            });
        });

        function loadInstitutionType() {
            var ddlInstitutionTypeXML = $('#<%=ddlInstitutionType.ClientID%>');
            ddlInstitutionTypeXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/GetInstitutionTypesForGCAdminDropDown",
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
            $('#<%=ddlCurriculumType.ClientID%>').empty();
           <%-- if ($("#<%=ddlInstitutionType.ClientID%> option:selected").text() == "School") {
                $('#divClass').show();
                $('#divSubLevel').hide();
            }
            else {
                $('#divClass').hide();
                $('#divSubLevel').show();
            }--%>
            $("#<%=ddlLevel.ClientID%>").empty();
           <%-- var CountryId = $('#<%=hdnCountry.ClientID%>').val();
            var StateId = $('#<%=hdnState.ClientID%>').val();--%>
            var InstitutionTypeId = $('#<%=ddlInstitutionType.ClientID%>').val();
            loadCurriculumType(InstitutionTypeId, "-1");
        });

        function loadCurriculumType(institutiontypeid, selectvalue) {
            var ddlCurriculumTypeDropDownListXML = $('#<%=ddlCurriculumType.ClientID%>');
            ddlCurriculumTypeDropDownListXML.empty();
            var paramobj = {};
            paramobj.institutiontypeid = institutiontypeid;
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/GetCurriculumTypesForGCAdminDropDown",
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
            loadLevels(curriculumtypeId, "-1");
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
                    $('#<%=ddlLevel.ClientID%>').prepend('<option value="-1" selected="selected">--Select Level--</option>');
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

        $("#<%=ddlLevel.ClientID%>").change(function () {
            if ($("#<%=ddlLevel.ClientID%> option:selected").text() == "Class") {
                $('#tblSubLevel > tbody  > tr').each(function () {
                    var value = $(this).find('td:nth-child(4)').text();
                    $("#<%=chkClass.ClientID%> input[type=checkbox]").each(function () {
                        if ($(this).val() == value) {
                            $(this).prop("disabled", true)
                        }
                    })
                });
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
                url: "../WebService/GCWebService.asmx/GetSubLevel",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //  console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblSubLevel').DataTable({
                        data: json,
                        select: true,
                        order: [[2, "asc"]],
                        columns: [
                            { data: 'InstitutionType' },
                            { data: 'CurriculumType' },
                            { data: 'LevelName' },
                            { data: 'SubLevel' },
                            { className: "hide", data: 'SubLevelId' },
                            { className: "hide", data: 'LevelId' },
                            { className: "hide", data: 'CurriculumTypeId' },
                            { className: "hide", data: 'InstitutionTypeId' }
                        ]

                    });
                    table.page(defaultpage).draw(false);
                    $('#tblSubLevel_length').parent().parent().remove();
                }
            });
        }

        $(document).on('click', '#tblSubLevel tbody tr', function () {
            if ($(this).find('td:nth-child(3)').text() == "Class") {
                clear();
                $('#hdnSubLevelId').val($(this).find('td:nth-child(5)').text());
                $("#btnDeleteSubLevel").css("display", "block");

            }
            else {
                $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', false);
                $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', false);
                $('#<%= ddlLevel.ClientID %>').prop('disabled', false);

                var institutionid = $(this).find('td:nth-child(8)').text();
                var curriculumid = $(this).find('td:nth-child(7)').text();
                var levelid = $(this).find('td:nth-child(6)').text();
                $('#hdnSubLevelId').val($(this).find('td:nth-child(5)').text());
                $("#<%=ddlInstitutionType.ClientID%>").val(institutionid);
                loadCurriculumType(institutionid, curriculumid);
                loadLevels(curriculumid, levelid);
                $("#<%=txtSubLevel.ClientID%>").val($(this).find('td:nth-child(4)').text());
                $("#btnDeleteSubLevel").css("display", "block");
                $("#btnSaveSubLevel").html('Update');

                $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', true);
                $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', true);
                $('#<%= ddlLevel.ClientID %>').prop('disabled', true);
            }
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //  $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });

        $(function () {
            $("[id*=btnSaveSubLevel]").click(function () {
                if (jQuery.trim($("#<%=ddlInstitutionType.ClientID%>").val()) == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Institution Type');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=ddlCurriculumType.ClientID%>").val()) == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Curriculum Type');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=ddlLevel.ClientID%> option:selected").text()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Select Level');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlLevel.ClientID%> option:selected").text() == "Class") {
                    if ($('#<%=chkClass.ClientID%> input:checkbox:checked').length == 0) {
                        $("#<%=lblError.ClientID%>").html('Please Select Class');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                else if ($("#<%=ddlLevel.ClientID%> option:selected").text() != "Class") {
                    if (jQuery.trim($("#<%=txtSubLevel.ClientID%>").val()) == '') {
                        $("#<%=lblError.ClientID%>").html('Sub-Level Cannot Be Empty');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }

                var obj = {};
                obj.sublevelid = "0";
                if ($('#hdnSubLevelId').val() != '') {
                    obj.sublevelid = $.trim($("[id*=hdnSubLevelId]").val());
                }
                obj.levelid = $('#<%=ddlLevel.ClientID%>').val();
                obj.levelname = $("#<%=ddlLevel.ClientID%> option:selected").text();
                obj.sublevelnames = [];
                obj.sublevel = "0";
                if ($("#<%=ddlLevel.ClientID%> option:selected").text() == "Class") {
                    obj.sublevelnames = $("#<%=chkClass.ClientID%> input:checkbox:checked").map(function () {
                        return $(this).val();
                    }).get();
                }
                else {
                    obj.sublevel = jQuery.trim($('#<%=txtSubLevel.ClientID%>').val());
                }
                obj.buttontext = $("#btnSaveSubLevel").html();
                $.ajax({
                    type: "POST",
                    url: "ManageSubLevel.aspx/SaveSubLevel",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#tblSubLevel').DataTable().destroy();
                        $('#tblSubLevel tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'Sub-Level Already Exists') {
                            $("#<%=lblError.ClientID%>").html('Sub-Level Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Sub-Level Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Sub-Level Updated Successfully');
                        }
                        if (r.d == 'Sub-Level Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Sub-Level Saved Successfully');
                        }
                        if (r.d == "Connection Lost") {
                            $("#<%=lblError.ClientID%>").html('Connection Lost! Please logout and login again');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
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
                objDelete.sublevelid = $.trim($("[id*=hdnSubLevelId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageSubLevel.aspx/DeleteSubLevel",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#tblSubLevel').DataTable().destroy();
                        $('#tblSubLevel tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Sub-Level Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Sub-Level Deleted Successfully');
                            runEffect1();
                        }
                        if (r.d == "Connection Lost") {
                            $("#<%=lblError.ClientID%>").html('Connection Lost! Please logout and login again');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                    }
                });
                $('#myModal1').modal('hide');
                clear();
                return false;
            });
        });

        $(function () {
            $("[id*=btnNewSubLevel]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#tblSubLevel tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveSubLevel").html('Save');
            $("#<%=ddlInstitutionType.ClientID%>").val("-1");
            $("#<%=ddlCurriculumType.ClientID%>").empty();
            $("#<%=ddlLevel.ClientID%>").empty();
            $('#divClass').hide();
            $("#<%=txtSubLevel.ClientID%>").val('');
            $('#divSubLevel').show();
            $("[id*=hdnSubLevelId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteSubLevel").css("display", "none");
            $("#<%=chkClass.ClientID%> input[type=checkbox]").each(function () {
                $(this).prop("checked", false)
            })
            $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', false);
            $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', false);
            $('#<%= ddlLevel.ClientID %>').prop('disabled', false);
        }
    </script>
</asp:Content>
