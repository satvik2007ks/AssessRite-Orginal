<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/SME/sme.Master" AutoEventWireup="true" CodeBehind="ReviewQuestion.aspx.cs" Inherits="AssessRite.SME.ReviewQuestion" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
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

        .btn-link {
            border-style: none;
            cursor: pointer;
            width: 70px !important;
        }
         .dataTables_wrapper{
            margin-bottom:20px !important;
        }
    </style>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Review Questions</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-9" style="text-align: center">View Questions</div>
                <div class="col-lg-3" style="text-align: center">View Options</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Question Deleted Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-9">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable1" style="width: 100% !important">
                            <thead>
                                <tr>
                                    <th style="display: none">QuestionId</th>
                                    <th>Class</th>
                                    <th>Subject</th>
                                    <th>Concept</th>
                                    <th>Objective</th>
                                    <th>Question</th>
                                    <th>Answer Type</th>
                                    <th>Entered On</th>
                                    <th>Entered By</th>
                                    <th>Status</th>
                                    <th>Approve</th>
                                    <th>Reject</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" id="divEditDelete" style="display: none">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px; margin-top: 10px; margin: 0 auto;">
                            <input type="hidden" id="hdnQuestionId" />
                            <button type="button" class="btn btn-primary" id="btnEdit hide" style="padding-right: 10px;">
                                Edit
                            </button>
                            <button type="button" class="btn btn-primary hide" data-toggle="modal" data-target="#myModal1" id="btnDelete" style="padding-left: 10px;">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <div class="col-lg-3" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable2" style="width: 100% !important; display: none">
                            <thead>
                                <tr>
                                    <th>Answer</th>
                                    <th>Is Right Answer</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H3">Delete ?</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">Are you sure you want to delete this question?</div>
                            <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>

                <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="H4">Please Enter Comment</h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <asp:Label ID="lblComment" runat="server" Text="Comment"></asp:Label>
                                    <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" CssClass="form-control" MaxLength="495"></asp:TextBox>
                                    <div class="help-block" id="divError" runat="server" style="display: none">
                                        <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Comment"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                <button id="btnCommentSave" class="btn btn-primary">Save</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
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
        function openModalComment() {
            //  jQuery.noConflict();
            $("#myModal2").modal("show");
        }
    </script>
    <script>
        var table, table1;
        $(document).ready(function () {
            loadtable(0);
            $(document).ajaxStart(function () {

                //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable1_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                //window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });

        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getQuestionsUnderReviewForSME",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable1').DataTable({
                        data: json,
                        select: true,
                        columns: [
                            { className: "hide", data: 'QuestionId' },
                            { data: 'ClassName' },
                            { data: 'SubjectName' },
                            { data: 'ConceptName' },
                            { data: 'ObjectiveName' },
                            { data: 'Question' },
                            { data: 'AnswerType' },
                            { data: 'AddedDateTime' },
                            { data: 'DEName' },
                            { data: 'Status' },
                            //{
                            //    mRender: function (data, type, row) {
                            //        return '<input id="btnApprove" class="btn-link" value="Approve" onclick="Approve(' + row.QuestionId + ')"/> | <input id="btnReject" class="btn-link" value="Reject" onclick="Reject(' + row.QuestionId + ')"/>'
                            //    }
                            //}
                            {
                                data: "QuestionId", render: function (data, type, row) {
                                    return '<input id="btnApprove" class="btn-link" value="Approve" onclick="Approve(' + row.QuestionId + ')"/>'
                                }
                            },
                            {
                                data: "QuestionId", render: function (data, type, row) {
                                    return '<input id="btnReject" class="btn-link" value="Reject" onclick="Reject(' + row.QuestionId + ')"/>'
                                }
                            }

                        ]
                    });
                    table.page(defaultpage).draw(false);
                    //  $('#myTable1_length').parent().parent().remove();
                }
            });
        }

        function Approve(QuestionId) {
            var objApprove = {};
            objApprove.questionid = $.trim($("[id*=hdnQuestionId]").val());
            $.ajax({
                type: "POST",
                url: "ReviewQuestion.aspx/ApproveQuestion",
                data: JSON.stringify(objApprove),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    // alert(r.d);
                    $('#myTable1').DataTable().destroy();
                    $('#myTable1 tbody').empty();
                    $('#myTable2').DataTable().destroy();
                    $('#myTable2 tbody').empty();
                    var pagenum = parseInt($('#hdnpage').val()) - 1;
                    loadtable(pagenum);
                    if (r.d == 'Question Approved') {
                        $("#<%=lblMsg.ClientID%>").html('Question Approved');
                        runEffect1();
                        // $("#divEditDelete").css("display", "none");
                        $("#myTable2").css("display", "none");
                    }
                }
            });
            //$('#myModal1').modal('hide');
            $("#myTable2").css("display", "none");
            //  $("#divEditDelete").css("display", "none");
            return false;
        }

        function Reject(QuestionId) {
            //alert("workingReject:" + QuestionId);
            $('#hdnQuestionId').val(QuestionId);
            openModalComment();
            return false;
        }

        $(document).on('click', '#myTable1 tbody tr', function () {
            if ($(this).hasClass('selected')) {
                //    $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                //   $('#myTable1').find('.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#myTable2").css("display", "table");
            $("#divEditDelete").css("display", "block");
            $('#hdnQuestionId').val($(this).find('td:nth-child(1)').text());
            loadanswers($('#hdnQuestionId').val());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });

        function loadanswers(questionid) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getQuestionAnswerData",
                data: '{questionid: "' + questionid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // console.log(response.d)
                    $('#myTable2').DataTable().destroy();
                    $('#myTable2 tbody').empty();
                    var json = JSON.parse(response.d);
                    table1 = $('#myTable2').DataTable({
                        data: json,
                        ordering: false,
                        select: true,
                        columns: [
                            { bSortable: 'false', data: 'Answer' },
                            { data: 'IsRightAnswer' }
                        ]
                    });
                    $('#myTable2_length').parent().parent().remove();
                    $('#myTable2_info').parent().parent().remove();
                }
            });
        }

        $(function () {
            $("[id*=btnCommentSave]").click(function () {
                //  alert('fd');
                var trimmedValue = jQuery.trim($('#<%=txtComment.ClientID%>').val());
                if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Comment Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var objReject = {};
                objReject.questionid = $.trim($("[id*=hdnQuestionId]").val());
                objReject.comment = $.trim($("[id*=<%=txtComment.ClientID%>]").val());
                $.ajax({
                    type: "POST",
                    url: "ReviewQuestion.aspx/RejectQuestion",
                    data: JSON.stringify(objReject),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable1').DataTable().destroy();
                        $('#myTable1 tbody').empty();
                        $('#myTable2').DataTable().destroy();
                        $('#myTable2 tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Comment Cannot Have Special Characters') {
                            $("#<%=lblError.ClientID%>").html('Comment Cannot Have Special Characters');
                                 $("#<%=divError.ClientID%>").css("display", "block");
                                return false;
                            }
                            if (r.d == 'Comment Cannot Have Just Numbers') {
                                $("#<%=lblError.ClientID%>").html('Comment Cannot Have Just Numbers');
                             $("#<%=divError.ClientID%>").css("display", "block");
                                return false;
                            }
                            if (r.d == 'Question Sent Back to DE for Correction') {
                                $("#<%=lblMsg.ClientID%>").html('Question Sent Back to DE for Correction');
                            runEffect1();
                            $('#myModal2').modal('hide');
                        }
                    }
                });
                // $('#myModal2').modal('hide');
                $("#myTable2").css("display", "none");
                //    $("#divEditDelete").css("display", "none");
                return false;
            });
        });


        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.questionid = $.trim($("[id*=hdnQuestionId]").val());
                $.ajax({
                    type: "POST",
                    url: "ReviewQuestion.aspx/DeleteQuestion",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable1').DataTable().destroy();
                        $('#myTable1 tbody').empty();
                        $('#myTable2').DataTable().destroy();
                        $('#myTable2 tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Question Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Question Deleted Successfully');
                            runEffect1();
                        }
                    }
                });
                $('#myModal1').modal('hide');
                $("#myTable2").css("display", "none");
                //  $("#divEditDelete").css("display", "none");
                return false;
            });
        });

        $(function () {
            $("[id*=btnEdit]").click(function () {
                var qid = $('#hdnQuestionId').val();
                window.location.href = "Question.aspx?QuestionId=" + qid;
            })
        });

    </script>
</asp:Content>
