<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Student/student.Master" AutoEventWireup="true" CodeBehind="StudentQuestionPaper.aspx.cs" Inherits="AssessRite.StudentQuestionPaper" %>

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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row" style="margin-top: 20px">
        <asp:Button ID="printButton" runat="server" Text="Print Test" OnClientClick="javascript: Print('divMain');" Style="cursor: pointer; margin: 0 auto;" />
    </div>
    <div id="divMain">
        <%--<input type="button" id="btnPrint" onclick="javascript: CallPrint('MasterDiv');" value="Print Test" />--%>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="row" style="text-align: center">
                        <h3>Unique Test Key :
                            <asp:Label ID="lblTestKey" runat="server"></asp:Label></h3>
                    </div>
                    <div class="row" style="text-align:center">
                        <h4>Subject :
                        <asp:Label ID="lblSubject" runat="server"></asp:Label></h4>
                    </div>
                </div>
                <%--<div class="container">
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="margin-left: 45px;">
                            <div class="row">
                                <div class="col-md-5">
                                    <label>Test Key : </label>
                                </div>
                                <div class="col-md-7">

                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                        </div>
                    </div>
                </div>--%>

                <div class="container" style="margin-top: 20px;">
                    <asp:HiddenField ID="hdnTestAssignedId" runat="server" />
                    <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
                        <ItemTemplate>
                            <%-- <div class="row" style="margin-top: 10px; margin-bottom: 25px;">--%>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:HiddenField ID="hdnTestQuestionId" runat="server" Value='<%# Eval("TestQuestionId")%>' />
                                    <asp:HiddenField ID="hdnQuestionId" runat="server" Value='<%# Eval("QuestionId")%>' />
                                    <asp:HiddenField ID="hdnAnswerTypeId" runat="server" Value='<%# Eval("AnswerTypeId")%>' />
                                    <asp:Image ID="imgStatus" runat="server" Visible="false" Width="25" Height="25" />
                                    <asp:Label ID="lblQuestionNo" runat="server" Text='<%# Eval("QuestionNo")+")"%>'></asp:Label>
                                    <%--<asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question")%>'></asp:Label>--%>
                                    <asp:Literal ID="lblQuestion" runat="server" Text='<%# Regex.Replace(Server.HtmlDecode(Eval("Question").ToString().Substring(3)),"<p>&nbsp;</p>","")%>' Mode="PassThrough"></asp:Literal>

                                </div>
                                <%--<div class="col-md-1"></div>--%>
                            </div>
                            <div class="row">
                                <div class="col-md-12" runat="server" id="divBrief" style="display: none;">
                                    <asp:TextBox ID="txtAnswer" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row" runat="server" id="divOptions" style="display: block;">
                                    <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-8">
                                            <div class="col-md-3"></div>
                                            <div class="col-md-9">
                                                <asp:RadioButtonList ID="radbtnOptions" runat="server" CssClass="radio radio-inline"></asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" style="margin-left: 60px">
                                        <div id="divAnswer" class="row" runat="server" style="display: none;">
                                            <label>Right Answer: </label>
                                            <asp:Label ID="lblRightAnswer" runat="server"></asp:Label>
                                            <asp:Image ID="imgRightAnswer" runat="server" Visible="true" Width="80" Height="60" />
                                            <br /><br />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--</div>--%>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="row" style="text-align: center; margin-bottom: 10px;">
                        <div class="col-md-12">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        //function CallPrint(strid, btn) {
        //    var ButtonControl = document.getElementById("btnPrint");
        //    ButtonControl.style.visibility = "hidden";
        //    var prtContent = document.getElementById(strid);
        //    var WinPrint = window.open('', '', 'letf=0,top=0,width=800,height=400,toolbar=0,scrollbars=0,status=0,dir=ltr');
        //    WinPrint.document.write(prtContent.innerHTML);
        //    WinPrint.document.close();
        //    WinPrint.focus();
        //    WinPrint.print();
        //    WinPrint.close();
        //    prtContent.innerHTML = strOldOne;
        //    $('#btnPrint').hide();
        //}
       <%-- function Print() {
            $("#<%=printButton.ClientID%>").hide();
            $('#MasterFooter').hide();
            window.print();
            $("#<%=printButton.ClientID%>").hide();
        }--%>
        function Print(divID) {
            $("#<%=printButton.ClientID%>").hide();
             $('#MasterFooter').hide();
             //Get the HTML of div
             var divElements = document.getElementById(divID).innerHTML;
             //Get the HTML of whole page
             var oldPage = document.body.innerHTML;

             //Reset the page's HTML with div's HTML only
             document.body.innerHTML =
               "<html><head><title></title></head><body><img src='../Images/AssessRiteLogo.Full.png' />" +
               divElements + "</body>";

             //Print Page
             window.print();

             //Restore orignal HTML
             document.body.innerHTML = oldPage;
             $("#<%=printButton.ClientID%>").show();

        }
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
