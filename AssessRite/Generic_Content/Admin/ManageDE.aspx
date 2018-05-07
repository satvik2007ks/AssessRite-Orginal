<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="ManageDE.aspx.cs" EnableEventValidation="false" Inherits="AssessRite.Generic_Content.Admin.ManageDE" %>

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

        .dataTables_wrapper {
            margin-bottom: 20px !important;
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
        <h5 class="breadcrumbheading">Add/View/Update/Delete Data Entry Operator</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Data Entry Operator</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Data Entry Operator</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Data Entry Operator Saved Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                            <button id="btnNewDE" class="btn btn-primary">New</button>
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
                        <%--  <div class="help-block">
                            <asp:RegularExpressionValidator ControlToValidate="txtPassword" ID="RegularExpressionValidator3" ValidationExpression="^[\s\S]{8,20}$" runat="server" ErrorMessage="Min 8 Characters Required" Style="color: red" ValidationGroup="vd"></asp:RegularExpressionValidator>
                        </div>--%>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnDEId" />
                    <a href="#" id="btnSaveDE" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblDE">
                            <thead>
                                <tr>
                                    <th>FirstName</th>
                                    <th>LastName</th>
                                    <th>Contact No</th>
                                    <th>Email</th>
                                    <th>UserName</th>
                                    <th style="display: none">Password</th>
                                    <th style="display: none">DEId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteDE" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title" id="H3">Are you sure you want to delete this DE?</h6>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
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
            <%--   </ContentTemplate>
            </asp:UpdatePanel>--%>
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
    <script>
        $(document).ready(function () {
            $('#<%=txtFirstName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
                    return false;
                }
            });
            $('#<%=txtLastName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
                    return false;
                }
            });
            $('#<%=txtContactNo.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
                    return false;
                }
            });
            $('#<%=txtEmailID.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
                    return false;
                }
            });
            $('#<%=txtUserName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
                    return false;
                }
            });
            $('#<%=txtPassword.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#btnSaveDE').click();
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
        //function pageLoad(sender, args) {
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
        //}
    </script>
    <script>
        $(document).ready(function () {
          
        });
    </script>

    <script>
        var table;
        $(document).ready(function () {
            loadtable(0);
            $(document).ajaxStart(function () {

                //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#tblDE_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');

                // window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });



        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/getDEData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblDE').DataTable({
                        data: json,
                        select: true,
                        columns: [
                            { data: 'DEFirstName' },
                            { data: 'DELastName' },
                            { data: 'DEContactNo' },
                            { data: 'DEEmailId' },
                            { data: 'UserName' },
                            { className: "hide", data: 'Password' },
                            { className: "hide", data: 'DEId' },
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#tblDE tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //    $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }

            $("#btnSaveDE").html('Update');
            $("#btnDeleteDE").css("display", "block");

            $('#hdnDEId').val($(this).find('td:nth-child(7)').text());
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
            $("[id*=btnSaveDE]").click(function () {

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
                  obj.deid = "0";
                  if ($('#hdnDEId').val() != '') {
                      obj.deid = $.trim($("[id*=hdnDEId]").val());
                  }
                  obj.firstname = $.trim($("[id*=<%=txtFirstName.ClientID%>]").val());
                  obj.lastname = $.trim($("[id*=<%=txtLastName.ClientID%>]").val());
                  obj.contactno = $.trim($("[id*=<%=txtContactNo.ClientID%>]").val());
                  obj.emailid = $.trim($("[id*=<%=txtEmailID.ClientID%>]").val());
                  obj.username = $.trim($("[id*=<%=txtUserName.ClientID%>]").val());
                  obj.password = $.trim($("[id*=<%=txtPassword.ClientID%>]").val());
                  obj.buttontext = $("#btnSaveDE").html();
                  $.ajax({
                      type: "POST",
                      url: "ManageDE.aspx/SaveDE",
                      data: JSON.stringify(obj),
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      success: function (r) {
                          //  alert(r.d);
                          $('#tblDE').DataTable().destroy();
                          $('#tblDE tbody').empty();
                          var pagenum;
                          if ($('#hdnpage').val() == '') {
                              pagenum = 0;
                          }
                          else {
                              pagenum = parseInt($('#hdnpage').val()) - 1;
                          }
                          loadtable(pagenum);
                          if (r.d == 'DE Data Already Exists') {
                              $("#<%=lblError.ClientID%>").html('DE Data Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'UserName Already Exists') {
                            $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == "Connection Lost") {
                            $("#<%=lblError.ClientID%>").html('Connection Lost! Please logout and login again');
                              $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'DE Details Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('DE Details Updated Successfully');
                        }
                        if (r.d == 'DE Added Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('DE Added Successfully');
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
                objDelete.DEid = $.trim($("[id*=hdnDEId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageDE.aspx/DeleteDE",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#tblDE').DataTable().destroy();
                        $('#tblDE tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'DE Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('DE Deleted Successfully');
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
            $("[id*=btnNewDE]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#tblDE tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnDEId').val($(this).find('td:nth-child(7)').text());
            $('#<%=txtFirstName.ClientID%>').val('');
            $('#<%=txtLastName.ClientID%>').val('');
            $('#<%=txtContactNo.ClientID%>').val('');
            $('#<%=txtEmailID.ClientID%>').val('');
            $('#<%=txtUserName.ClientID%>').val('');
            $('#<%=txtPassword.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteDE").css("display", "none");
            $("#btnSaveDE").html('Save');
        }
    </script>
</asp:Content>
