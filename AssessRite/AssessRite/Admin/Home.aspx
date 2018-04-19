<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AssessRite.Admin.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlWelcome" runat="server">
        <div class="breadcrumb">
            <h5 class="breadcrumbheading">Welcome to AssessRite</h5>
        </div>
        <div style="margin-left:15px;">
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
          <h6 style="margin-left:5px;">6. Add Academic Year</h6>
        <p style="margin-left:5px">Please add academic year every year. This will be one time adding every year. To add please go to Manage Academic Year under Settings.</p>
        <br />
         <h6 style="margin-left:5px;">7. Add/View Teacher</h6>
        <p style="margin-left:5px">Please add all the teachers and provide them login details. This will allow them to login, create tests, schedule test, view results and view assessment report for the students.</p>
        <br />
         <h6 style="margin-left:5px;">8. Add/View Students</h6>
        <p style="margin-left:5px">Please add all the students and provide them login details. This will allow them to login, take test and view results </p>
        <br />
       </div>
    </asp:Panel>
    <asp:Panel ID="pnlDashboard" runat="server" style="display:none;">
        <div class="breadcrumb">
            <h5 class="breadcrumbheading">Dashboard</h5>
        </div>
        <div class="row">
        <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i> Bar Chart Example</div>
            <div class="card-body">
              <canvas id="myBarChart" width="100" height="50"></canvas>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>
        </div>
        <div class="col-lg-6">
          <!-- Example Pie Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-pie-chart"></i> Pie Chart</div>
            <div class="card-body">
              <canvas id="myPieChart" width="100%" height="100"></canvas>
            </div>
            <div class="card-footer small text-muted"></div>
          </div>
        </div>
      </div>
    </asp:Panel>
</asp:Content>
