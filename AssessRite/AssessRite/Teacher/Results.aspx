<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="AssessRite.Results" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .grid td, .grid th {
            text-align: center !important;
        }

        .griddiv {
            height: 20px;
            margin-top: -3px;
        }

        .modal-ku {
            width: 1200px;
            margin: auto;
        }

        .dataTables_wrapper {
            margin-bottom: 20px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Results</h5>
    </div>
    <asp:UpdatePanel ID="updPnl" runat="server">
        <ContentTemplate>

            <%--<div id="accordion">
                <div class="card">
                    <div class="card-header" id="headingOne">
                        <h5 class="mb-0">
                            <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Online Tests
                            </button>
                        </h5>
                    </div>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                        <div class="card-body">
                            
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingTwo">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Offline Tests
                            </button>
                        </h5>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                        <div class="card-body">
                            
                        </div>
                    </div>
                </div>
                <div class="card" >
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                ZeroNet Tests
                            </button>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body">
                            
                        </div>
                    </div>
                </div>
            </div>--%>


            <div class="card mb-3">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">Online Tests</div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <%--AllowPaging="true" PageSize="50"  OnPageIndexChanging="grdTests_PageIndexChanging"--%>
                        <asp:GridView ID="grdTests" runat="server" CssClass="table table-bordered dataTable" OnRowDataBound="grdTests_RowDataBound" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Type" DataField="TestType" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="True" HeaderText="Concepts">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Button ID="btnViewConcepts" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' CssClass="btn-link" OnClick="btnViewConcepts_Click"
                                                Text="View" CommandArgument='<%# Eval("TestId") %>' Style="border: none; cursor: pointer;" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Questions per Concept" DataField="NoOfQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Test Date" DataField="TestDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="75px" />
                                <asp:TemplateField ShowHeader="True" HeaderText="Active From" HeaderStyle-Width="80px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblTimeFrom" runat="server" Text='<%# DateTime.Parse(Eval("TestActiveFrom").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="True" HeaderText="Active To" HeaderStyle-Width="80px">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblTimeTo" runat="server" Text='<%# DateTime.Parse(Eval("TestActiveTo").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Active From" DataField="TestActiveFrom" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                <asp:BoundField HeaderText="Active To" DataField="TestActiveTo" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                <%--<asp:BoundField HeaderText="Status" DataField="Status" HeaderStyle-HorizontalAlign="Center"/>--%>
                                <asp:BoundField HeaderText="Assigned To (Class)" DataField="AssignedTo" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkViewTest" runat="server" Text="View Question Paper" CssClass="btn-link" Target="_blank" NavigateUrl='<%# "QuestionPaper.aspx?TestId="+ Eval("TestId") +"&Mode=Offline" %>'></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No# of Students Took Test">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkStudents" runat="server" Target="_blank"></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <div id="divOnlineEmpty" runat="server" class="text-center" style="display: none">
                            <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card-footer small text-muted"></div>
            </div>

            <div class="card mb-3">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">Offline Tests</div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <%--AllowPaging="true" PageSize="50" OnPageIndexChanging="grdTestOffline_PageIndexChanging"--%>
                        <asp:GridView ID="grdTestOffline" runat="server" CssClass="table table-bordered dataTable1" OnRowDataBound="grdTestOffline_RowDataBound" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Type" DataField="TestType" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="True" HeaderText="Concepts">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Button ID="btnViewConcepts" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' CssClass="btn-link" OnClick="btnViewConcepts_Click"
                                                Text="View" CommandArgument='<%# Eval("TestId") %>' Style="border: none; cursor: pointer;" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Questions per Concept" DataField="NoOfQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Assigned To (Class)" DataField="AssignedTo" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkViewTest" runat="server" Text="View Question Paper" CssClass="btn-link" Target="_blank" NavigateUrl='<%# "QuestionPaper.aspx?TestId="+ Eval("TestId") +"&Mode=Offline" %>'></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No# of Students Took Test">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkStudents" runat="server" Target="_blank"></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <div id="divOfflineEmpty" runat="server" class="text-center" style="display: none">
                            <asp:Label ID="Label1" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card-footer small text-muted"></div>
            </div>

            <div class="card mb-3" id="divZeroNet" runat="server" style="display: none">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">ZeroNet Tests</div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="grdZeroNet" runat="server" CssClass="table table-bordered dataTable2" OnRowDataBound="grdZeroNet_RowDataBound" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Type" DataField="TestType" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="True" HeaderText="Concepts">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Button ID="btnViewConcepts" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' CssClass="btn-link" OnClick="btnViewConcepts_Click"
                                                Text="View" CommandArgument='<%# Eval("TestId") %>' Style="border: none; cursor: pointer;" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Questions per Concept" DataField="NoOfQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Assigned To (Class)" DataField="AssignedTo" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkViewTest" runat="server" Text="View Question Paper" CssClass="btn-link" Target="_blank" NavigateUrl='<%# "QuestionPaper.aspx?TestId="+ Eval("TestId") +"&Mode=Offline" %>'></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No# of Students Took Test">
                                    <ItemTemplate>
                                        <div>
                                            <asp:HyperLink ID="lnkStudents" runat="server" Target="_blank"></asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <div id="divZeroNetEmpty" runat="server" class="text-center" style="display: none">
                            <asp:Label ID="Label2" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card-footer small text-muted"></div>
            </div>


            <%-- Modal for Viewing Concepts --%>
            <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Test Concepts for <b>
                                <asp:Literal ID="ltlConcept" runat="server"></asp:Literal></b></h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body" style="text-align: center">
                            <asp:GridView ID="grdConcepts" runat="server" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 50%; text-align: center; margin-bottom: 10px; margin: 0 auto;" EmptyDataRowStyle-BorderColor="White">
                                <Columns>
                                    <asp:BoundField DataField="ConceptName" HeaderText="Concepts" HeaderStyle-HorizontalAlign="Center" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <label style="color: red;">No Data Found</label>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>


    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>
    <script>
        function pageLoad(sender, args) {
            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();
            $(".dataTable").DataTable(
                {
                    columns: [
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: false },
                        { orderable: true },
                        { orderable: false },
                        { orderable: false }
                    ]
                });


            $(".dataTable1 tbody").before("<thead><tr></tr></thead>");
            $(".dataTable1 thead tr").append($(".dataTable1 th"));
            $(".dataTable1 tbody tr:first").remove();
            $(".dataTable1").DataTable(
                {
                    columns: [
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: false }
                    ]
                });


            $(".dataTable2 tbody").before("<thead><tr></tr></thead>");
            $(".dataTable2 thead tr").append($(".dataTable2 th"));
            $(".dataTable2 tbody tr:first").remove();
            $(".dataTable2").DataTable(
               {
                    columns: [
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: true },
                        { orderable: true },
                        { orderable: true },
                        { orderable: false },
                        { orderable: false }
                    ]
                });

            $('#ContentPlaceHolder1_grdTests_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
            $('#ContentPlaceHolder1_grdTestOffline_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');

        }
         // });
    </script>
    <script type="text/javascript">
        function openModal() {
            $("#myModal").modal("show");
        }
    </script>
    <script>
        $(document).ready(function () {
            $('#collapseComponents li').removeClass("current-menu-item");
            $('#liViewResults').addClass('current-menu-item');
            $("#collapseComponents").addClass('sidenav-second-level collapse show');

        });
    </script>
</asp:Content>
