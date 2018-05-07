<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="ManageSME.aspx.cs" Inherits="AssessRite.Generic_Content.Admin.ManageSME" %>
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

        .chkboxlist td {
            padding-right: 8px;
        }

        .center {
            text-align: center !important;
        }

        .fade.in {
            opacity: 1;
        }

        .modal.in .modal-dialog {
            -webkit-transform: translate(0, 0);
            -o-transform: translate(0, 0);
            transform: translate(0, 0);
        }

        .modal-backdrop.in {
            opacity: 0.5;
        }
    </style>
    <script src="../Scripts/jquery-1.11.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
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
        //function openModalDetails() {
        //       jQuery.noConflict();
        //    $("#myModal").modal("show");
        //}
        function openModal() {
            jQuery.noConflict();
            $("#myModal1").modal("show");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Subject Matter Expert</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6" style="text-align: center">Add / Update SME</div>
                <div class="col-lg-3"></div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Subject Matter Expert Saved Successfully"></asp:Label>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSMESave" />
                    <asp:PostBackTrigger ControlID="btnDeleteYes" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="pnl" runat="server" DefaultButton="btnSMESave">
                        <div class="row">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4">
                                <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                                        <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary" OnClick="btnNew_Click" />
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
                                    <div class="help-block">
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid E-Mail ID" ControlToValidate="txtEmailID" Style="color: red; margin-left: 15px;" ValidationGroup="vd" ValidationExpression="^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-8">
                                <div class="form-group">
                                    <h6>Select Subject Expertise</h6>
                                    <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                                        <div class="col-2">
                                            <label>Select Class</label>
                                        </div>
                                        <div class="col-10">
                                            <label>Select Subject</label>
                                        </div>
                                    </div>
                                    <asp:Repeater ID="rptSME" runat="server" OnItemDataBound="rptSME_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-1">
                                                    <asp:CheckBox ID="chkClass" runat="server" CssClass="checkbox" Text='<%# Eval("ClassName") %>' OnCheckedChanged="chkClass_CheckedChanged" AutoPostBack="true" />
                                                    <asp:HiddenField ID="hdnClassId" runat="server" Value='<%# Eval("ClassId") %>' />
                                                </div>
                                                <div class="col-11">
                                                    <asp:CheckBoxList ID="chkSubjects" runat="server" CssClass="checkbox chkboxlist" RepeatDirection="Horizontal" Enabled="false"></asp:CheckBoxList>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4"></div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <asp:Label ID="Label1" runat="server" Text="UserName*"></asp:Label>
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label2" runat="server" Text="Password*"></asp:Label>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                    <div class="help-block">
                                        <asp:RegularExpressionValidator ControlToValidate="txtPassword" ID="RegularExpressionValidator3" ValidationExpression="^[\s\S]{8,20}$" runat="server" ErrorMessage="Min 8 Characters Required" Style="color: red" ValidationGroup="vd"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="help-block center" id="divError" runat="server" style="display: none">
                                        <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                                    </div>
                                </div>
                                <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4" style="margin-top: 5px; text-align: center;">
                                        <asp:Button ID="btnSMESave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="vd" OnClick="btnSMESave_Click" />
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                            </div>
                            <div class="col-lg-4"></div>
                        </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="card-header">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6" style="text-align: center">
                    View / Delete SME
                </div>
                <div class="col-lg-3"></div>

            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <div class="table-responsive">
                        <asp:GridView ID="gridSME" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Style="margin-bottom: 15px; margin-top: 15px;" Width="100%" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="SMEId" OnRowDataBound="gridSME_RowDataBound" OnSelectedIndexChanged="gridSME_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField="SMEFirstName" HeaderText="First Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="SMELastName" HeaderText="Last Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="SMEContactNo" HeaderText="Contact No" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="SMEEmailId" HeaderText="Email" HeaderStyle-HorizontalAlign="Center" NullDisplayText=" " />
                                <asp:BoundField DataField="UserName" HeaderText="UserName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Password" HeaderText="Password" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="SMEId" HeaderText="SMEId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title" id="H3">Are you sure you want to delete this SME?</h6>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
                                <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                    <asp:Button ID="btnDeleteYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnDeleteYes_Click" />
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>

    </div>
    <script>
        $(document).ready(function () {
            $('#<%=txtFirstName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13) {
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
            $('#<%=txtLastName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
            $('#<%=txtContactNo.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
            $('#<%=txtEmailID.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
            $('#<%=txtUserName.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
            $('#<%=txtPassword.ClientID%>').keypress(function (e) {
                if (e.keyCode == 13){
                    $('#<%=btnSMESave.ClientID%>').click();
                    return false;
                }
            });
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
            //$(".dataTable tbody").before("<thead><tr></tr></thead>");
            //$(".dataTable thead tr").append($(".dataTable th"));
            //$(".dataTable tbody tr:first").remove();

            //$(".dataTable").DataTable();
        }
    </script>
</asp:Content>
