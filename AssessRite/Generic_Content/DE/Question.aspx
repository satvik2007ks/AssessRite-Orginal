<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/DE/GCDE.Master" AutoEventWireup="true" CodeBehind="Question.aspx.cs" Inherits="AssessRite.Generic_Content.DE.Question" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .table1 tr, td, th {
            text-align: center !important;
        }

        .hideGridColumn {
            display: none;
        }

        .mce-statusbar {
            display: none;
        }

        .mce-content-body {
            font-size: 16pt !important;
        }

        .topmargin {
            margin-top: 20px;
        }

        .marginbottom {
            margin-bottom: 20px;
        }

        .fade.in {
            opacity: 1;
        }

        .modal.in .modal-dialog {
            -webkit-transform: translate(0, 0);
            -o-transform: translate(0, 0);
            transform: translate(0, 0);
        }

        .modal-backdrop.in {
            opacity: 0.5;
        }

        .center{
            text-align:center !important;
        }
         </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add / View Questions</h5>
    </div>
    <div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <div class="card mb-3">
                <%-- <div class="card-header">--%>
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">
                        <h5 style="font-weight: 100">Select Options</h5>
                    </div>
                    <%--<div class="col-lg-6" style="text-align: center"></div>--%>
                </div>
                <%-- </div>--%>
                <div class="card-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <%--  <Triggers>
                        <asp:PostBackTrigger ControlID="btnQuestionsSave" />
                        <asp:PostBackTrigger ControlID="btnNew" />
                        <asp:PostBackTrigger ControlID="btnContinue" />
                        <asp:PostBackTrigger ControlID="btnCancel" />
                    </Triggers>--%>
                        <ContentTemplate>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <div class="form-group">
                                <asp:Label ID="lblClassName" runat="server" Text="Class"></asp:Label>
                                <asp:DropDownList ID="ddlClassName" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlClassName_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblConcepts" runat="server" Text="Concepts"></asp:Label>
                                <asp:DropDownList ID="ddlConcepts" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlConcepts_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblObjectives" runat="server" Text="Objectives"></asp:Label>
                                <asp:DropDownList ID="ddlObjectives" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <div class="col-lg-12" style="text-align: center">
                            <h5 style="font-weight: 100">Add Question</h5>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row" style="margin-top: 10px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center">
                                    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary" Text="Clear and Add New" OnClick="btnNew_Click" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblQuestion" runat="server" Text="Question"></asp:Label>
                                <asp:TextBox ID="txtQuestion" runat="server" TextMode="multiline" CssClass="form-control mytexteditor" MaxLength="3500"></asp:TextBox>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnQuestionsSave" />
                            <asp:PostBackTrigger ControlID="btnNew" />
                            <asp:PostBackTrigger ControlID="btnContinue" />
                            <asp:PostBackTrigger ControlID="btnCancel" />
                            <%--<asp:PostBackTrigger ControlID="ddlAnswerType" />--%>
                            <asp:AsyncPostBackTrigger ControlID="ddlAnswerType" EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="form-group">
                                <asp:Label ID="lblAnswerType" runat="server" Text="AnswerType"></asp:Label>
                                <asp:DropDownList ID="ddlAnswerType" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlAnswerType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="form-group" style="margin-top: 10px; display: none" id="divAnswerKey" runat="server">
                                <asp:Label ID="Label1" runat="server" Text="Answer Key"></asp:Label>
                                <asp:TextBox ID="txtAnswerKey" runat="server" CssClass="form-control mytexteditor" TextMode="MultiLine" MaxLength="3500"></asp:TextBox>
                            </div>
                            <div class="help-block center" id="divError" runat="server" style="display: none">
                                <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                            </div>
                            <div class="row marginbottom">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center">
                                    <asp:Button ID="btnQuestionsSave" runat="server" Text="Save Question" CssClass="btn btn-primary" OnClick="btnQuestionsSave_Click" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <label>Changing the Answer Type will remove all the options if you have entered. Do you still want to continue ?</label>
                                        </div>
                                        <div class="modal-footer">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click" />
                                            <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="btn btn-primary" OnClick="btnContinue_Click" Style="margin-bottom: 0px !important" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div id="divOptions" runat="server" style="display: none;">
                        <div class="row">
                            <div class="col-lg-12" style="text-align: center">
                                <h5 style="font-weight: 100">Option Entry</h5>
                            </div>
                        </div>
                        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                            <ItemTemplate>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnDelete" />
                                        <%--<asp:AsyncPostBackTrigger ControlID="ddlAnswerType" EventName="SelectedIndexChanged" />--%>
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="row" style="margin-top: 10px">
                                            <div class="col-md-2" style="margin-top: 5px; text-align: left;">
                                                <asp:Label ID="lblOption" runat="server" Text="Option"></asp:Label>
                                            </div>
                                            <div class="col-md-6" id="divTextItem" runat="server" style="display: none;">
                                                <asp:TextBox ID="txtOption" runat="server" TextMode="MultiLine" CssClass="form-control mytexteditorAns customheighttinymce" Text='<%#Eval("Answer") %>' Style="height: 50px !important;" MaxLength="3500"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6" id="divImageItem" runat="server" style="display: none;">
                                                <asp:Image ID="imgItem" runat="server" ImageUrl='<%#Eval("Answer") %>' Height="45" Width="50" Style="border-width: 0px;" />
                                            </div>
                                            <div class="col-md-3" style="margin-top: 5px; margin-bottom: 5px;">
                                                <asp:RadioButton ID="radbtnOption" runat="server" CssClass="radio radiogroupname" Text="Is Right Answer?" OnCheckedChanged="radbtnOption_CheckedChanged" AutoPostBack="true" GroupName="radRightAnswer" />
                                            </div>
                                            <div class="col-md-1" style="margin-top: 10px; text-align: center;">
                                                <asp:Button ID="btnDelete" runat="server" Text="X" ToolTip="Delete" CommandArgument='<%#Eval("AnswerId") %>' OnClick="btnDelete_Click" />
                                            </div>
                                            <%--<div class="col-md-1" style="margin-top:10px;">
                                            <asp:Button ID="btnOptionUpdate" runat="server" Text="Update" CssClass="btn" CommandArgument='<%#Eval("AnswerId") %>' OnClick="btnOptionUpdate_Click" />
                                        </div>--%>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </ItemTemplate>
                            <FooterTemplate>
                                <div class="row" style="margin-top: 10px">
                                    <div class="col-md-2" style="margin-top: 5px; text-align: left;">
                                        <asp:Label ID="Label2" runat="server" Text="Option"></asp:Label>
                                    </div>
                                    <div class="col-md-6" id="divText" runat="server" style="display: none;">
                                        <asp:TextBox ID="TextBox1" TextMode="MultiLine" runat="server" CssClass="form-control mytexteditorAns customheighttinymce" Style="height: 50px !important;" MaxLength="3500"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6" id="divImage" runat="server" style="display: none;">
                                        <div class="col-md-12">
                                            <asp:FileUpload ID="FileUpload1" runat="server" onchange="showpreview(this);" Style="background: inherit !important;" />
                                             <asp:Image ID="imgPreview" runat="server" CssClass="fileuploader" Height="45" Width="50" Style="border-width: 0px; visibility: hidden;" />
                                        </div>
                                       <%-- <div class="col-md-4">
                                           
                                        </div>--%>
                                    </div>
                                    <div class="col-md-3" style="margin-top: 5px; margin-bottom: 5px;">
                                        <asp:RadioButton ID="radbtnOptionSet" runat="server" CssClass="radio radio-inline" Text="Is Right Answer?" GroupName="radRightAnswer" OnCheckedChanged="radbtnOptionSet_CheckedChanged" AutoPostBack="true"/>
                                    </div>
                                    <div class="col-md-1" style="margin-top: 5px;">
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                                    </div>
                                </div>
                                <div class="row center" id="divError1" runat="server" style="display: none">
                                    <div class="col-md-12" style="margin-top: 5px;">
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" style="color:red;" ControlToValidate="txtOption" ErrorMessage="Option Text Required*"></asp:RequiredFieldValidator>--%>
                                        <asp:Label ID="lblError1" runat="server" Style="color: red" Text=""></asp:Label>
                                    </div>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div class="row" style="margin-bottom: 20px; margin-top: 20px">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update Options" CssClass="btn btn-primary" OnClick="btnUpdate_Click" Style="margin: 0 auto;" />
                            <asp:Label ID="lblUError" runat="server" Style="color: orange; font-size: small" Text="Note*:Image Options Cannot Be Updated. Please Delete and Upload New Images" Visible="false"></asp:Label>
                        </div>
                    </div>
                    <%--<div class="col-md-1"></div>--%>
                    <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblMsg" runat="server" Text="Question Saved Successfully"></asp:Label>
                    </div>

                    <%--</div>--%>
                    <%-- </div>--%>
                    <%--</div>--%>
                    <%-- </div>--%>
                </div>
            </div>
        </div>
        <div class="col-lg-2"></div>
    </div>
    <%-- <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            $('#liQuestion').addClass('current-menu-item');
            //$('#liQuestion1').addClass('current-menu-item');
            $('#subjectname').addClass('active');
        });
    </script>--%>

    <%-- <script type="text/javascript">
        function openModal() {
            $("#myModalQ").modal('show');
        }

    </script>--%>
    <%--<script src="../tinymce/js/tinymce/tinymce.min.js"></script>--%>
       <script src="../../js/tinymce.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            /* initial load of editor */
            LoadTinyMCE();
            $('.mce-statusbar').hide();
            // alert('working');
        });

        /* wire-up an event to re-add the editor */
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler_Page);

        /* fire this event to remove the existing editor and re-initialize it*/
        function EndRequestHandler_Page(sender, args) {
            //1. Remove the existing TinyMCE instance of TinyMCE
            tinymce.remove("#<%=txtQuestion.ClientID%>");
            tinymce.remove("#<%=txtAnswerKey.ClientID%>")
            //2. Re-init the TinyMCE editor
            LoadTinyMCE();
            //  alert('working');
            $('.mce-statusbar').hide();
            //  $('.mce-last').hide();
        }

        function BeforePostback() {
            // alert('working');
            tinymce.triggerSave();
        }

        function LoadTinyMCE() {
            /* initialize the TinyMCE editor */
            tinymce.init({
                mode: "specific_textareas",
                editor_selector: "mytexteditor",
                plugins: "charmap",
                toolbar: "charmap | removeformat",
                menubar: " "
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            /* initial load of editor */
            LoadTinyMCE1();
            $('.mce-statusbar').hide();
            // alert('working');
        });

        /* wire-up an event to re-add the editor */
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler_Page);

        /* fire this event to remove the existing editor and re-initialize it*/
        function EndRequestHandler_Page(sender, args) {
            //1. Remove the existing TinyMCE instance of TinyMCE
            tinymce.remove("#<%=txtQuestion.ClientID%>");
            tinymce.remove("#<%=txtAnswerKey.ClientID%>")
            //2. Re-init the TinyMCE editor
            LoadTinyMCE();
            //  alert('working');
            $('.mce-statusbar').hide();
            //  $('.mce-last').hide();
        }

        function BeforePostback() {
            // alert('working');
            tinymce.triggerSave();
        }

        function LoadTinyMCE1() {
            /* initialize the TinyMCE editor */
            tinymce.init({
                mode: "specific_textareas",
                editor_selector: "mytexteditorAns",
                plugins: "charmap",
                toolbar: "charmap | removeformat",
                menubar: " ",
                setup: function (ed) {
                    ed.on('init', function (args) {
                        var id = ed.id;
                        var height = 80;
                        document.getElementById(id + '_ifr').style.height = height + 'px';
                        //document.getElementById(id + '_tbl').style.height = (height + 30) + 'px';
                    });
                }
            });
        }
    </script>
    <script type="text/javascript">
        function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('.fileuploader').css('visibility', 'visible');
                    $('.fileuploader').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

    </script>
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
    <script src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        function showModal() {
            $("#myModal").modal('show');
        }
    </script>
</asp:Content>
