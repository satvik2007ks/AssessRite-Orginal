<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Student/student.Master" AutoEventWireup="true" CodeBehind="ViewResult.aspx.cs" Inherits="AssessRite.Student.ViewResult" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
        $(document).ready(function () {
            window.history.pushState(null, "", window.location.href);
            window.onpopstate = function () {
                window.history.pushState(null, "", window.location.href);
            };
        });
    </script>
    <style>
        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Results</h5>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="grdTests" runat="server" CssClass="table table-bordered dataTable" OnRowDataBound="grdTests_RowDataBound" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                            <Columns>
                                <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                <asp:BoundField HeaderText="Test Taken On" DataField="TestDateTime" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Result">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblResult" runat="server"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="TestAssignedId" DataField="TestAssignedId" Visible="false" />
                            </Columns>
                            <EmptyDataTemplate>
                                <asp:Label ID="lblEmpty" runat="server" Text="No Tests Found For You" Style="color: red; font-size: small;"></asp:Label>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--<div class="container">
        <div class="row" style="text-align: center">
            <h2>Active Tests</h2>
        </div>
        <hr />
        <div class="row" style="margin-top: 10px">
            <div class="col-md-12" style="text-align: center">
            </div>
        </div>
    </div>--%>
    <script>
        $(document).ready(function () {
            //$("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            ////$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            ////$('#liTest').addClass('current-menu-item');
            //$('#liForStudent').addClass('active');
            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();
            $(".dataTable").DataTable();
        });
    </script>
      <script type="text/javascript">
        if (document.layers) {
            //Capture the MouseDown event.
            document.captureEvents(Event.MOUSEDOWN);

            //Disable the OnMouseDown event handler.
            document.onmousedown = function () {
                return false;
            };
        }
        else {
            //Disable the OnMouseUp event handler.
            document.onmouseup = function (e) {
                if (e != null && e.type == "mouseup") {
                    //Check the Mouse Button which is clicked.
                    if (e.which == 2 || e.which == 3) {
                        //If the Button is middle or right then disable.
                        return false;
                    }
                }
            };
        }

        //Disable the Context Menu event.
        document.oncontextmenu = function () {
            return false;
        };
    </script>
</asp:Content>
