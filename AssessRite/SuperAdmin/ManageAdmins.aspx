<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="ManageAdmins.aspx.cs" Inherits="AssessRite.SuperAdmin.ManageAdmins" EnableEventValidation="false" %>
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
                        <div class="col-lg-4" style="text-align: center">Add / Update Admin Info</div>
                        <div class="col-lg-8" style="text-align: center">View / Delete Admin Info</div>
                    </div>
                </div>
                <div class="card-body">
                    <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblMsg" runat="server" Text="Admin Info Saved Successfully"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                                    <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary hide" />
                                    <button id="btnNewAdmin" class="btn btn-primary">New</button>
                                </div>
                                <div class="col-md-4">
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblSelectSchool" runat="server" Text="Select School*"></asp:Label>
                                <asp:DropDownList ID="ddlSelectSchool" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblAdminName" runat="server" Text="Admin Name*"></asp:Label>
                                <asp:TextBox ID="txtAdminName" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblAdminAddress" runat="server" Text="Admin Address*"></asp:Label>
                                <asp:TextBox ID="txtAdminAddress" runat="server" CssClass="form-control" TextMode="MultiLine" MaxLength="99"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblAdminContactNo" runat="server" Text="Admin Contact No#"></asp:Label>
                                <asp:TextBox ID="txtAdminContactNo" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblAdminEmailId" runat="server" Text="Admin Email ID"></asp:Label>
                                <asp:TextBox ID="txtAdminEmailId" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblUsername" runat="server" Text="UserName*"></asp:Label>
                                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblPassword" runat="server" Text="Password*"></asp:Label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                <div class="help-block" id="divError" runat="server" style="display: none">
                                    <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter School"></asp:Label>
                                </div>
                            </div>
                            <input type="hidden" id="hdnAdminId" />
                            <a href="#" id="btnSaveAdmin" class="btn btn-primary">Save</a>
                            <asp:Button ID="btnAdminSave" runat="server" Text="Save" CssClass="btn btn-primary hide" ValidationGroup="vd" />
                        </div>
                        <div class="col-lg-8">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="myTable" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th>School</th>
                                            <th>Admin Name</th>
                                            <th>Address</th>
                                            <th>Contact No#</th>
                                            <th>Email</th>
                                            <th>Username</th>
                                            <th style="display: none">Password</th>
                                            <th style="display: none">AdminId</th>
                                            <th style="display: none">SchoolId</th>
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
                                            <h6 class="modal-title" id="H3">Are you sure you want to delete this Admin Info?</h6>
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
                    loadSchool();
                    loadtable(0);
                    $(document).ajaxStart(function () {

                        //   $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
                    }).ajaxStop(function () {
                        $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                        //  window.clearTimeout($("#loading").hide().data('timeout'));
                    });
                });

                 function loadSchool() {
            var ddlSchoolDropDownListXML = $('#<%=ddlSelectSchool.ClientID%>');
                     ddlSchoolDropDownListXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/LoadSchoolDropdownSchool",
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
                        var OptionValue = $(this).find('SchoolId').text();
                        var OptionText = $(this).find('SchoolName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlSchoolDropDownListXML.append(option);
                    });
                    $('#<%=ddlSelectSchool.ClientID%>').prepend('<option value="-1" selected="selected">--Select School--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
         }


                function loadtable(defaultpage) {
                    $.ajax({
                        type: "POST",
                        url: "../WebService/SuperAdminWebService.asmx/GetAdminDataForSuperAdmin",
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
                { data: 'AdminName' },
                { data: 'AdminAddress' },
                { data: 'AdminContactNo' },
                { data: 'AdminEmailId' },
                { data: 'UserName' },
                { className: "hide", data: 'Password' },
                 { className: "hide", data: 'AdminId' },
                  { className: "hide", data: 'SchoolId' }
                                ]
                            });
                            table.page(defaultpage).draw(false);
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

                    $("#btnSaveAdmin").html('Update');
                    $("#btnDeleteAdmin").css("display", "block");

                    $('#hdnAdminId').val($(this).find('td:nth-child(8)').text());
                    $('#<%=ddlSelectSchool.ClientID%>').val($(this).find('td:nth-child(9)').text());
                    $('#<%=txtAdminName.ClientID%>').val($(this).find('td:nth-child(2)').text());
                    $('#<%=txtAdminAddress.ClientID%>').val($(this).find('td:nth-child(3)').text());
                    $('#<%=txtAdminContactNo.ClientID%>').val($(this).find('td:nth-child(4)').text());
                    $('#<%=txtAdminEmailId.ClientID%>').val($(this).find('td:nth-child(5)').text());
                    $('#<%=txtUserName.ClientID%>').val($(this).find('td:nth-child(6)').text());
                    $('#<%=txtPassword.ClientID%>').val($(this).find('td:nth-child(7)').text());
                    var info = table.page.info();
                    $('#hdnpage').val(info.page + 1);
                });


                $(function () {
                    $("[id*=btnSaveAdmin]").click(function () {
                        //  alert('fd');
                        if (jQuery.trim($("#<%=ddlSelectSchool.ClientID%>").val()) == '-1') {
                            $("#<%=lblError.ClientID%>").html('Please Select School');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        else if (jQuery.trim($("#<%=txtAdminName.ClientID%>").val()) == '') {
                            $("#<%=lblError.ClientID%>").html('Please Enter Admin Name');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        else if ($("#<%=txtAdminAddress.ClientID%>").val() == '') {
                            $("#<%=lblError.ClientID%>").html('Please Enter Address');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        else if ($("#<%=txtAdminContactNo.ClientID%>").val() == '') {
                            $("#<%=lblError.ClientID%>").html('Please Select Admin Contact No#');
                    $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                }
                else if (jQuery.trim($("#<%=txtUserName.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter UserName');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtPassword.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Password');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtPassword.ClientID%>").val().length < 8) {
                    $("#<%=lblError.ClientID%>").html('Min 8 Characters Required');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                        if (jQuery.trim($("#<%=txtAdminEmailId.ClientID%>").val()) != '') {
                            if (!validateEmail($("#<%=txtAdminEmailId.ClientID%>").val())) {
                                $("#<%=lblError.ClientID%>").html('Invalid E-Mail-ID');
                                $("#<%=divError.ClientID%>").css("display", "block");
                                return false;
                            }
                        }

                        var obj = {};
                        obj.adminid = "0";
                        if ($('#hdnAdminId').val() != '') {
                            alert("working");
                            obj.adminid = $.trim($("[id*=hdnAdminId]").val());
                        }
                        obj.schoolid = $.trim($("[id*=<%=ddlSelectSchool.ClientID%>]").val());
                        obj.adminname = $.trim($("[id*=<%=txtAdminName.ClientID%>]").val());
                        obj.address = $.trim($("[id*=<%=txtAdminAddress.ClientID%>]").val());
                        obj.contactno = $.trim($("[id*=<%=txtAdminContactNo.ClientID%>]").val());
                        obj.emailid = $.trim($("[id*=<%=txtAdminEmailId.ClientID%>]").val());
                        obj.username = $.trim($("[id*=<%=txtUserName.ClientID%>]").val());
                        obj.password = $.trim($("[id*=<%=txtPassword.ClientID%>]").val());
                        obj.buttontext = $("#btnSaveAdmin").html();
                        $.ajax({
                            type: "POST",
                            url: "ManageAdmins.aspx/SendParameters",
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
                                if (r.d == 'Admin Info Already Exists') {
                                    $("#<%=lblError.ClientID%>").html('Admin Info Already Exists');
                                    $("#<%=divError.ClientID%>").css("display", "block");
                                    return false;
                                }
                                if (r.d == 'UserName Already Exists') {
                                    $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                                    $("#<%=divError.ClientID%>").css("display", "block");
                                    return false;
                                }
                                if (r.d == 'Admin Info Updated Successfully') {
                                    $("#<%=lblMsg.ClientID%>").html('Admin Info Updated Successfully');
                                }
                                if (r.d == 'Admin Added Successfully') {
                                    $("#<%=lblMsg.ClientID%>").html('Admin Added Successfully');
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
                        objDelete.studentid = $.trim($("[id*=hdnAdminId]").val());
                        $.ajax({
                            type: "POST",
                            url: "ManageAdmins.aspx/DeleteAdmin",
                            data: JSON.stringify(objDelete),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (r) {
                                // alert(r.d);
                                $('#myTable').DataTable().destroy();
                                $('#myTable tbody').empty();
                                var pagenum = parseInt($('#hdnpage').val()) - 1;
                                loadtable(pagenum);
                                if (r.d == 'Admin Deleted Successfully') {
                                    $("#<%=lblMsg.ClientID%>").html('Admin Deleted Successfully');
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
            $("[id*=btnNewAdmin]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnAdminId').val('');
            $('#<%=ddlSelectSchool.ClientID%>').val('-1');
            $('#<%=txtAdminName.ClientID%>').val('');
            $('#<%=txtAdminAddress.ClientID%>').val('');
            $('#<%=txtAdminContactNo.ClientID%>').val('');
            $('#<%=txtAdminEmailId.ClientID%>').val('');
            $('#<%=txtUserName.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteAdmin").css("display", "none");
            $("#btnSaveAdmin").html('Save');
        }
            </script>
</asp:Content>
