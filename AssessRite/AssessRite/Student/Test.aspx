<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Student/student.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="AssessRite.Student.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            window.history.pushState(null, "", window.location.href);
            window.onpopstate = function () {
                window.history.pushState(null, "", window.location.href);
            };
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container-fluid">
        <div class="row" style="text-align: center; margin-top: 20px;">
            <div class="col-10">
                <h3>Unique Test Key :
                            <asp:Label ID="lblTestKey" runat="server"></asp:Label></h3>
            </div>
            <div class="col">
            </div>
        </div>
         <div class="row" style="text-align:center; margin-top:5px;">
              <div class="col-10">
                        <h4>Subject :
                        <asp:Label ID="lblSubject" runat="server"></asp:Label></h4>
                    </div>
             </div>
         <div class="col">
            </div>
    </div>
    <hr />
    <div class="container-fluid" style="margin-top: 20px;">
        <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
            <ContentTemplate>--%>
        <div class="row" id="divMain" runat="server">
            <div class="col-10" style="border-radius: 2px; border-color: gray; border-width: 1px; border-style: solid; margin-right: 10px;">
                <%-- <asp:Timer ID="TestTimer" runat="server" Interval="1000">
                </asp:Timer>--%>
                <asp:HiddenField ID="hdnTestAssignedId" runat="server" />
                <asp:HiddenField ID="hdnTotal" runat="server" />
                <div class="row" style="text-align: center; display: none">
                    <asp:Label ID="Label1" runat="server" Text="Time Remaining"></asp:Label><asp:Label ID="lblTimer" runat="server"></asp:Label>
                </div>
                <div class="row" style="text-align: center;">
                    <div class="col-md-12" style="text-align: left; font-weight: bold">
                        <asp:Label ID="lblTotalQuestions" runat="server"></asp:Label>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-12">
                        <asp:HiddenField ID="hdnQuestionNo" runat="server" Value="1" />
                        <asp:HiddenField ID="hdnTestQuestionId" runat="server" />
                        <asp:HiddenField ID="hdnQuestionId" runat="server" />
                        <asp:HiddenField ID="hdnAnswerTypeId" runat="server" />
                        <asp:Image ID="imgStatus" runat="server" Visible="false" Width="25" Height="25" />
                        <asp:Label ID="lblQuestionNo" runat="server" Visible="false"></asp:Label>
                        <asp:Literal ID="lblQuestion" runat="server" Mode="PassThrough"></asp:Literal>
                    </div>
                </div>
                <div class="row" runat="server" id="divOptions" style="display: block;">
                    <div class="col-md-8">
                        <div class="col-md-3"></div>
                        <div class="col-md-9">
                            <asp:RadioButtonList ID="radbtnOptions" runat="server" CssClass="radio radio-inline"></asp:RadioButtonList>
                        </div>
                    </div>
                    <div class="col-md-4">
                    </div>
                </div>
                <div class="row" style="text-align: center; margin-bottom: 10px; margin-top: 20px;">
                    <div class="col" style="margin-left: 15px;">
                        <asp:Button ID="btnPrevious" runat="server" CssClass="btn btn-primary" Text="Previous" OnClick="btnPrevious_Click" Style="margin-left: 15px;" />
                    </div>
                    <div class="col" style="text-align: right">
                        <asp:Button ID="btnNext" runat="server" CssClass="btn btn-primary" Text="Save & Next" OnClick="btnNext_Click" />
                    </div>
                </div>

            </div>
            <div class="col" style="border-radius: 2px; border-color: gray; border-width: 1px; border-style: solid; display: none">
                <h6>Question Summary Palette:</h6>
                <div class="row">
                    <%--<asp:Panel ID="pnlPalette" runat="server">
                            </asp:Panel>--%>
                </div>
                <h6>Legend:</h6>
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-1" style="background-color: green; height: 20px"></div>
                    <div class="col-7">
                        <h6><small>Answered</small></h6>
                    </div>
                </div>
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-1" style="background-color: orange; height: 20px"></div>
                    <div class="col-8">
                        <h6><small>Not Answered</small></h6>
                    </div>
                </div>
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-1" style="background-color: mediumpurple; height: 20px"></div>
                    <div class="col-8">
                        <h6><small>Current Question</small></h6>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="divSummary" runat="server" style="display: none">
            <div class="col-10" style="border-radius: 2px; border-color: gray; border-width: 1px; border-style: solid; margin-right: 10px;">
                <h6>Question Summary Palette:</h6>
                <div class="row">
                    <div class="col-12">
                        <asp:Panel ID="pnlPalette" runat="server">
                        </asp:Panel>
                    </div>
                </div>
                <h6>Legend:</h6>
                <div class="row">
                    <div class="col-1" style="background-color: green; height: 20px; margin-left: 15px; max-width: 20px !important;"></div>
                    <div class="col-8">
                        <h6><small>Answered</small></h6>
                    </div>

                </div>
                <div class="row">
                    <div class="col-1" style="background-color: orange; height: 20px; margin-left: 15px; max-width: 20px !important;"></div>
                    <div class="col-8">
                        <h6><small>Not Answered</small></h6>
                    </div>
                </div>
                <%--<div class="row">
                            <div class="col-1"></div>
                            <div class="col-1" style="background-color: mediumpurple; height: 20px"></div>
                            <div class="col-8">
                                <h6><small>Current Question</small></h6>
                            </div>
                        </div>--%>
                <div class="row" style="margin-bottom: 10px; margin-top: 20px;">
                    <div class="col">
                        <asp:Button ID="btnGoBack" runat="server" CssClass="btn btn-primary" Text="Go Back" OnClick="btnGoBack_Click" />
                    </div>
                    <div class="col"></div>
                    <div class="col">
                        <asp:Button ID="btnFinish" runat="server" CssClass="btn btn-primary" Text="Finish" OnClick="btnFinish_Click" Style="width: 200px" />
                    </div>
                    <div class="col"></div>
                    <div class="col" style="text-align: right">
                    </div>

                </div>
            </div>
            <div class="col"></div>
        </div>

        <%-- </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>


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
