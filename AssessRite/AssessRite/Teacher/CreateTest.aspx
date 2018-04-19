<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="CreateTest.aspx.cs" Inherits="AssessRite.CreateTest" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
         .checkbox, .radio {
            position: relative;
            display: block;
            margin-top: 10px;
            margin-bottom: 10px;
        }

            .checkbox label, .radio label {
                min-height: 20px;
                padding-left: 10px;
                margin-bottom: 0;
                font-weight: 400;
                cursor: pointer;
            }

            .checkbox td {
                text-align: left !important;
            }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Create Test</h5>
    </div>
    <asp:UpdatePanel ID="updPnl" runat="server">
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
                            <div id="divTest" runat="server">
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-md-12" style="text-align: center">
                                        <asp:Button ID="btnNew" runat="server" Text="New" CssClass="btn btn-primary" OnClick="btnNew_Click" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label5" runat="server" Text="Test Type" Style="font-size: 15px;"></asp:Label>
                                    <asp:DropDownList ID="ddlTestType" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlTestType_SelectedIndexChanged" AutoPostBack="true">
                                        <%--<asp:ListItem Value="-1">--Select--</asp:ListItem>
                                        <asp:ListItem Value="Online">Online(Instant Result)</asp:ListItem>
                                        <asp:ListItem Value="Offline">Offline(Manual Result)</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group" id="divQuestionType" runat="server" style="display: none">
                                    <asp:Label ID="Label6" runat="server" Text="Type of Questions" Style="font-size: 15px;"></asp:Label>
                                    <asp:CheckBoxList ID="chkQuestionType" runat="server" CssClass="form-control checkbox">
                                        <asp:ListItem Value="1">Multiple Choice</asp:ListItem>
                                        <asp:ListItem Value="2">Brief Answer</asp:ListItem>
                                        <asp:ListItem Value="3">Multiple Choice With Images</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label2" runat="server" Text="Class" Style="font-size: 15px;"></asp:Label>
                                    <asp:DropDownList ID="ddlTestClass" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlTestClass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label3" runat="server" Text="Subject" Style="font-size: 15px;"></asp:Label>
                                    <asp:DropDownList ID="ddlTestSubject" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlTestSubject_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="form-group" id="divConcept" style="margin-top: 5px; display: none" runat="server">
                                    <asp:Label ID="Label45" runat="server" Text="Concept" Style="font-size: 15px;"></asp:Label>
                                    <fieldset>
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" onkeyup="SearchEmployees();" placeholder="Search">
                                        </asp:TextBox>
                                        <span id="spnCount"></span>
                                        <div class="scrollcustom" style="max-height: 250px; overflow-y: auto; margin-top: 10px;">
                                            <div class="col-md-12">
                                                <asp:CheckBox ID="chkConceptsAll" runat="server" CssClass="checkbox" Style="text-align: left;" OnCheckedChanged="chkConceptsAll_CheckedChanged" AutoPostBack="true" Text="All"></asp:CheckBox>
                                            </div>
                                            <div class="col-md-12">
                                                <asp:CheckBoxList runat="server" ID="chkConcepts" CssClass="checkbox" RepeatDirection="Vertical" ClientIDMode="Static" Style="text-align: left;" OnSelectedIndexChanged="chkConcepts_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="form-group">
                                    <asp:Label ID="Label4" runat="server" Text="Questions Per Concept" Style="font-size: 14px;"></asp:Label>
                                    <asp:TextBox ID="txtNoOfQuestions" runat="server" CssClass="form-control onlynumber" MaxLength="2"></asp:TextBox>
                                </div>
                                <div class="col-md-12 textcenter">
                                    <label style="color: darkorange; font-style: normal; font-size: 12px">(Note*:Questions Per Concept. Not Total No# of Questions in the Test)</label>
                                </div>
                            </div>
                            <div class="row textcenter" style="display: none" id="divError" runat="server">
                                <asp:Label ID="lblError" runat="server" Style="color: red" Text=""></asp:Label>
                            </div>
                            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align: center;">
                                    <asp:Button ID="btnCreateTest" runat="server" CssClass="btn btn-primary" Text="Create Test" OnClick="btnCreateTest_Click" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="row textcenter">
                                <asp:Label ID="lblTotQuestions" runat="server" Style="color: green;margin:0 auto;"></asp:Label>
                            </div>
                            <div class="row textcenter" style="margin-top: 10px; margin-bottom: 5px; display: none;" runat="server" id="divOffline">
                                <asp:HyperLink ID="link" runat="server" Target="_blank" Text="Click here "></asp:HyperLink>
                                <asp:Label ID="Label1" runat="server" Text="to View/Print the Question Paper for the Offline Test"></asp:Label>
                            </div>
                        </div>
                        <div class="card-footer small text-muted"></div>
                    </div>
                </div>
                <div class="col-lg-3"></div>
            </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>




    <%--  <div class="container">
        <div class="row" style="margin-top: 5%;">
            <div class="col-md-2"></div>
            <div class="col-md-8" style="text-align: center; background-color: #F1F1F1; border-radius: 15px;">
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4" style="text-align: center;">
                        <h3>Create Test</h3>
                    </div>
                    <div class="col-md-4"></div>
                </div>



            </div>
            <div class="col-md-2"></div>
        </div>
    </div>--%>
    <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            //$('#liTest').addClass('current-menu-item');
            $('#liTest').addClass('active');
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(bindKeyDown);
            bindKeyDown();
        });
        function bindKeyDown() {
            $('.onlynumber').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });
        }
    </script>
    <script type="text/javascript">
        function SearchEmployees() {
            //alert("Coming");
            if ($(<%=txtSearch.ClientID%>).val() != "") {
                var count = 0;
                $(<%=chkConcepts.ClientID%>).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(<%=txtSearch.ClientID%>).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCount').html((count) + ' match');
            }
            else {
                $(<%=chkConcepts.ClientID%>).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCount').html('');
            }
        }

     <%--   $('#<%=ddlTestType.ClientID%>').change(function () {
            var selectedVal = $('#<%=ddlTestType.ClientID%> option:selected').attr('value');
            if (selectedVal == 'Offline') {
                $('#divQuestionType').css("display", "block");
            }
            else {
                $('#divQuestionType').css("display", "none");
            }

        });--%>
    </script>
</asp:Content>
