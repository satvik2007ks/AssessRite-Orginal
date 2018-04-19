<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/SME/sme.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AssessRite.SME.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Panel ID="pnlWelcome" runat="server">
        <div class="breadcrumb">
            <h5 class="breadcrumbheading">Welcome to AssessRite</h5>
        </div>
        <h4>Instructions</h4>
       
        <h6 style="margin-left:5px;">1. Review Questions</h6>
        <p style="margin-left:5px">Please select Review Questions page and to review the questions entered by DE. You will have the option to approve the question or reject the question. If you are rejecting the question, you need to enter the comment as the reason for rejection. This comment will be able to be seen by the DE for correcting the question. </p>
        <br />
        <br />
    </asp:Panel>
</asp:Content>
