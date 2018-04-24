<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="SchoolInfo.aspx.cs" Inherits="AssessRite.SuperAdmin.SchoolInfo" EnableEventValidation="false" %>

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
        <h5 class="breadcrumbheading">Register School</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-4" style="text-align: center">Add / Update School Info</div>
                <div class="col-lg-8" style="text-align: center">View / Delete School Info</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="School Info Saved Successfully"></asp:Label>
            </div>
            <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnStudentSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-4">
                    <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                            <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary hide" />
                            <button id="btnNewSchool" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4">
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSchoolName" runat="server" Text="School Name*"></asp:Label>
                        <asp:TextBox ID="txtSchoolName" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSchoolAddress" runat="server" Text="School Address*"></asp:Label>
                        <asp:TextBox ID="txtSchoolAddress" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCounty" runat="server" Text="Country*"></asp:Label>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="State*"></asp:Label>
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Zip Code*"></asp:Label>
                        <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control onlynumber"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" Text="Contact No#*"></asp:Label>
                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control onlynumber" MaxLength="15"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" Text="Email ID*"></asp:Label>
                        <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label7" runat="server" Text="No. of Students"></asp:Label>
                        <asp:TextBox ID="txtNoOfStudent" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label12" runat="server" Text="Principal Name"></asp:Label>
                        <asp:TextBox ID="txtPrincipalName" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label13" runat="server" Text="Emergency Contact No."></asp:Label>
                        <asp:TextBox ID="txtEmergencyContact" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group" id="divCheckbox">
                        <asp:Label ID="Label8" runat="server" Text="Test Type"></asp:Label>
                        <asp:CheckBoxList ID="chkTestType" runat="server" CssClass="checkbox">
                            <asp:ListItem Value="Online">Online</asp:ListItem>
                            <asp:ListItem Value="Offline">Offline</asp:ListItem>
                            <asp:ListItem Value="ZeroNet">ZeroNet</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>

                    <input type="hidden" id="hdnSchoolId" />
                    <a href="#" id="btnSaveSchool" class="btn btn-primary">Save</a>
                    <asp:Button ID="btnSchoolSave" runat="server" Text="Save" CssClass="btn btn-primary hide" ValidationGroup="vd" />
                </div>
                <div class="col-lg-8">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>School Name</th>
                                    <th>Address</th>
                                    <th>Country</th>
                                    <th>State</th>
                                    <th>Contact No</th>
                                    <th>Email</th>
                                    <th>No. of Students</th>
                                    <th style="display: none">Zip Code</th>
                                    <th style="display: none">Principal Name</th>
                                    <th style="display: none">Emergency Contact</th>
                                    <th style="display: none">SchoolId</th>
                                    <th style="display: none">CountryId</th>
                                    <th style="display: none">StateId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteSchool" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title" id="H3">Are you sure you want to delete this School Info?</h6>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
                                <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary hide" />
                                    <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
                <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>
            </div>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../Images/loading.gif" />
        </div>
    </div>


    <script type="text/javascript">
        function openModal() {
            //  jQuery.noConflict();
            $("#myModal").modal("show");
        }
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

            //$(".dataTable tbody").before("<thead><tr></tr></thead>");
            //$(".dataTable thead tr").append($(".dataTable th"));
            //$(".dataTable tbody tr:first").remove();

            //$(".dataTable").DataTable();
        }
    </script>
    <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            $('#liMenu').addClass('active');
            //$('#liStudent1').addClass('current-menu-item');
        });
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadCountry();
            loadtable(0);
            $(document).ajaxStart(function () {

                //   $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                //  window.clearTimeout($("#loading").hide().data('timeout'));
            });
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
                    //console.log(response.d);
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
                     $("#<%=lblError.ClientID%>").html('No States Found For This Country');
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


        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/GetSchoolData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        columns: [
        { data: 'SchoolName' },
        { data: 'SchoolAddress', defaultContent: '' },
        { data: 'CountryName' },
        { data: 'StateName' },
        { data: 'ContactNo', defaultContent: '' },
        { data: 'Email', defaultContent: '' },
        { data: 'NoOfStudents', defaultContent: '' },
        { className: "hide", data: 'ZipCode', defaultContent: '' },
        { className: "hide", data: 'PrincipalName', defaultContent: '' },
        { className: "hide", data: 'EmergencyContactNo', defaultContent: '' },
        { className: "hide", data: 'schoolId' },
         { className: "hide", data: 'CountryId' },
        { className: "hide", data: 'StateId' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }


        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
             //   $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            if ($(this).find("td:eq(0)").text() == 'No data available in table') {
                table.$('tr.selected').removeClass('selected');
            }
            else {
                $("#btnSaveSchool").html('Update');
                $("#btnDeleteSchool").css("display", "block");

                $('#hdnSchoolId').val($(this).find('td:nth-child(11)').text());
                $('#<%=txtSchoolName.ClientID%>').val($(this).find('td:nth-child(1)').text());
                $('#<%=txtSchoolAddress.ClientID%>').val($(this).find('td:nth-child(2)').text());
                var countryid = $(this).find('td:nth-child(12)').text();
                $('#<%=ddlCountry.ClientID%>').val($(this).find('td:nth-child(12)').text());
                var stateid = $(this).find('td:nth-child(13)').text();
                loadState(countryid, stateid);
                $('#<%=txtZipCode.ClientID%>').val($(this).find('td:nth-child(8)').text());
                $('#<%=txtContactNo.ClientID%>').val($(this).find('td:nth-child(5)').text());
                $('#<%=txtEmailID.ClientID%>').val($(this).find('td:nth-child(6)').text());
                $('#<%=txtNoOfStudent.ClientID%>').val($(this).find('td:nth-child(7)').text());
                $('#<%=txtPrincipalName.ClientID%>').val($(this).find('td:nth-child(9)').text());
                $('#<%=txtEmergencyContact.ClientID%>').val($(this).find('td:nth-child(10)').text());
                loadSchoolTestTypes($(this).find('td:nth-child(11)').text());
                var info = table.page.info();
                $('#hdnpage').val(info.page + 1);
            }
        });

        function loadSchoolTestTypes(schoolid) {
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/getAllTestTypesForSchool",
                data: '{schoolid: "' + schoolid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    var checkboxes = $("[id*=<%= chkTestType.ClientID %>] input:checkbox");
                    checkboxes.each(function () {
                        $(this).attr('checked', false);
                    });
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        var TestType = $(this).find('TestType').text();
                        var checkboxes = $("[id*=<%= chkTestType.ClientID %>] input:checkbox");
                        checkboxes.each(function () {
                            var value = $(this).val();
                            if (value == TestType) {
                                $(this).attr('checked', true);
                            }
                        });

                    });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $(function () {
            $("[id*=btnSaveSchool]").click(function () {
                //  alert('fd');
                if (jQuery.trim($("#<%=txtSchoolName.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Name');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtSchoolAddress.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Address');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlCountry.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Country');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlState.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select State');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtZipCode.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Zipcode');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtContactNo.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Contact No#');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtEmailID.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School E-Mail');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                if (jQuery.trim($("#<%=txtEmailID.ClientID%>").val()) != '') {
                    if (!validateEmail($("#<%=txtEmailID.ClientID%>").val())) {
                        $("#<%=lblError.ClientID%>").html('Invalid E-Mail-ID');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                var chks = $("#<%= chkTestType.ClientID %> input:checkbox");
                var hasChecked = false;
                for (var i = 0; i < chks.length; i++) {
                    if (chks[i].checked) {
                        hasChecked = true;
                        break;
                    }
                }
                if (hasChecked == false) {
                    alert("Please select at least one Test Type!");
                    return false;
                }
                var obj = {};
                obj.schoolid = "0";

                if ($('#hdnSchoolId').val() != '') {
                    obj.schoolid = $.trim($("[id*=hdnSchoolId]").val());
                }
                obj.testtype = $("#<%= chkTestType.ClientID %> input:checkbox:checked").map(function () {
                    return $(this).closest("td").find("label").html();
                }).get();
                obj.schoolname = $.trim($("[id*=<%=txtSchoolName.ClientID%>]").val());
                obj.schooladdress = $.trim($("[id*=<%=txtSchoolAddress.ClientID%>]").val());
                obj.countryid = $.trim($("[id*=<%=ddlCountry.ClientID%>]").val());
                obj.stateid = $.trim($("[id*=<%=ddlState.ClientID%>]").val());
                obj.zipcode = $.trim($("[id*=<%=txtZipCode.ClientID%>]").val());
                obj.contactno = $.trim($("[id*=<%=txtContactNo.ClientID%>]").val());
                obj.emailid = $.trim($("[id*=<%=txtEmailID.ClientID%>]").val());
                obj.noofstudents = "0";
                if ($.trim($("[id*=<%=txtNoOfStudent.ClientID%>]").val()) != '') {
                    obj.noofstudents = $.trim($("[id*=<%=txtNoOfStudent.ClientID%>]").val());
                }
                obj.principalname = $.trim($("[id*=<%=txtPrincipalName.ClientID%>]").val());
                obj.emergencycontact = $.trim($("[id*=<%=txtEmergencyContact.ClientID%>]").val());
                obj.buttontext = $("#btnSaveSchool").html();
                //   alert(obj.schoolid, obj.schoolname, obj.schooladdress, obj.countryid, obj.stateid, obj.zipcode, obj.contactno, obj.emailid, obj.emailid, obj.noofstudents, obj.principalname, obj.emergencycontact,obj.buttontext);
                $.ajax({
                    type: "POST",
                    url: "SchoolInfo.aspx/SendParameters",
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
                        if (r.d == 'School Info Already Exists') {
                            $("#<%=lblError.ClientID%>").html('School Info Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'UserName Already Exists') {
                            $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'School Info Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('School Info Updated Successfully');
                        }
                        if (r.d == 'School Added Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('School Added Successfully');
                        }
                        runEffect1();
                        clear();
                    }
                });
                return false;
            });
        });


        function validateEmail($email) {
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            return emailReg.test($email);
        }

        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.schoolid = $.trim($("[id*=hdnSchoolId]").val());
                $.ajax({
                    type: "POST",
                    url: "SchoolInfo.aspx/DeleteSchool",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'School Info Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('School Info Deleted Successfully');
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
            $("[id*=btnNewSchool]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnSchoolId').val('');
            $('#<%=txtSchoolName.ClientID%>').val('');
            $('#<%=txtSchoolAddress.ClientID%>').val('');
            $('#<%=ddlCountry.ClientID%>').val('-1');
            $('#<%=ddlState.ClientID%>').val('-1');
            $('#<%=txtZipCode.ClientID%>').val('');
            $('#<%=txtContactNo.ClientID%>').val('');
            $('#<%=txtEmailID.ClientID%>').val('');
            $('#<%=txtNoOfStudent.ClientID%>').val('');
            $('#<%=txtPrincipalName.ClientID%>').val('');
            $('#<%=txtEmergencyContact.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteSchool").css("display", "none");
            $("#btnSaveSchool").html('Save');
            $("#<%= chkTestType.ClientID %> input:checkbox").removeAttr('checked');
        }
    </script>
</asp:Content>
