<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="ManageLevels.aspx.cs" Inherits="AssessRite.SuperAdmin.ManageLevels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Level</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-4" style="text-align: center">Add / Update Level</div>
                <div class="col-lg-8" style="text-align: center">View / Delete Level</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Level Saved Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewLevel" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCountryName" runat="server" Text="Country"></asp:Label>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="State"></asp:Label>
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
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
                        <asp:Label ID="lblLevel" runat="server" Text="Level"></asp:Label>
                        <asp:TextBox ID="txtLevel" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Level"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnLevelId" />
                    <a href="#" id="btnSaveLevel" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-8 divider">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblLevel" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">CountryId</th>
                                    <th style="display: none">StateId</th>
                                    <th style="display: none">InstitutionTypeId</th>
                                    <th style="display: none">CurriculumTypeId</th>
                                    <th style="display: none">LevelId</th>
                                    <th>Country</th>
                                    <th>State</th>
                                    <th>Institution Type</th>
                                    <th>Curriculum Type</th>
                                    <th>Level</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteLevel" style="display: none;">Delete</button>
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
                                <div class="modal-body">Deleting this Level might impact all its dependencies. Are you sure you want to delete this Level?</div>
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

    <script>
        $(document).ready(function () {
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liLevel').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');
        });
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadCountry();
            loadtable(0);
        });

        function loadCountry() {
            var ddlCountryDropDownListXML = $('#<%=ddlCountry.ClientID%>');
            ddlCountryDropDownListXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/LoadSchoolDropdownCountry",
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
                        var OptionValue = $(this).find('CountryId').text();
                        var OptionText = $(this).find('CountryName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlCountryDropDownListXML.append(option);
                    });
                    $('#<%=ddlCountry.ClientID%>').prepend('<option value="-1" selected="selected">--Select Country--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $('#<%=ddlCountry.ClientID%>').change(function () {
            var selectedVal = $('#<%=ddlCountry.ClientID%>').val();
            loadState(selectedVal, "-1");
        });

        function loadState(countryid, selectvalue) {
            var ddlStateDropDownListXML = $('#<%=ddlState.ClientID%>');
            ddlStateDropDownListXML.empty();
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/LoadSchoolDropdownState",
                data: '{countryid: "' + countryid + '"}',
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
                        var OptionValue = $(this).find('StateId').text();
                        var OptionText = $(this).find('StateName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlStateDropDownListXML.append(option);
                    });
                    $('#<%=ddlState.ClientID%>').prepend('<option value="-1" selected="selected">--Select State--</option>');
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No State Found For This Country');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlState.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlState.ClientID%>").val(selectvalue);
                }
            }, 200);
        }


        $('#<%=ddlInstitutionType.ClientID%>').change(function () {
            var CountryId = $('#<%=ddlCountry.ClientID%>').val();
            var StateId = $('#<%=ddlState.ClientID%>').val();
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
                url: "../WebService/SuperAdminWebService.asmx/LoadDropDownCurriculumType",
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


        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/GetLevels",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblLevel').DataTable({
                        data: json,
                        select: true,
                        columns: [
                            { className: "hide", data: 'CountryId' },
                            { className: "hide", data: 'StateId' },
                            { className: "hide", data: 'InstitutionTypeId' },
                            { className: "hide", data: 'CurriculumTypeId' },
                            { className: "hide", data: 'LevelId' },
                            { data: 'CountryName' },
                            { data: 'StateName' },
                            { data: 'InstitutionType' },
                            { data: 'CurriculumType' },
                            { data: 'LevelName' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#tblLevel tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //     $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            if ($(this).find("td:eq(0)").text() == 'No data available in table') {
                table.$('tr.selected').removeClass('selected');
            }
            else {
                $('#<%= ddlCountry.ClientID %>').prop('disabled', false);
                $('#<%= ddlState.ClientID %>').prop('disabled', false);
                $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', false);
                $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', false);

                $("#btnSaveLevel").html('Update');
                $("#btnDeleteLevel").css("display", "block");
                var CountryId = $(this).find('td:nth-child(1)').text();
                var StateId = $(this).find('td:nth-child(2)').text();
                var InstitutionTypeId = $(this).find('td:nth-child(3)').text();
                var CurriculumTypeId = $(this).find('td:nth-child(4)').text();
                $('#hdnLevelId').val($(this).find('td:nth-child(5)').text());
                $('#<%=txtLevel.ClientID%>').val($(this).find('td:nth-child(10)').text());
                $("#<%=ddlCountry.ClientID%>").val(CountryId);
                loadState(CountryId, StateId);
                $("#<%=ddlInstitutionType.ClientID%>").val(InstitutionTypeId);
                loadCurriculumType(InstitutionTypeId, CountryId, StateId, CurriculumTypeId);
                $('#<%= ddlCountry.ClientID %>').prop('disabled', true);
                $('#<%= ddlState.ClientID %>').prop('disabled', true);
                $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', true);
                $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', true);
                var info = table.page.info();
                $('#hdnpage').val(info.page + 1);
            }
        });

        $(function () {
            $("[id*=btnSaveLevel]").click(function () {
                var trimmedValue = jQuery.trim($('#<%=txtLevel.ClientID%>').val());
                if ($("#<%=ddlCountry.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Country');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlState.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select State');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlInstitutionType.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Institution Type');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlCurriculumType.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Curriculum Type');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtLevel.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Level');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Level Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.levelid = "0";
                if ($('#hdnLevelId').val() != '') {
                    obj.levelid = $.trim($("[id*=hdnLevelId]").val());
                }
               <%-- obj.countryid = $.trim($("[id*=<%=ddlCountry.ClientID%>]").val());
                obj.stateid = $.trim($("[id*=<%=ddlState.ClientID%>]").val());--%>
               // obj.institutiontypeid = $.trim($("[id*=<%=ddlInstitutionType.ClientID%>]").val());
                obj.curriculumtypeid = $.trim($("[id*=<%=ddlCurriculumType.ClientID%>]").val());
                obj.level = $.trim($("[id*=<%=txtLevel.ClientID%>]").val());
                obj.buttontext = $("#btnSaveLevel").html();
                $.ajax({
                    type: "POST",
                    url: "ManageLevels.aspx/SaveLevel",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#tblLevel').DataTable().destroy();
                        $('#tblLevel tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'Level Already Found') {
                            $("#<%=lblError.ClientID%>").html('Level Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Level Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Level Updated Successfully');
                        }
                        if (r.d == 'Level Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Level Saved Successfully');
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
                objDelete.levelid = $.trim($("[id*=hdnLevelId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageLevels.aspx/DeleteLevel",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#tblLevel').DataTable().destroy();
                        $('#tblLevel tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Level Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Level Deleted Successfully');
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
            $("[id*=btnNewLevel]").click(function () {
                clear();
                return false;
            });
        });

        function clear() {
            $('#tblLevel tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveLevel").html('Save');
            $("#btnDeleteLevel").css("display", "none");
            $("#<%=ddlCountry.ClientID%>").val('-1');
            $('#<%=ddlState.ClientID%>').empty();
            $("#<%=ddlInstitutionType.ClientID%>").val('-1');
            $('#<%=ddlCurriculumType.ClientID%>').empty();
            $('#<%=txtLevel.ClientID%>').val('');
            $("[id*=hdnLevelId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $('#<%= ddlCountry.ClientID %>').prop('disabled', false);
            $('#<%= ddlState.ClientID %>').prop('disabled', false);
            $('#<%= ddlInstitutionType.ClientID %>').prop('disabled', false);
            $('#<%= ddlCurriculumType.ClientID %>').prop('disabled', false);
        }
    </script>
    <script type="text/javascript">
        function runEffect1() {
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
