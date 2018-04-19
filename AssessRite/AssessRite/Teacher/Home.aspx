<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="AssessRite.Teacher.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Panel ID="pnlWelcome" runat="server" style="display:block;">
        <div class="breadcrumb">
            <h5 class="breadcrumbheading">Welcome to AssessRite</h5>
        </div>
        <h4>Instructions</h4>
        <h6 style="margin-left:5px;">1. Create Test</h6>
        <p style="margin-left:5px">Create test page is used for creating test by selecting class, subject and concepts. You will have the option to select multiple concepts. Test can be of two types. Online or offline. Online test will have only multiple choice questions and result is instantaneous. Offline tests will pick some brief answer questions and this has to be manualy evaluated by using manual result entry form.  This also has the option to enter number of questions required per concept. For eg: If you have entered 5 in number of questions per concept, assessrite will pick 5 questions per each concept selected in the checkbox. You will have the option to view the question paper as soon as the test is created.  </p>
        <br />
          <h6 style="margin-left:5px;">2. View/ Schedule Test</h6>
        <p style="margin-left:5px">View/ Schedule test is primariliy used for viewing all the tests whihch has been created. You will have the option to schedule or reschedule the particular test. Any Online test can be scheduled to any date and period of time. Students will be able to view and take test only during that time period. </p>
        <br />
          <h6 style="margin-left:5px;">3. Scheduled Test</h6>
        <p style="margin-left:5px">All scheduled tests can be viewed in this page. You will have the option to searh and sort the test based on date created, class, subject...etc. This will have only online tests since offline tests cannot be scheduled</p>
        <br />
         <h6 style="margin-left:5px;">4. View Results</h6>
        <p style="margin-left:5px">View result page will contain the results of all the tests. Searching and sorting can be done here too. You can view the results and Assessment report of each student. You can also view the list of students who tok the test and who didn't take the test.</p>
        <br />
         <h6 style="margin-left:5px;">5. Manual Result Entry</h6>
        <p style="margin-left:5px">Manual result entry page is used to enter results of offline test. You will have to select the test, class for which resulted has to be entered and student and enter result.  </p>
        <br />
        <br />
       
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
    <%-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>--%>
</asp:Content>
