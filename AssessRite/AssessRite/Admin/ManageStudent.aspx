<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="ManageStudent.aspx.cs" Inherits="AssessRite.ManageStudent" EnableEventValidation="false" %>

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
        <h5 class="breadcrumbheading">Add/View/Update/Delete Student</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-4" style="text-align: center">Add / Update Student</div>
                <div class="col-lg-8" style="text-align: center">View / Delete Student</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Student Saved Successfully"></asp:Label>
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
                            <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary hide" OnClick="btnNew_Click" />
                            <button id="btnNewStudent" class="btn btn-primary">New</button>
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
                        <asp:Label ID="lblClassName" runat="server" Text="Class*"></asp:Label>
                        <asp:DropDownList ID="ddlClassName" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Academic Year*"></asp:Label>
                        <asp:DropDownList ID="ddlAcademicYear" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Parent Name"></asp:Label>
                        <asp:TextBox ID="txtParentName" runat="server" CssClass="form-control" MaxLength="100" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode == 32)"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" Text="Parent Contact No#"></asp:Label>
                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control onlynumber" MaxLength="15"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" Text="Parent Email ID"></asp:Label>
                        <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                       <%-- <div class="help-block">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid E-Mail ID" ControlToValidate="txtEmailID" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"></asp:RegularExpressionValidator>
                        </div>--%>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" Text="UserName*"></asp:Label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label6" runat="server" Text="Password*"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                      <%--  <div class="help-block">
                            <asp:RegularExpressionValidator ControlToValidate="txtPassword" ID="RegularExpressionValidator3" ValidationExpression="^[\s\S]{8,20}$" runat="server" ErrorMessage="Min 8 Characters Required" Style="color: red" ValidationGroup="vd"></asp:RegularExpressionValidator>
                        </div>--%>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnStudentId" />
                    <a href="#" id="btnSaveStudent" class="btn btn-primary">Save</a>
                    <asp:Button ID="btnStudentSave" runat="server" Text="Save" CssClass="btn btn-primary hide" ValidationGroup="vd" OnClick="btnStudentSave_Click" />
                </div>
                <div class="col-lg-8">
                    <div class="table-responsive hide">
                        <asp:GridView ID="gridStudent" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Style="margin-bottom: 15px; margin-top: 15px;" Width="100%" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="StudentId" OnRowDataBound="gridStudent_RowDataBound" OnSelectedIndexChanged="gridStudent_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="LastName" HeaderText="LastName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ClassName" HeaderText="Class" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ParentName" HeaderText="Parent Name" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="ParentContactNo" HeaderText="Parent Contact No" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="ParentEmailId" HeaderText="Parent Email" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="ClassId" HeaderText="ClassId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="AcademicYearId" HeaderText="AcademicYearId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="StudentId" HeaderText="StudentId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="UserName" HeaderText="UserName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Password" HeaderText="Password" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>Class</th>
                                    <th>Academic Year</th>
                                    <th>Parent Name</th>
                                    <th>Parent Contact No</th>
                                    <th>Parent Email</th>
                                    <th style="display: none">ClassId</th>
                                    <th style="display: none">AcademicYearId</th>
                                    <th style="display: none">StudentId</th>
                                    <th>UserName</th>
                                    <th style="display: none">Password</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteStudent" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title" id="H3">Are you sure you want to delete this Student?</h6>
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
                <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>
            </div>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('#<%=txtFirstName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                return false;
                }
            });
            $('#<%=txtLastName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
             $('#<%=txtParentName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
            $('#<%=txtContactNo.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
            $('#<%=txtEmailID.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
            $('#<%=txtUserName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
            $('#<%=txtPassword.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#btnSaveStudent').click();
                    return false;
                }
            });
        });
    </script>

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

            loadtable(0);
            $(document).ajaxStart(function () {
               
             //   $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
              //  window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });



        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetStudentData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        columns: [
        { data: 'FirstName' },
        { data: 'LastName' },
        { data: 'ClassName' },
        { data: 'AcademicYear' },
        { data: 'ParentName' },
        { data: 'ParentContactNo' },
        { data: 'ParentEmailId' },
        { className: "hide", data: 'ClassId' },
        { className: "hide", data: 'AcademicYearId' },
        { className: "hide", data: 'StudentId' },
        { data: 'UserName' },
        { className: "hide", data: 'Password' }
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

            $("#btnSaveStudent").html('Update');
            $("#btnDeleteStudent").css("display", "block");

            $('#hdnStudentId').val($(this).find('td:nth-child(10)').text());
            $('#<%=txtFirstName.ClientID%>').val($(this).find('td:nth-child(1)').text());
            $('#<%=txtLastName.ClientID%>').val($(this).find('td:nth-child(2)').text());
            $('#<%=ddlClassName.ClientID%>').val($(this).find('td:nth-child(8)').text());
            $('#<%=ddlAcademicYear.ClientID%>').val($(this).find('td:nth-child(9)').text());
            $('#<%=txtParentName.ClientID%>').val($(this).find('td:nth-child(5)').text());
            $('#<%=txtContactNo.ClientID%>').val($(this).find('td:nth-child(6)').text());
            $('#<%=txtEmailID.ClientID%>').val($(this).find('td:nth-child(7)').text());
            $('#<%=txtUserName.ClientID%>').val($(this).find('td:nth-child(11)').text());
            $('#<%=txtPassword.ClientID%>').val($(this).find('td:nth-child(12)').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });


        $(function () {
            $("[id*=btnSaveStudent]").click(function () {
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
                else if ($("#<%=ddlClassName.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlAcademicYear.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Academic Year');
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
                          if(!validateEmail($("#<%=txtEmailID.ClientID%>").val()))
                          {
                                $("#<%=lblError.ClientID%>").html('Invalid E-Mail-ID');
                    $("#<%=divError.ClientID%>").css("display", "block");
                              return false;
                          }
                     }

                var obj = {};
                obj.studentid = "0";
                if ($('#hdnStudentId').val() != '') {
                    obj.studentid = $.trim($("[id*=hdnStudentId]").val());
                }
                obj.firstname = $.trim($("[id*=<%=txtFirstName.ClientID%>]").val());
                obj.lastname = $.trim($("[id*=<%=txtLastName.ClientID%>]").val());
                obj.classid = $.trim($("[id*=<%=ddlClassName.ClientID%>]").val());
                obj.academicyearid = $.trim($("[id*=<%=ddlAcademicYear.ClientID%>]").val());
                obj.parentname = $.trim($("[id*=<%=txtParentName.ClientID%>]").val());
                obj.contactno = $.trim($("[id*=<%=txtContactNo.ClientID%>]").val());
                obj.emailid = $.trim($("[id*=<%=txtEmailID.ClientID%>]").val());
                obj.username = $.trim($("[id*=<%=txtUserName.ClientID%>]").val());
                obj.password = $.trim($("[id*=<%=txtPassword.ClientID%>]").val());
                obj.buttontext = $("#btnSaveStudent").html();
                $.ajax({
                    type: "POST",
                    url: "ManageStudent.aspx/SendParameters",
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
                        if (r.d == 'Student Data Already Exists') {
                            $("#<%=lblError.ClientID%>").html('Student Data Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'UserName Already Exists') {
                            $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Student Details Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Student Details Updated Successfully');
                        }
                        if (r.d == 'Student Added Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Student Added Successfully');
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
            return emailReg.test( $email );
        }

        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.studentid = $.trim($("[id*=hdnStudentId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageStudent.aspx/DeleteStudent",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Student Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Student Deleted Successfully');
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
            $("[id*=btnNewStudent]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnStudentId').val('');
            $('#<%=txtFirstName.ClientID%>').val('');
            $('#<%=txtLastName.ClientID%>').val('');
            $('#<%=ddlClassName.ClientID%>').val('-1');
            $('#<%=ddlAcademicYear.ClientID%>').val('-1');
            $('#<%=txtParentName.ClientID%>').val('');
            $('#<%=txtContactNo.ClientID%>').val('');
            $('#<%=txtEmailID.ClientID%>').val('');
            $('#<%=txtUserName.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteStudent").css("display", "none");
              $("#btnSaveStudent").html('Save');
        }
    </script>
</asp:Content>
