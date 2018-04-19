<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="AcademicYear.aspx.cs" Inherits="AssessRite.AcademicYear" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
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
            }, 5000);
            return false;
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Academic Year</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-6" style="text-align: center">Add / Update Academic Year</div>
                <div class="col-lg-6" style="text-align: center">View / Delete Academic Year</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Academic Year Saved Successfully"></asp:Label>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnAcademicYear" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="row" style="margin-top: 20px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center">
                                    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary" Text="New" OnClick="btnNew_Click" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblClass" runat="server" Text="Academic Year"></asp:Label>
                                <asp:TextBox ID="txtAcademic" runat="server" CssClass="form-control onlynumber" MaxLength="7" ValidationGroup="v"></asp:TextBox>
                                <div class="help-block">
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Style="color: red; font-size: smaller;" ErrorMessage="Invalid Format! Please Enter in XXXX-XX Format" ValidationGroup="v" ControlToValidate="txtAcademic" ValidationExpression="^[0-9][0-9][0-9][0-9]-[0-9][0-9]+$"></asp:RegularExpressionValidator>
                                </div>
                                <div class="help-block" id="divError" runat="server" style="display: none">
                                    <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Academic Year"></asp:Label>
                                </div>
                            </div>
                            <asp:Button ID="btnAcademicYear" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnAcademicYear_Click" ValidationGroup="v" />
                        </div>
                        <div class="col-lg-6">
                            <div class="table-responsive">
                                <asp:GridView ID="gridAcademicYear" runat="server" CssClass="table table-bordered dataTable" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridAcademicYear_RowDataBound" OnSelectedIndexChanged="gridAcademicYear_SelectedIndexChanged" DataKeyNames="AcademicYearId">
                                    <Columns>
                                        <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="AcademicYearId" HeaderText="AcademicYearId" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <div class="row" style="margin-top: 10px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="H3">Delete ?</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                        </div>
                                    <div class="modal-body">Deleting this Academic Year might impact all its dependencies. Are you sure you want to delete this Academic Year?</div>
                                        <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                            <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnYes_Click" />
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>

   
    <script type="text/javascript">
        function openModal() {
            //  jQuery.noConflict();
            $("#myModal").modal("show");
        }
    </script>
    <script>
        $(document).ready(function () {
            $('#collapseComponents li').removeClass("current-menu-item");
            $('#liAcademicYear').addClass('current-menu-item');
            $("#collapseComponents").addClass('sidenav-second-level collapse show');
        });
    </script>
    <script>
        function pageLoad(sender, args) {
            $('.onlynumber').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13,109]) !== -1 ||
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

            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();

            $(".dataTable").DataTable();
            $('#ContentPlaceHolder1_gridAcademicYear_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');

        }
    </script>
    <%--<script type="text/javascript">
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
