<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/DE/de.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AssessRite.DE.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlWelcome" runat="server">
        <div class="breadcrumb">
            <h5 class="breadcrumbheading">Welcome to AssessRite</h5>
        </div>
        <h4>Instructions</h4>
       
        <h6 style="margin-left:5px;">1. Add Class</h6>
        <p style="margin-left:5px">Please select and add all the classes in your school using Add/View Class. </p>
        <br />
          <h6 style="margin-left:5px;">2. Add Subject</h6>
        <p style="margin-left:5px">Please select class and add subjects to respective classes using Add/View Subject</p>
        <br />
          <h6 style="margin-left:5px;">3. Add Concept</h6>
        <p style="margin-left:5px">After adding classes and subject, please add concepts to each subject by navigating to Add/View Concept</p>
        <br />
         <h6 style="margin-left:5px;">4. Add Objective</h6>
        <p style="margin-left:5px">After adding classes,subject and concepts for each subjects, please add objectives for each concept by navigating to Add/View Objective</p>
        <br />
         <h6 style="margin-left:5px;">5. Add Questions</h6>
        <p style="margin-left:5px">Once all classes, subjects, concepts and objectives have been added, start adding questions to the question bank. Questions can be of 3 types.</p>
        <ul>
            <li>Multiple Choice</li>
            <li>Brief Answer</li>
            <li>Multiple Choice With Images</li>
        </ul>
        <br />
    </asp:Panel>
</asp:Content>
