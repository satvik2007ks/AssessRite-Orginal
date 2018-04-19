<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Teacher/teacher.Master" AutoEventWireup="true" CodeBehind="ViewTests.aspx.cs" Inherits="AssessRite.ViewTests" EnableEventValidation="false" %>

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
         .dataTables_wrapper{
            margin-bottom:20px !important;
        }
    </style>
    <link href="../../css/jquery-ui.css" rel="stylesheet" />
    <link href="../../css/bootstrap-timepicker.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script src="../../Scripts/bootstrap-timepicker.min.js"></script>

    <%--<script>
        function pageLoad(sender, args) {
            //$(document).ready(function () {
            // jQuery.noConflict();
            $('.Otherdatepicker').datepicker();
            $('.Othertimepicker').timepicker();
            // var offset = new Date().getTimezoneOffset();
            <%-- var offset = new Date().toTimeString();
            $('#<%=hdnTimeZone.ClientID%>').val(offset);
        }
        // });
    </script>--%>


    <script type="text/javascript">
        function runEffect1() {
            //alert("working");
            $("#<%=myMessage1.ClientID%>").show();
            setTimeout(function () {
                var selectedEffect = 'blind';
                var options = {};
                $("#<%=myMessage1.ClientID%>").hide();
            }, 5000);
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdnTimeZone" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">View / Schedule Test</h5>
    </div>
    <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <asp:Label ID="lblMsg" runat="server" Text="Test Scheduled & Assigned Successfully"></asp:Label>
    </div>
    <asp:UpdatePanel ID="updPnl" runat="server">
        <ContentTemplate>
            <div class="row">
                <%--<div class="col-lg-1"></div>--%>
                <div class="col-lg-12">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="table-responsive">
                                <%--AllowPaging="true"--%>
                                <%--OnPageIndexChanging="grdTests_PageIndexChanging" PageSize="50"--%>

                                <asp:GridView ID="grdTests" runat="server" CssClass="table table-bordered dataTable" OnRowDataBound="grdTests_RowDataBound" AutoGenerateColumns="false" EmptyDataRowStyle-BorderStyle="None" EmptyDataRowStyle-BorderColor="#F1F1F1" DataKeyNames="TestId" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" HeaderStyle-BorderColor="White" Style="width: 100%; text-align: center; margin-bottom: 10px;" PagerStyle-BorderColor="White">
                                    <Columns>
                                        <asp:BoundField HeaderText="TestId" DataField="TestId" Visible="false" />
                                        <asp:BoundField HeaderText="Test Key" DataField="TestKey" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Test Type" DataField="TestType" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Class" DataField="ClassName" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Subject" DataField="SubjectName" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:BoundField HeaderText="Created Date" DataField="TestCreationDate" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" />
                                        <asp:BoundField HeaderText="Questions per Concept" DataField="NoOfQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                        <asp:BoundField HeaderText="Total No. of Questions" DataField="TotalQuestions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="120px" />
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <%-- <div>--%>
                                                <asp:Button ID="btnViewConcepts" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' CssClass="btn-link" Style="border: none; cursor: pointer;" OnClick="btnViewConcepts_Click"
                                                    Text="View Concepts" CommandArgument='<%# Eval("TestId") %>' />
                                                <%-- </div>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <%--<div>--%>
                                                <asp:HyperLink ID="lnkViewTest" runat="server" Text="View Question Paper" CssClass="btn-link" Target="_blank" NavigateUrl='<%# "QuestionPaper.aspx?TestId="+ Eval("TestId") +"&Mode=Offline" %>'></asp:HyperLink>
                                                <%-- <asp:Button ID="btnViewTest" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' CssClass="btn-link" OnClick="btnViewTest_Click"
                                                        Text="View Question Paper" CommandArgument='<%# Eval("TestId") %>' />--%>
                                                <%-- </div>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <%--<div>--%>
                                                <asp:Button ID="btnSchedule" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' Style="border: none; cursor: pointer;" CssClass="btn-link" OnClick="btnSchedule_Click"
                                                    Text="Schedule/Reschedule" CommandArgument='<%# Eval("TestId") %>' />
                                                <%-- </div>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <%--<div>--%>
                                                <asp:Button ID="btnDeleteTest" runat="server" CausesValidation="false" CommandName='<%# Eval("TestKey") %>' Style="border: none; cursor: pointer;" CssClass="btn-link" OnClick="btnDeleteTest_Click"
                                                    Text="Delete" CommandArgument='<%# Eval("TestId") %>' />
                                                <%-- </div>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <asp:Label ID="lblEmpty" runat="server" Text="No Data Found" Style="color: red; font-size: small;"></asp:Label>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <%-- Modal for Viewing Concepts --%>
                            <div class="modal fade" id="myModal" role="dialog" data-backdrop="static" data-keyboard="false">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Test Concepts for <b>
                                                <asp:Literal ID="ltlConcept" runat="server"></asp:Literal></b></h5>
                                            <button type="button" class="close" data-dismiss="modal">x</button>
                                        </div>
                                        <div class="modal-body" style="text-align: center">
                                            <asp:GridView ID="grdConcepts" runat="server" CssClass="grid" AutoGenerateColumns="false" HeaderStyle-Font-Bold="true" HeaderStyle-BackColor="Gray" HeaderStyle-ForeColor="White" Style="width: 50%; text-align: center; margin-bottom: 10px; margin: 0 auto;" EmptyDataRowStyle-BorderColor="White">
                                                <Columns>
                                                    <asp:BoundField DataField="ConceptName" HeaderText="Concepts" HeaderStyle-HorizontalAlign="Center" />
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <label style="color: red;">No Data Found</label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="card-footer small text-muted"></div>
                    </div>
                </div>
                <%--<div class="col-lg-1"></div>--%>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="H3">Delete ?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Are you sure you want to delete this Test?</div>
                <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    <asp:Button ID="btnDeleteTestYes" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnDeleteTestYes_Click" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <%-- Modal for Scheduling --%>
    <div class="modal fade" id="modalSchedule" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule & Assign the Test <b>
                        <asp:Literal ID="ltlTestKey" runat="server"></asp:Literal></b></h5>
                    <button type="button" class="close" data-dismiss="modal">x</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card mb-3">
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-lg-12" style="text-align: center">Schedule Test</div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-3"></div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label style="font-weight: normal; margin-top: 5px;">Select Date</label>
                                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control Otherdatepicker" onchange="javascript: ValidateDate();"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label style="font-weight: normal; margin-top: 5px;">Test Active From</label>
                                                <div class="input-group bootstrap-timepicker timepicker">
                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control input-small Othertimepicker"></asp:TextBox>
                                                    <span class="input-group-addon"><i class="fa fa-fw fa-clock-o"></i></span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label style="font-weight: normal; margin-top: 5px;">Test Active To</label>
                                                <div class="input-group bootstrap-timepicker timepicker">
                                                    <asp:TextBox ID="txtTo" runat="server" CssClass="form-control input-small Othertimepicker" Text="3:30 PM"></asp:TextBox>
                                                    <span class="input-group-addon"><i class="fa fa-fw fa-clock-o"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3"></div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card mb-3">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-lg-12" style="text-align: center">Assign Test</div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-lg-3"></div>
                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label style="font-weight: normal; margin-top: 5px;">Select Class</label>
                                                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                    </div>
                                                    <div class="form-group" style="margin-top: 10px; display: none;" id="divStudents" runat="server">
                                                        <label style="font-weight: normal; margin-top: 5px;">Select Students</label>
                                                        <asp:CheckBox ID="chkStudentsAll" runat="server" CssClass="checkbox" Style="text-align: left;" OnCheckedChanged="chkStudentsAll_CheckedChanged" AutoPostBack="true" Text="All"></asp:CheckBox>
                                                        <asp:Panel ID="Panel1" runat="server" Style="margin-top: -15px; max-height: 250px; overflow-y: auto">
                                                            <asp:CheckBoxList ID="chkStudents" runat="server" CssClass="checkbox" Style="text-align: left;" OnSelectedIndexChanged="chkStudents_SelectedIndexChanged" AutoPostBack="true"></asp:CheckBoxList>
                                                        </asp:Panel>
                                                    </div>
                                                    <div class="row textcenter" id="divError" runat="server" style="display: none">
                                                        <label style="color: red; font-weight: normal">No Students Found</label>
                                                    </div>
                                                    <div class="row textcenter" id="divErr" runat="server" style="display: none">
                                                        <asp:Label ID="lblError" runat="server" Style="color: red"></asp:Label>
                                                    </div>
                                                    <asp:Button ID="btnAssign" runat="server" Text="Schedule & Assign" CssClass="btn btn-primary" Style="display: none; margin: 0 auto;" OnClick="btnAssign_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlClass" />
                            <asp:AsyncPostBackTrigger ControlID="chkStudents" />
                            <asp:AsyncPostBackTrigger ControlID="btnAssign" EventName="click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalAlreadyExists" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Alert<b></h5>
                    <button type="button" class="close" data-dismiss="modal">x</button>

                </div>
                <div class="modal-body" style="text-align: center">
                    <label>You have already Scheduled this Test for this date and class. Do you still want to Schedule Again ?</label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnYes" runat="server" CssClass="btn btn-primary" Text="Yes" OnClick="btnYes_Click" />
                </div>
            </div>
        </div>
    </div>
    <script>
        function pageLoad(sender, args) {
           <%-- var offset = new Date().toTimeString();
            $('#<%=hdnTimeZone.ClientID%>').val(offset);--%>

            $(".dataTable tbody").before("<thead><tr></tr></thead>");
            $(".dataTable thead tr").append($(".dataTable th"));
            $(".dataTable tbody tr:first").remove();
            $(".dataTable").DataTable({
                columns: [
                    { orderable: true },
                    { orderable: true },
                    { orderable: true },
                    { orderable: true },
                    { orderable: true },
                    { orderable: true },
                    { orderable: true },
                    { orderable: false },
                    { orderable: false },
                    { orderable: false },
                    { orderable: false }

                ]
            });
            $('#ContentPlaceHolder1_grdTests_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
        }
        // });
    </script>
    <script type="text/javascript">
        function openModal() {
            $("#myModal").modal("show");
        }
        function openModalSchedule() {
            $("#modalSchedule").modal("show");
        }
        function openModalExists() {
            $("#modalAlreadyExists").modal("show");
        }
        function openModalForDelete() {
            $("#myModal2").modal("show");
        }
    </script>
    <script type="text/javascript">
        function ValidateDate(sender, args) {
           <%-- alert($('#<%=txtDate.ClientID%>').val());--%>
            var dateEntered = $('#<%=txtDate.ClientID%>').val();
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!

            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            var today = mm + '/' + dd + '/' + yyyy;

            // alert(dateToCompare);
            if (dateEntered >= today) {
            }
            else {
                alert("Invalid Date! Select The Date Today or Greater Than Today");
                $('#<%=txtDate.ClientID%>').val('');
            }
        }
    </script>
    <script type="text/javascript">
        var offset = new Date().toTimeString();
        $('#<%=hdnTimeZone.ClientID%>').val(offset);
        $('.Otherdatepicker').datepicker();
        $('.Othertimepicker').timepicker();
    </script>

</asp:Content>
