<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="AssessRite.Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report</title>
    <%-- <script src="Scripts/jquery-1.11.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>--%>
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="http://fonts.googleapis.com/css?family=Arvo:400,700|" rel="stylesheet" type="text/css" />
   <%-- <link href="../fonts/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Percentage.css" rel="stylesheet" />--%>
    <%-- <link href="Content/style.css" rel="stylesheet" />--%>
    <style>
        .grid td, .grid th {
            text-align: center !important;
            font-weight: normal;
        }

        @media print {
            body {
                -webkit-print-color-adjust: exact;
            }
        }
        .MistakesCSS{
            margin-top:20px;
            text-align:center;
        }
    </style>
   
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
        <a class="navbar-brand" href="index.html">
            <img src="../../Images/logo.png" /></a>
    </nav>
    <form id="form1" runat="server">
        <div class="col-md-12">
        <%--  <div class="row">
                <asp:Button ID="btnDoqnload" runat="server" Text="Download" OnClick="btnDoqnload_Click"/>
            </div>--%>
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <div class="row" style="text-align: center">
                        <h2 style="font-family: sans-serif;">Assessment Report</h2>
                    </div>
                </div>
                <div class="col-md-2"></div>
            </div>
            <div class="row" style="border-style:double;background-color: white;">
                <div class="col-md-2"></div>
                <div class="col-md-8">

                    <div class="row" style="margin-top: 20px">
                        <div class="col-md-12" style="text-align: left">
                            <asp:LinkButton ID="lnkExport" runat="server" OnClick="lnkExport_Click" Visible="false">Export to PDF<span class="glyphicon glyphicon-download-alt" aria-hidden="true" ></span></asp:LinkButton>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 20px; text-align: center">
                        <h3>Result</h3>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <asp:GridView ID="grdBasic" runat="server" OnRowDataBound="grdBasic_RowDataBound" AutoGenerateColumns="false" AllowPaging="true" PageSize="50" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" CssClass="grid" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="Black" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Student Name" DataField="Name" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Academic Year" DataField="AcademicYear" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Type" DataField="TestType" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Date" DataField="TestDateTime" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Test Class" DataField="TestClass" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Result">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblResult" runat="server"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>


                    <div class="row MistakesCSS" id="divMistakes" runat="server">
                        <h3 style="font-family: sans-serif;">Analysis of Mistakes</h3>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <asp:GridView ID="grdMistakes" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="grdMistakes_PageIndexChanging" AllowPaging="true" PageSize="100" EmptyDataRowStyle-BorderStyle="None"  EmptyDataRowStyle-BorderColor="#F1F1F1" CssClass="grid" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="Black" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Question No#" DataField="QuestionNo" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Concept" DataField="ConceptName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Objective" DataField="ObjectiveName" HeaderStyle-HorizontalAlign="Center" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="row" style="margin-top: 20px; text-align: center">
                        <h3 style="font-family: sans-serif;">Analysis of Mistakes by Concepts</h3>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <asp:GridView ID="grdConceptsAnalysis" runat="server" OnRowDataBound="grdConceptsAnalysis_RowDataBound"  AutoGenerateColumns="false" AllowPaging="true" PageSize="100" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" CssClass="grid" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="Black" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="Concept" DataField="Concept" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Appeared in Lower Classes" DataField="LowerClasses" HeaderStyle-HorizontalAlign="Center" />

                                <asp:TemplateField HeaderText="Correct / Total">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblCorrectTotal" runat="server" Text='<%# Eval("CorrectTotal") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Correct Percentage">
                                    <ItemTemplate>
                                        <%--  <div>--%>
                                        <div class="w3-light-grey">
                                            <div class="w3-container w3-blue" id="divPercent" runat="server" style="width: 75%; background-color:green">
                                                <asp:Label ID="lblPercentage" runat="server" Text='<%# Eval("Percentage") %>'></asp:Label>
                                            </div>
                                        </div>

                                        <%--</div>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
                <div class="col-md-2"></div>
            </div>
        </div>
    </form>
</body>
</html>
