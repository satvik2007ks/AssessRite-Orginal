<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/DE/de.Master" AutoEventWireup="true" CodeBehind="Subject.aspx.cs" Inherits="AssessRite.DE.Subject" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }

        label {
            font-weight: normal !important;
        }

        .hideGridColumn {
            display: none;
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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete Subject</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Subject</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Subject</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Subject Saved Successfully"></asp:Label>
            </div>
            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSubjectSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary hide" Text="New" OnClick="btnNew_Click" />
                            <button id="btnNewSubject" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblClassName" runat="server" Text="Class"></asp:Label>
                        <asp:DropDownList ID="ddlClassName" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:CheckBox ID="chkLanguage" runat="server" Text="Check this if language is other than English" CssClass="checkbox" />
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Subject"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnSubId" />
                    <a href="#" id="btnSaveSubject" class="btn btn-primary">Save</a>
                    <asp:Button ID="btnSubjectSave" runat="server" Text="Save" CssClass="btn btn-primary hide" OnClick="btnSubjectSave_Click" />
                </div>
                <div class="col-lg-7">
                    <%-- <div class="table-responsive hide">
                        <asp:GridView ID="gridSubject" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridSubject_RowDataBound" OnSelectedIndexChanged="gridSubject_SelectedIndexChanged" DataKeyNames="SubjectId">
                            <Columns>
                                <asp:BoundField DataField="ClassName" HeaderText="Class" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="SubjectName" HeaderText="Subject" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                                <asp:BoundField DataField="SubjectId" HeaderText="SubjectId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="ClassId" HeaderText="ClassId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="IsOtherLanguage" HeaderText="IsOtherLanguage" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                        </asp:GridView>

                    </div>--%>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">SubjectId</th>
                                    <th style="display: none">ClassId</th>
                                    <th>Class</th>
                                    <th>Subject</th>
                                    <th style="display: none">IsOtherLanguage</th>
                                </tr>
                            </thead>
                        </table>
                    </div>


                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" OnClick="btnDelete_Click" Style="display: none;" />
                            <%--<button id="btnDeleteSubject" class="btn btn-primary" style="display: none">Delete</button>--%>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteSubject" style="display: none;">Delete</button>

                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="H3">Delete ?</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                                </div>
                                <div class="modal-body">Deleting this Subject might impact all its dependencies. Are you sure you want to delete this Subject?</div>
                                <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                    <%-- <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary hide" OnClick="btnYes_Click" />--%>
                                    <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                </div>
            </div>
            <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
        <div class="card-footer small text-muted">
        </div>
    </div>
    <input type="hidden" id="hdnpage" />

    <div id="loading" style="display: none">
        <div id="loader">
            <img src="../../Images/loading.gif" />
        </div>
    </div>



    <%-- <script type="text/javascript">
        function openModal() {
            //  jQuery.noConflict();
            $("#myModal").modal("show");
        }
    </script>--%>
    <%--  <script type="text/javascript">
        // It is important to place this JavaScript code after ScriptManager1
        var xPos, yPos;
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        function BeginRequestHandler(sender, args) {
            if ($get('<%=Panel1.ClientID%>') != null) {
                // Get X and Y positions of scrollbar before the partial postback
                xPos = $get('<%=Panel1.ClientID%>').scrollLeft;
                yPos = $get('<%=Panel1.ClientID%>').scrollTop;
            }
        }

        function EndRequestHandler(sender, args) {
            if ($get('<%=Panel1.ClientID%>') != null) {
                // Set X and Y positions back to the scrollbar
                // after partial postback
                $get('<%=Panel1.ClientID%>').scrollLeft = xPos;
                $get('<%=Panel1.ClientID%>').scrollTop = yPos;
            }
        }

        prm.add_beginRequest(BeginRequestHandler);
        prm.add_endRequest(EndRequestHandler);
    </script>--%>
    <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            $('#liSubject').addClass('current-menu-item');
            //$('#liSubject1').addClass('current-menu-item');
            $('#subjectname').addClass('active');
        });
    </script>
    <script>
        function pageLoad(sender, args) {
            //$(".dataTable tbody").before("<thead><tr></tr></thead>");
            //$(".dataTable thead tr").append($(".dataTable th"));
            //$(".dataTable tbody tr:first").remove();
            //$(".dataTable").DataTable();
        }
        var table;
        $(document).ready(function () {
            loadtable(0);
            $(document).ajaxStart(function () {
               
              //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
               // window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });

        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetSubjectData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        columns: [
        { className: "hide", data: 'SubjectId' },
        { className: "hide", data: 'ClassId' },
        { data: 'ClassName' },
        { data: 'SubjectName' },
        { className: "hide", data: 'IsOtherLanguage' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
           
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
             //   $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveSubject").html('Update');
            // $("#id").css("display", "none");
            $("#btnDeleteSubject").css("display", "block");
            var classId = $(this).find('td:nth-child(2)').text();
            $('#hdnSubId').val($(this).find('td:first').text());
            $('#<%=txtSubject.ClientID%>').val($(this).find('td:nth-child(4)').text());
            $("#<%=ddlClassName.ClientID%>").val(classId);
            var ischecked = $(this).find('td:nth-child(5)').text();
            if (ischecked == "true") {
                $('#<%=chkLanguage.ClientID%>').attr('checked', true); // Checks it
            }
            else {
                $('#<%=chkLanguage.ClientID%>').attr('checked', false); // Checks it
            }
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });
    </script>

    <script type="text/javascript">
        $(function () {
            $("[id*=btnSaveSubject]").click(function () {
                //  alert('fd');
                var english = /^[A-Za-z0-9 ]*$/;
                var trimmedValue = jQuery.trim($('#<%=txtSubject.ClientID%>').val());
                if ($("#<%=ddlClassName.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtSubject.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Subject Cannot Be Blank');
                         $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                     }
                     else if (!english.test($("#<%=txtSubject.ClientID%>").val())) {
                         if ($('#<%=chkLanguage.ClientID%>').is(":checked")) {
                         }
                         else {
                              $("#<%=lblError.ClientID%>").html('If Subject Is Other Than English, Please Select The checkbox');
                         $("#<%=divError.ClientID%>").css("display", "block");
                             return false;
                         }
                     }

                     else {
                         $("#<%=divError.ClientID%>").css("display", "none");
                     }
                var obj = {};
                obj.subjectid = "0";
                if ($('#hdnSubId').val() != '') {
                    obj.subjectid = $.trim($("[id*=hdnSubId]").val());
                }
                obj.subject = $.trim($("[id*=<%=txtSubject.ClientID%>]").val());
                obj.classid = $.trim($("[id*=<%=ddlClassName.ClientID%>]").val());
                obj.buttontext = $("#btnSaveSubject").html();
                obj.isotherlanguage = "0";
                if ($('#<%=chkLanguage.ClientID%>').is(":checked")) {
                    // it is checked
                    obj.isotherlanguage = "1";
                }
                $.ajax({
                    type: "POST",
                    url: "Subject.aspx/SendParameters",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'Subject Already Found') {
                            $("#<%=lblError.ClientID%>").html('Subject Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Subject Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Updated Successfully');
                        }
                        if (r.d == 'Subject Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Saved Successfully');
                        }
                        runEffect1();
                        clear();
                    }
                });
                return false;
            });
        });


        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.subjectid = $.trim($("[id*=hdnSubId]").val());
                $.ajax({
                    type: "POST",
                    url: "Subject.aspx/DeleteSubject",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Subject Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Subject Deleted Successfully');
                            runEffect1();
                        }
                    }
                });
                $('#myModal1').modal('hide');
                clear();
                return false;
            });
        });


        $(function () {
            $("[id*=btnNewSubject]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveSubject").html('Save');
            $("#btnDeleteSubject").css("display", "none");
            $("#<%=ddlClassName.ClientID%>").val('-1');
           $('#<%=txtSubject.ClientID%>').val('');
           $('#<%=chkLanguage.ClientID%>').attr('checked', false);
           $("[id*=hdnSubId]").val('');
           $("#<%=divError.ClientID%>").css("display", "none");
       }
    </script>
</asp:Content>
