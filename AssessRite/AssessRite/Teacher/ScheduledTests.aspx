<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="ScheduledTests.aspx.cs" Inherits="AssessRite.ScheduledTests" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .grid td, .grid th {
            text-align: center !important;
        }

        .griddiv {
            height: 20px;
            margin-top: -3px;
        }

        .modal-ku {
            width: 1200px;
            margin: auto;
        }

        .table1 tr, td, th {
            text-align: center !important;
        }

        .lnk {
            border: none;
            cursor: pointer;
        }

        #loading {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(228, 228, 228, 0.31);
            z-index: 9999;
        }

        #loader {
            position: absolute;
            left: 50%;
            top: 40%;
            width: 100px;
            height: 100px;
            margin-left: -50px;
        }

        .dataTables_wrapper {
            margin-bottom: 20px !important;
        }
        .btnDisabled:hover{
            text-decoration:none;
            cursor:default;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">View Scheduled Tests</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-12">Scheduled Online Tests</div>
            </div>
        </div>
        <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="lblMsg" runat="server" Text="Scheduled Test Deleted Successfully"></asp:Label>
        </div>
        <div class="card-body">
            <div class="table-responsive hide">
            </div>
            <input type="hidden" id="hdnTestScheduledId" />
            <div class="table-responsive">
                <table class="table table-bordered" id="myTable" style="width: 100% !important">
                    <thead>
                        <tr>
                            <th style="display: none">TestId</th>
                            <th style="width: 65px;">Test Key</th>
                            <th style="width: 75px;">Test Type</th>
                            <th style="width: 30px;">Class</th>
                            <th style="width: 100px;">Subject</th>
                            <%-- <th>Concepts</th>--%>
                            <th style="width: 85px !important">Questions per Concept</th>
                            <th style="width: 85px !important">Total No. of Questions</th>
                            <th style="width: 75px !important;">Test Date</th>
                            <th style="width: 75px;">Active From</th>
                            <th style="width: 75px;">Active To</th>
                            <th style="width: 80px !important">Assigned To (Class)</th>
                            <th style="width: 230px !important"></th>
                            <th style="width: 135px !important"></th>
                            <th></th>
                            <th style="display: none">TestScheduledId</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <%-- Modal for Viewing Concepts --%>
            <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Test Concepts for <b>
                                <%--<asp:Literal ID="ltlConcept" runat="server"></asp:Literal>--%>
                                <label id="lblTestKeyC"></label>
                            </b></h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body" style="text-align: center">
                            <div class="table-responsive">
                                <table id="mytable2" class="table table-bordered" style="width: 100% !important">
                                    <thead>
                                        <tr>
                                            <th>Concepts</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
           
            <%--Modal for Viewing Assigned Students --%>
            <div class="modal fade" id="myModalAssigned" role="dialog" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" style="margin: 0px 0px 0px auto;">Assigned Students</h5>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>

                        </div>
                        <div class="modal-body" style="text-align: center">
                            <div class="table-responsive">
                                <table id="mytableAssigned" class="table table-bordered" style="width: 100% !important">
                                    <thead>
                                        <tr>
                                            <th>Student Name</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="H3">Delete ?</h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">Are you sure you want to delete this Scheduled Test?</div>
                        <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                            <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                            <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>
 
    <script type="text/javascript">
        function openModal() {
            $("#myModal").modal("show");
        }
        function openModalForDelete() {
            $("#myModal2").modal("show");
        }
        function openModalAssigendStudents() {
            $('#myModalAssigned').modal("show");
        }
    </script>
    <%-- <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            //$('#liTest').addClass('current-menu-item');
            $('#liTest').addClass('active');
        });
    </script>--%>
    <script>
        var ScheduleId;
        var table;
        var today = new Date();
        var hours = today.getHours()
        var minutes = today.getMinutes()
        if (minutes < 10) {
            minutes = "0" + minutes
        }
        var AMPM = ""
        if (hours > 11) {
            AMPM = "PM"
        } else {
            AMPM = "AM"
        }
        //if (hours > 12)
        //{
        //    hours = hours-12;
        //}
        var Currenttime = hours + ":" + minutes;

        //var dd = today.getDate();
        //var mm = today.getMonth() + 1; //January is 0!

        //var yyyy = today.getFullYear();
        //if (dd < 10) {
        //    dd = '0' + dd;
        //}
        //if (mm < 10) {
        //    mm = '0' + mm;
        //}
        //var today = mm + '/' + dd + '/' + yyyy;

        $(document).ready(function () {


            $(document).ajaxStart(function () {

                //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                //  window.clearTimeout($("#loading").hide().data('timeout'));
            });
            loadtable();
        });

        function loadtable() {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getScheduledTests",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table1 = $('#myTable').DataTable({
                        data: json,
                        columns: [
                            { className: "hide", data: 'TestId' },
                            { data: 'TestKey', orderable: false },
                            { data: 'TestType', orderable: false },
                            { data: 'ClassName' },
                            { data: 'SubjectName' },
                            { data: 'NoOfQuestions' },
                            { data: 'TotalQuestions' },
                            { data: 'TestDate' },
                            { data: 'TestActiveFrom' },
                            { data: 'TestActiveTo' },
                            { data: 'AssignedTo' },
                            //{ data: null }
                            {
                                mRender: function (data, type, row) {
                                    return '<input id="btnViewConcepts" class="btn-link lnk" onclick="View(\'' + row.TestId + '\',\'' + row.TestKey + '\');" style="width:100px"  value="View Concept"/> | <a href="QuestionPaper.aspx?TestId=' + row.TestId + '&Mode=Offline" target="_blank"  class="btn-link">View Question Paper</a>'
                                }, orderable: false
                            },
                            {
                                data: "TestScheduleId", orderable: false, render: function (data, type, row) {
                                    return '<input id="btnViewStudents" class="btn-link lnk" onclick="ViewAssignedStudents(\'' + row.TestScheduleId + '\');" style="width:135px"  value="Assigned Students"/>'
                                }
                            },
                            {
                                data: "TakenCount", orderable: false, render(data, type, row) {
                                    if (row.TakenCount == 0) {
                                        var value = 'False';
                                        var testdate = row.TestDate;
                                        var testdateArr = testdate.split("-");

                                        //Test Active From Time
                                        var testtimeAMPM = row.TestActiveFrom.substr(row.TestActiveFrom.length - 2);
                                        var Mins = row.TestActiveFrom.substr(row.TestActiveFrom.length - 4);
                                        var testtimeMins = Mins.substr(0, 2);
                                        var testtimeHour = row.TestActiveFrom.substr(0, row.TestActiveFrom.length - 5);
                                        if (testtimeAMPM == 'PM') {
                                            testtimeHour = parseInt(testtimeHour) + 12;
                                        }
                                        var testtime = testtimeHour + ":" + testtimeMins;


                                        //Test Active To Time
                                        var testEndAMPM = row.TestActiveTo.substr(row.TestActiveTo.length - 2);
                                        var EndMins = row.TestActiveTo.substr(row.TestActiveTo.length - 4);
                                        var testEndMins = EndMins.substr(0, 2);
                                        var testEndHour = row.TestActiveTo.substr(0, row.TestActiveTo.length - 5);
                                        if (testEndAMPM == 'PM') {
                                            testEndHour = parseInt(testEndHour) + 12;
                                        }
                                        var testEnd = testEndHour + ":" + testEndMins;


                                        testdate = new Date(testdateArr[2], testdateArr[0] - 1, testdateArr[1]);
                                        if ((testdate.setHours(0, 0, 0, 0)) > today.setHours(0, 0, 0, 0) || (testdate.setHours(0, 0, 0, 0) == today.setHours(0, 0, 0, 0)) || (testdate.setHours(0, 0, 0, 0) < today.setHours(0,0,0,0))) {
                                            //alert("TestDate: " + testdate + ",  Today: " + today + ", TestTime:" + testtime + ", CurrentTime:" + Currenttime);
                                             //if (((testtime) > (Currenttime)) && ((Currenttime) > (testEnd))) {
                                            if (((Currenttime) < (testtime)) || ((Currenttime) > (testEnd))){
                                               // alert("TestStartTime:" + testtime + ", TestEnd Time:" + testEnd);
                                                value = 'True';
                                            } else { value = 'False' }
                                        }
                                        else {
                                            value = 'False';
                                        }

                                        if (value == 'True') {
                                            //return '<input id="" class="btn-link lnk" style="text-align:center" value="Delete" onclick="DeleteScheduledTest(\'' + row.TestScheduleId + '\');"/>'
                                            return '<a class="btn" title="Delete" onclick="DeleteScheduledTest(\'' + row.TestScheduleId + '\');"><i class="fa fa-trash-o"></i></a>'

                                        }
                                        else {
                                            return '';
                                        }
                                    }
                                    else {
                                        return ' '
                                    }
                                }
                            },
                            //{
                            //    data: "TestDate", orderable: false, render: function (data, type, row) {
                            //        var value = 'False';
                            //        var testdate = row.TestDate;
                            //        var testdateArr = testdate.split("-");

                            //        var testtimeAMPM = row.TestActiveFrom.substr(row.TestActiveFrom.length - 2);
                            //        var Mins = row.TestActiveFrom.substr(row.TestActiveFrom.length - 4);
                            //        var testtimeMins = Mins.substr(0, 2);
                            //        var testtimeHour = row.TestActiveFrom.substr(0, row.TestActiveFrom.length - 5);
                            //        if (testtimeAMPM == 'PM') {
                            //            testtimeHour = parseInt(testtimeHour) + 12;
                            //        }
                            //        var testtime = testtimeHour + ":" + testtimeMins;
                            //        testdate = new Date(testdateArr[2], testdateArr[0] - 1, testdateArr[1]);
                            //        if ((testdate.setHours(0, 0, 0, 0)) > today.setHours(0, 0, 0, 0) || (testdate.setHours(0, 0, 0, 0) == today.setHours(0, 0, 0, 0))) {
                            //            // alert("TestDate: " + testdate + ",  Today: " + today + ", TestTime:" + testtime + ", CurrentTime:" + Currenttime);
                            //            if ((testtime) > (Currenttime)) {
                            //                value = 'True';
                            //            }
                            //        }
                            //        else {
                            //            value = 'False';
                            //        }
                            //        if (value == 'True') {
                            //            return '<input id="" class="btn-link lnk" style="text-align:center" value="Delete" onclick="DeleteScheduledTest(\'' + row.TestScheduleId + '\');"/>'
                            //        }
                            //        else {
                            //            return ' '
                            //        }
                            //    }
                            //},

                            { className: "hide", data: 'TestScheduleId' }
                        ]
                    });
                }
            });
        }

        function ViewAssignedStudents(testScheduleId) {
            ScheduleId = testScheduleId;
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getAssignedStudents",
                data: '{testScheduleId: "' + testScheduleId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    $('#mytableAssigned').DataTable().destroy();
                    $('#mytableAssigned tbody').empty();
                    var json = JSON.parse(response.d);
                    //console.log(json);
                    var table2 = $('#mytableAssigned').DataTable({
                        data: json,
                        columns: [
                            { data: 'StudentName' },
                            {
                                data: 'TestAssignedId', orderable: false, render(data, type, row) {
                                    if (row.Status == 'Taken') {
                                        return '<input class="btn-link lnk btnDisabled" style="text-align:center; " value="Unassign" disabled/>'
                                    }
                                    else {
                                        return '<input id="" class="btn-link lnk" style="text-align:center" value="Unassign" onclick="DeleteScheduledStudent(\'' + row.TestAssignedId + '\');"/>'
                                        }
                                }
                            }
                        ]
                    });
                    $('#mytableAssigned_length').parent().parent().remove();
                    $('#mytableAssigned_info').parent().parent().remove();
                    openModalAssigendStudents();
                }
            });
            return false;
        }

        function DeleteScheduledStudent(TestAssignedId) {
            var r = confirm("Are you sure you want to Unassign this student ?");
            if (r == true) {
                var objUnAssign = {};
                objUnAssign.TestAssignedId = TestAssignedId;
                $.ajax({
                    type: "POST",
                    url: "ScheduledTests.aspx/DeleteAssignedStudent",
                    data: JSON.stringify(objUnAssign),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#mytableAssigned').DataTable().destroy();
                        $('#mytableAssigned tbody').empty();
                        // var pagenum = parseInt($('#hdnpage').val()) - 1;
                        ViewAssignedStudents(ScheduleId);
                        if (r.d == 'Student Un-Assigned Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Student Un-Assigned Successfully');
                            runEffect1();
                        }
                    }
                });
                return false;
            }
        }



        function View(testid, testkey) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getConceptsForTests",
                data: '{testid: "' + testid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    $('#mytable2').DataTable().destroy();
                    $('#mytable2 tbody').empty();
                    var json = JSON.parse(response.d);
                    //console.log(json);
                    var table2 = $('#mytable2').DataTable({
                        data: json,
                        columns: [
                            { data: 'ConceptName' }
                        ]
                    });
                    $('#mytable2_length').parent().parent().remove();
                    $('#mytable2_info').parent().parent().remove();
                    $('#lblTestKeyC').html(testkey);
                    openModal();
                }
            });
            return false;
        }

        function DeleteScheduledTest(TestScheduledId) {
            //var info = table.page.info();
            //$('#hdnpage').val(info.page + 1);
            $('#hdnTestScheduledId').val(TestScheduledId);
            // alert($('#hdnTestScheduledId').val());
            openModalForDelete();
        }

        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //   alert('fd');
                var objDelete = {};
                objDelete.testscheduledid = $.trim($("[id*=hdnTestScheduledId]").val());
                $.ajax({
                    type: "POST",
                    url: "ScheduledTests.aspx/Delete",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        // var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable();
                        if (r.d == 'Scheduled Test Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Scheduled Test Deleted Successfully');
                            runEffect1();
                        }
                    }
                });
                $('#myModal2').modal('hide');
                return false;
            });
        });


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
</asp:Content>
