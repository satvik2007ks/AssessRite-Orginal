<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="MoveStudents.aspx.cs" Inherits="AssessRite.MoveStudents" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
    <script>
        $(document).ready(function () {
            $('#collapseComponents li').removeClass("current-menu-item");
            $('#liMoveStudents').addClass('current-menu-item');
            $("#collapseComponents").addClass('sidenav-second-level collapse show');
        });
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
        <h5 class="breadcrumbheading">Promote Students</h5>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnMove" />
        </Triggers>
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <div class="card mb-3">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-lg-12" style="text-align: center">Select Academic Year, Class To Promote From Current Academic Year</div>
                                <%--<div class="col-lg-6" style="text-align: center"></div>--%>
                            </div>
                        </div>
                        <div class="card-body">
                            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <asp:Label ID="Label4" runat="server" Text="Moved Successfully"></asp:Label>
                            </div>
                            <div class="row">
                                <div class="col-lg-3"></div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblFromAcademic" runat="server" Text="Select Academic Year"></asp:Label>
                                        <asp:DropDownList ID="ddlFromAcademicYear" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlFromAcademicYear_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="Label1" runat="server" Text="Select Class"></asp:Label>
                                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <div class="row" style="display: none;" id="divStudents" runat="server">
                                        <div class="form-group" style="margin-left: 15px;">
                                            <asp:Label ID="Label2" runat="server" Text="Select Students"></asp:Label>
                                            <asp:CheckBox ID="chkStudentsAll" runat="server" CssClass="checkbox" Style="text-align: left; margin-left: 1px;" OnCheckedChanged="chkStudentsAll_CheckedChanged" AutoPostBack="true" Text="All"></asp:CheckBox>
                                            <asp:Panel ID="Panel1" runat="server" Style="max-height: 250px; overflow-y: auto; margin-top: -12px;">
                                                <asp:CheckBoxList ID="chkStudents" runat="server" CssClass="checkbox" Style="text-align: left;" OnSelectedIndexChanged="chkStudents_SelectedIndexChanged" AutoPostBack="true"></asp:CheckBoxList>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3"></div>
                            </div>
                        </div>
                        <%--<div class="card-footer small text-muted"></div>--%>
                    </div>
                </div>
                <div class="col-lg-3"></div>

            </div>
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <div class="card mb-3" style="display: none;" id="divHeading" runat="server">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-lg-12" style="text-align: center">Select 'Academic Year' and 'Class' To Promote</div>
                                <%--<div class="col-lg-6" style="text-align: center"></div>--%>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-3"></div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <asp:Label ID="lblAcademic" runat="server" Text="Select Move To 'Academic Year'"></asp:Label>
                                        <asp:DropDownList ID="ddlAcademicYear" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="Label3" runat="server" Text="Move To 'Class'"></asp:Label>
                                        <asp:DropDownList ID="ddlMoveTo" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <div class="help-block" id="divErr" runat="server" style="display: none">
                                            <asp:Label ID="lblError" runat="server" Style="color: red"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group" style="text-align: center">
                                        <asp:Button ID="btnMove" runat="server" Text="Move" CssClass="btn btn-primary" OnClick="btnMove_Click" Visible="false" />
                                    </div>
                                </div>
                                <div class="col-lg-3"></div>
                            </div>
                        </div>
                        <div class="card-footer small text-muted"></div>
                    </div>
                </div>
                <div class="col-lg-3"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
