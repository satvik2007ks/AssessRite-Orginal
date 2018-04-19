<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="ManualResultEntry.aspx.cs" Inherits="AssessRite.ManualResultEntry" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Manual Result Entry</h5>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnYes" />
            <%--<asp:PostBackTrigger ControlID="btnContinue2" />--%>
        </Triggers>
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <div class="card mb-3">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-lg-12" style="text-align: center"></div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label style="margin-top: 8px;">Select Test</label>
                                <asp:DropDownList ID="ddlTest" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlTest_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                <div class="col-md-12 textcenter">
                                    <label style="color: darkorange; font-style: normal; font-size: 12px">(Note*:Only Offline Tests)</label>
                                </div>
                            </div>
                            <div id="divTestDetails" runat="server" style="display: none;">
                                <div class="row">
                                    <h6 style="margin: 0 auto; text-decoration: underline">Test Details</h6>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-9">
                                                <div class="row" style="text-align: left">
                                                    <%--<div class="col-md-1"></div>--%>
                                                    <div class="col-md-5">
                                                        <label>Created Date</label>
                                                    </div>
                                                    <div class="col-md-7">
                                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-9">
                                                <div class="row" style="text-align: left">
                                                    <%--<div class="col-md-1"></div>--%>
                                                    <div class="col-md-5">
                                                        <label>Class</label>
                                                    </div>
                                                    <div class="col-md-7">
                                                        <asp:Label ID="lblClass" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-9">
                                                <div class="row" style="text-align: left">
                                                    <%--<div class="col-md-1"></div>--%>
                                                    <div class="col-md-5">
                                                        <label>Subject</label>
                                                    </div>
                                                    <div class="col-md-7">
                                                        <asp:Label ID="lblSubject" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-9">
                                                <div class="row" style="text-align: left">
                                                    <%--<div class="col-md-1"></div>--%>
                                                    <div class="col-md-5">
                                                        <label>No of Questions</label>
                                                    </div>
                                                    <div class="col-md-7">
                                                        <asp:Label ID="lblQuestions" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label style="margin-top: 8px;">Select Class</label>
                                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label style="margin-top: 8px;">Select Student</label>
                                <asp:DropDownList ID="ddlStudent" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                <div class="help-block textcenter" id="divError" runat="server" style="display: none">
                                    <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Academic Year"></asp:Label>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center;">
                                    <asp:Button ID="btnContinue2" runat="server" CssClass="btn btn-primary" Text="Enter Result" OnClick="btnContinue2_Click" />
                                    <asp:Button ID="btnSubmit" runat="server" Visible="false" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <div class="card-footer small text-muted"></div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Alert<b></h5>
                            <button type="button" class="close" data-dismiss="modal">x</button>
                        </div>
                        <div class="modal-body">You have already entered result for this student. Do you want to continue by overriding the previous result ?</div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <asp:Button ID="btnYes" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnYes_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        function openModal() {
            $("#myModal").modal("show");
        }
    </script>
      <script>
        $(document).ready(function () {
            $('#collapseComponents li').removeClass("current-menu-item");
            $('#liManualResult').addClass('current-menu-item');
            $("#collapseComponents").addClass('sidenav-second-level collapse show');
        });
    </script>
</asp:Content>
