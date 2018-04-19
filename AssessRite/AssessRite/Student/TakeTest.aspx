<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Student/student.Master" AutoEventWireup="true" CodeBehind="TakeTest.aspx.cs" Inherits="AssessRite.Student.TakeTest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
        $(document).ready(function () {
            window.history.pushState(null, "", window.location.href);
            window.onpopstate = function () {
                window.history.pushState(null, "", window.location.href);
            };
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .grid td, .grid th {
            text-align: center !important;
        }
    </style>
    <%--<script type="text/javascript">
        function getDateTime() {
            var currentTime = new Date()
            var month = currentTime.getMonth() + 1
            var day = currentTime.getDate()
            var year = currentTime.getFullYear()
            var todaysdate = month + "/" + day + "/" + year
            //document.write(month + "/" + day + "/" + year)
            var hours = currentTime.getHours()
            var minutes = currentTime.getMinutes()
            if (minutes < 10) {
                minutes = "0" + minutes
            }
            var AMPM = ""
            if (hours > 11) {
                AMPM = "PM"
            } else {
                AMPM = "AM"
            }
            var time = hours + ":" + minutes + AMPM;
            //alert(todaysdate + " " + time);
            document.getElementById("<%= hdnDate.ClientID %>").value = todaysdate;
            document.getElementById("<%= hdnCurrentTime.ClientID %>").value = time;
        }
    </script>--%>
   <%-- <script>
        function pageLoad(sender, args) {
            
        }
        // });
    </script>--%>
    <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            //$('#liTest').addClass('current-menu-item');
            $('#liForStudent').addClass('active');
        });
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Take Test
        </h5>
    </div>
    <asp:Timer ID="TestEnableTimer" runat="server" Interval="1000" OnTick="TestEnableTimer_Tick">
    </asp:Timer>
    <asp:HiddenField ID="hdnTimeZone" runat="server" />
    <asp:HiddenField ID="hdnDate" runat="server" />
    <asp:HiddenField ID="hdnCurrentTime" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TestEnableTimer" EventName="Tick" />
        </Triggers>
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <div class="card mb-3">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-lg-12" style="text-align: center">Active Tests</div>
                            </div>
                        </div>
                        <div class="card-body">

                            <div class="table-responsive">
                                <asp:GridView ID="grdTests" runat="server" CssClass="table table-bordered" OnRowDataBound="grdTests_RowDataBound" Width="100%" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                                    <Columns>
                                        <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                        <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                        <asp:BoundField HeaderText="Test Date" DataField="TestDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:TemplateField ShowHeader="True" HeaderText="Active From">
                                            <ItemTemplate>
                                                <div>
                                                    <asp:Label ID="lblTimeFrom" runat="server" Text='<%# DateTime.Parse(Eval("TestActiveFrom").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="True" HeaderText="Active To" HeaderStyle-Width="87px">
                                            <ItemTemplate>
                                                <div>
                                                    <asp:Label ID="lblTimeTo" runat="server" Text='<%# DateTime.Parse(Eval("TestActiveTo").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <div>
                                                    <asp:Button ID="btnTakeTest" runat="server" Text="Take Test" CssClass="btn btn-default" OnClick="btnTakeTest_Click" Enabled="false" CommandArgument='<%# Eval("TestId") %>' CommandName='<%# Eval("TestAssignedId") %>'></asp:Button>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:Label ID="lblEmpty" runat="server" Text="No Tests Found For You" Style="color: red; font-size: small;"></asp:Label>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <div id="divLoading" runat="server" style="display: block; text-align: center;">
                                <img src="../Images/download.gif" />
                                <h4>Loading...</h4>
                            </div>
                        </div>
                        <div class="card-footer small text-muted"></div>
                    </div>
                </div>
                <div class="col-lg-2"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <div class="container">

        <div class="col-md-12" style="text-align: center">
        </div>

        <%-- <div class="row" style="margin-top: 10px;">
            <div class="col-md-12">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="col-md-4" style="margin-top: 5px;">
                        <asp:Label ID="lblSearch" runat="server" Text="Enter Test Key"></asp:Label>
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtTestKey" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnGo" runat="server" CssClass="btn btn-primary" Text="Go to Test" OnClick="btnGo_Click" />
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>--%>
        <%--<div class="row" id="divError" runat="server" style="margin-top: 15px; display: none;">
            <div class="col-md-12" style="text-align: center;">
                <asp:Label ID="lblError" runat="server" Style="color: red; font-size: 13px" Text="Invalid TestKey. Please Enter a valid 6 digit TestKey"></asp:Label>
            </div>
        </div>--%>
    </div>
    <script>
        function pageLoad(sender, args) {
           <%-- var offset = new Date().toTimeString();
            $('#<%=hdnTimeZone.ClientID%>').val(offset);--%>
            var offset = new Date().toTimeString();
            $('#<%=hdnTimeZone.ClientID%>').val(offset);
        }
        // });
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
