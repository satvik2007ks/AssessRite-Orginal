<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="StudentResults.aspx.cs" Inherits="AssessRite.StudentResults" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Results / Students List</h5>
    </div>
    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header" role="tab" id="headingOne">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    <h6 class="mb-0">List of students who took the test </h6>
                </a>
            </div>

            <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <div class="row" id="divDownload" runat="server" style="display:none">
                        <div class="col-12" style="margin:20px">
                            <asp:LinkButton ID="lnkDownloadResult" runat="server" OnClick="lnkDownloadResult_Click"  style="color:darkorange;">Download Test Results <i class="fa fa-download" aria-hidden="true"></i></asp:LinkButton>
                        </div>
                    </div>
                    <div class="table-responsive" style="margin-top: 20px; margin-bottom: 20px; width: 60%;">
                        <asp:GridView ID="grdStudentsTaken" runat="server" OnRowDataBound="grdStudentsTaken_RowDataBound" CssClass="table table-bordered dataTable" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" Style="text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Student Name" DataField="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="True" HeaderText="Result" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblResult" runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkViewPaper" runat="server" Text="View Answer Paper" OnClick="lnkViewPaper_Click" CommandArgument='<%# Eval("TestAssignedId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkViewReport" runat="server" Text="View Report" OnClick="lnkViewReport_Click" CommandArgument='<%# Eval("TestAssignedId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" runat="server" Text="Download Report" OnClick="lnkDownload_Click" CommandName='<%# Eval("Name") %>' CommandArgument='<%# Eval("TestAssignedId") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                         <div id="divTakenEmpty" runat="server" class="text-center" style="display: none">
                        <asp:Label ID="Label1" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card">
            <div class="card-header" role="tab" id="headingTwo">
                <a class="collapsed" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                    <h6 class="mb-0">List of students who didn't take the test</h6>
                </a>
            </div>
            <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="card-block">
                    <div class="table-responsive" style="margin-top: 20px; margin-bottom: 20px; width: 60%;">
                        <asp:GridView ID="grdStudentsNotTaken" runat="server" CssClass="table table-bordered dataTable1" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" Style="text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Student Name" DataField="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-ForeColor="Red" />
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    <div id="divNotTakenEmpty" runat="server" class="text-center" style="display: none">
                        <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();
            $(".dataTable").DataTable({
                columns: [
                    { orderable: true },
                    { orderable: true },
                    { orderable: false },
                    { orderable: false },
                    { orderable: false }
                ]
            });

            $(".dataTable1 tbody").before("<thead><tr></tr></thead>");
            $(".dataTable1 thead tr").append($(".dataTable1 th"));
            $(".dataTable1 tbody tr:first").remove();
            $(".dataTable1").DataTable();
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#collapseComponents li').removeClass("current-menu-item");
            $('#liViewResults').addClass('current-menu-item');
            $("#collapseComponents").addClass('sidenav-second-level collapse show');
        });
    </script>
</asp:Content>
