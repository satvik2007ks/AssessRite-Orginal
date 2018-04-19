<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="ManageTeacher.aspx.cs" Inherits="AssessRite.ManageTeacher" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
    <%-- <script type="text/javascript">
        // It is important to place this JavaScript code after ScriptManager1
        var xPos, yPos;
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        function BeginRequestHandler(sender, args) {
            if ($get('<%=Panel1.ClientID%>') != null) {
                // Get X and Y positions of scrollbar before the partial postback
                xPos = $get('<%=Panel1.ClientID%>').scrollLeft;
                yPos = $get('<%=Panel1.ClientID%>').scrollTop;
            }
        }

        function EndRequestHandler(sender, args) {
            if ($get('<%=Panel1.ClientID%>') != null) {
                // Set X and Y positions back to the scrollbar
                // after partial postback
                $get('<%=Panel1.ClientID%>').scrollLeft = xPos;
                $get('<%=Panel1.ClientID%>').scrollTop = yPos;
            }
        }

        prm.add_beginRequest(BeginRequestHandler);
        prm.add_endRequest(EndRequestHandler);
    </script>--%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Teacher</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Teacher</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Teacher</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Teacher Saved Successfully"></asp:Label>
            </div>
            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnTeacherSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-5">

                    <%-- <asp:Panel ID="pnl1" runat="server" DefaultButton="btnSaveTeacher">--%>
                    <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                            <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary hide" OnClick="btnNew_Click" />
                            <button id="btnNewTeacher" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4">
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblFirstName" runat="server" Text="FirstName*"></asp:Label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" MaxLength="100" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblLastName" runat="server" Text="LastName*"></asp:Label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" MaxLength="100" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123)"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" Text="Contact No#"></asp:Label>
                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control onlynumber" MaxLength="12"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" Text="Email ID"></asp:Label>
                        <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control" MaxLength="99" ValidationGroup="vd"></asp:TextBox>
                        <%--<div class="help-block">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid E-Mail ID" ControlToValidate="txtEmailID" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"></asp:RegularExpressionValidator>
                        </div>--%>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="UserName*"></asp:Label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Password*"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        <%-- <div class="help-block">
                            <asp:RegularExpressionValidator ControlToValidate="txtPassword" ID="RegularExpressionValidator3" ValidationExpression="^[\s\S]{8,20}$" runat="server" ErrorMessage="Min 8 Characters Required" Style="color: red" ValidationGroup="vd"></asp:RegularExpressionValidator>
                        </div>--%>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnTeacherId" />
                    <input id="btnSaveTeacher" class="btn btn-primary" type="submit" value="Save" />
                    <%--<a href="#" id="btnSaveTeacher" class="btn btn-primary">Save</a>--%>
                    <asp:Button ID="btnTeacherSave" runat="server" Text="Save" CssClass="btn btn-primary hide" ValidationGroup="vd" OnClick="btnTeacherSave_Click" />
                    <%--  </asp:Panel>--%>
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive hide">
                        <asp:GridView ID="gridTeacher" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Style="margin-bottom: 15px; margin-top: 15px;" Width="100%" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TeacherId" OnRowDataBound="gridTeacher_RowDataBound" OnSelectedIndexChanged="gridTeacher_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="TeacherFirstName" HeaderText="FirstName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="TeacherLastName" HeaderText="LastName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ContactNo" HeaderText="Contact No" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="EmailId" HeaderText="Email" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="UserName" HeaderText="UserName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Password" HeaderText="Password" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="TeacherId" HeaderText="TeacherId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>Contact No</th>
                                    <th>Email</th>
                                    <th>UserName</th>
                                    <th style="display: none">Password</th>
                                    <th style="display: none">TeacherId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteTeacher" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title" id="H3">Are you sure you want to delete this Teacher?</h6>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
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
            <%--   </ContentTemplate>
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
            $('#<%=txtFirstName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
            $('#<%=txtLastName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
            $('#<%=txtContactNo.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
            $('#<%=txtEmailID.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
            $('#<%=txtUserName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
            $('#<%=txtPassword.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveTeacher').click();
                    return false;
                }
            });
        });
    </script>

    <script>
        var table;
        $(document).ready(function () {
            loadtable(0);
            $(document).ajaxStart(function () {

                //   $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                //   window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });



        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getTeacherData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        columns: [
        { data: 'TeacherFirstName' },
        { data: 'TeacherLastName' },
        { data: 'ContactNo' },
        { data: 'EmailId' },
        { data: 'UserName' },
        { className: "hide", data: 'Password' },
        { className: "hide", data: 'TeacherId' },
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //    $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }

            $("#btnSaveTeacher").val('Update');
            $("#btnDeleteTeacher").css("display", "block");

            $('#hdnTeacherId').val($(this).find('td:nth-child(7)').text());
            $('#<%=txtFirstName.ClientID%>').val($(this).find('td:nth-child(1)').text());
            $('#<%=txtLastName.ClientID%>').val($(this).find('td:nth-child(2)').text());
            $('#<%=txtContactNo.ClientID%>').val($(this).find('td:nth-child(3)').text());
            $('#<%=txtEmailID.ClientID%>').val($(this).find('td:nth-child(4)').text());
            $('#<%=txtUserName.ClientID%>').val($(this).find('td:nth-child(5)').text());
            $('#<%=txtPassword.ClientID%>').val($(this).find('td:nth-child(6)').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });


        $(function () {
            $("[id*=btnSaveTeacher]").click(function () {
                //  alert('fd');
                if (jQuery.trim($("#<%=txtFirstName.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter First Name');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtLastName.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Last Name');
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

                if (jQuery.trim($("#<%=txtEmailID.ClientID%>").val()) != '') {
                    if (!validateEmail($("#<%=txtEmailID.ClientID%>").val())) {
                        $("#<%=lblError.ClientID%>").html('Invalid E-Mail-ID');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                var obj = {};
                obj.teacherid = "0";
                if ($('#hdnTeacherId').val() != '') {
                    obj.teacherid = $.trim($("[id*=hdnTeacherId]").val());
                }
                obj.firstname = $.trim($("[id*=<%=txtFirstName.ClientID%>]").val());
                obj.lastname = $.trim($("[id*=<%=txtLastName.ClientID%>]").val());
                obj.contactno = $.trim($("[id*=<%=txtContactNo.ClientID%>]").val());
                obj.emailid = $.trim($("[id*=<%=txtEmailID.ClientID%>]").val());
                obj.username = $.trim($("[id*=<%=txtUserName.ClientID%>]").val());
                obj.password = $.trim($("[id*=<%=txtPassword.ClientID%>]").val());
                obj.buttontext = $("#btnSaveTeacher").val();
                $.ajax({
                    type: "POST",
                    url: "ManageTeacher.aspx/SendParameters",
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
                        if (r.d == 'Teacher Data Already Exists') {
                            $("#<%=lblError.ClientID%>").html('Teacher Data Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'UserName Already Exists') {
                            $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Teacher Details Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Teacher Details Updated Successfully');
                        }
                        if (r.d == 'Teacher Added Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Teacher Added Successfully');
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
                objDelete.teacherid = $.trim($("[id*=hdnTeacherId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageTeacher.aspx/DeleteTeacher",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Teacher Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Teacher Deleted Successfully');
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
            $("[id*=btnNewTeacher]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnTeacherId').val($(this).find('td:nth-child(7)').text());
            $('#<%=txtFirstName.ClientID%>').val('');
            $('#<%=txtLastName.ClientID%>').val('');
            $('#<%=txtContactNo.ClientID%>').val('');
            $('#<%=txtEmailID.ClientID%>').val('');
            $('#<%=txtUserName.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteTeacher").css("display", "none");
            $("#btnSaveTeacher").val('Save');
        }
    </script>

</asp:Content>
