<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Class.aspx.cs" Inherits="AssessRite.Class" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Delete Class</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-6" style="text-align: center">Add Class</div>
                <div class="col-lg-6" style="text-align: center">View / Delete Class</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Class Saved Successfully"></asp:Label>
            </div>
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnClassSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <asp:HiddenField ID="hdnvalue" runat="server" />
            <div class="row">
                <div class="col-lg-6">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary hide" Text="New" OnClick="btnNew_Click" />
                            <button id="btnNewClass" class="btn btn-primary hide">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <%--<div class="form-group">
                        <label>Text Input</label>
                        <input class="form-control">
                        <p class="help-block">Example block-level help text here.</p>
                    </div>--%>
                    <div class="form-group">
                        <asp:Label ID="lblClass" runat="server" Text="Class"></asp:Label>
                        <%--<asp:TextBox ID="txtClass" runat="server" CssClass="form-control onlynumber" ValidationGroup="g" MaxLength="2" placeholder="Enter Class"></asp:TextBox>--%>
                        <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="help-block" runat="server" Style="color: red;" ErrorMessage="Accepts only numbers" ControlToValidate="txtClass" ValidationExpression="^[0-9]*$" ValidationGroup="g"></asp:RegularExpressionValidator>--%>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <%--<div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-8" style="text-align: left;">
                                </div>
                                <div class="col-md-1"></div>
                            </div>--%>
                    <input type="hidden" id="hdnClassId" />
                    <a href="#" id="btnSaveClass" class="btn btn-primary">Add</a>
                    <asp:Button ID="btnClassSave" runat="server" Text="Save" CssClass="btn btn-primary hide" OnClick="btnClassSave_Click" ValidationGroup="g" />
                </div>
                <div class="col-lg-6" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive hide">
                        <asp:GridView ID="gridClass" CssClass="table table-bordered" runat="server" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridClass_RowDataBound" OnSelectedIndexChanged="gridClass_SelectedIndexChanged" DataKeyNames="ClassId">
                            <Columns>
                                <asp:BoundField DataField="ClassName" HeaderText="Class" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="ClassId" HeaderText="ClassId" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                            </Columns>
                        </asp:GridView>

                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Class</th>
                                    <th style="display: none">ClassId</th>
                                    <th style="display: none">MasterClassId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteClass" style="display: none; margin: 0 auto">
                                Delete
                            </button>
                        </div>
                        <div class="col-md-4"></div>
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
                            <div class="modal-body">Deleting this Class might impact all its dependencies. Are you sure you want to delete this Class?</div>
                            <div class="modal-footer" style="text-align: center; margin-top: 2px; border-top: none !important">
                                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary hide" OnClick="btnYes_Click" />
                                <button id="btnDeleteYes" class="btn btn-primary">Yes</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
            </div>
            <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
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
            //  jQuery.noConflict();
            $("#myModal").modal("show");
        }
    </script>
    <script>
        $(document).ready(function () {
          //  $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            //$('#liClass').addClass('current-menu-item');
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liClass').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');

            //$('#liClass1').addClass('current-menu-item');
           // $('#classname').addClass('active');
        });
    </script>
    <script>
        function pageLoad(sender, args) {
            $('.onlynumber').keydown(function (e) {
                // Allow: backspace, delete, tab, escape, enter and .
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    // Allow: Ctrl+A
                    (e.keyCode == 65 && e.ctrlKey === true) ||
                    // Allow: home, end, left, right
                    (e.keyCode >= 35 && e.keyCode <= 39) ||
                    (e.keyCode == 189 || e.keyCode == 107)) {
                    // let it happen, don't do anything
                    return;
                }
                // Ensure that it is a number and stop the keypress
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });


            //$(".dataTable tbody").before("<thead><tr></tr></thead>");
            //$(".dataTable thead tr").append($(".dataTable th"));
            //$(".dataTable tbody tr:first").remove();
            //$(".dataTable").DataTable();
        }
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadtable(0);
            $(document).ajaxStart(function () {
                // $("#loading").show();
                $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                // $("#loading").hide();
                window.clearTimeout($("#loading").hide().data('timeout'));
            });
        });



        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetClassData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //  console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        order: [[2, "asc"]],
                        columns: [
        { data: 'ClassName' },
        { className: "hide", data: 'ClassId' },
        { className: "hide", data: 'MasterClassId' }
                        ]

                    });
                    table.page(defaultpage).draw(false);
                    $('#myTable_length').parent().parent().remove();
                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
              //  $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }

            // $("#btnSaveClass").html('Update');
            $("#btnDeleteClass").css("display", "block");

            $('#hdnClassId').val($(this).find('td:nth-child(2)').text());
            //  $('#<%=ddlClass.ClientID%>').val($(this).find('td:nth-child(3)').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });

        $(function () {
            $("[id*=btnSaveClass]").click(function () {
                if ($("#<%=ddlClass.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                 <%-- else if ($("#<%=txtClass.ClientID%>").val() > 12) {
                      $("#<%=lblError.ClientID%>").html('Class Cannot Be Greater Than 12');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
                else if ($("#<%=txtClass.ClientID%>").val() == 0) {
                    $("#<%=lblError.ClientID%>").html('Class Cannot Be 0');
                         $("#<%=divError.ClientID%>").css("display", "block");
                         return;
                     }
                     else if ($("#<%=txtClass.ClientID%>").val().indexOf("-") > -1) {
                         $("#<%=lblError.ClientID%>").html('Invalid Characters in Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }--%>
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.classid = $.trim($("[id*=<%=ddlClass.ClientID%>]").val());
                if ($("#btnSaveClass").html() == 'Update') {
                    if ($('#hdnClassId').val() != '') {
                        obj.classid = $.trim($("[id*=hdnClassId]").val());
                    }
                }
                obj.classname = $.trim($("[id*=<%=ddlClass.ClientID%>] option:selected").text());
                obj.buttontext = $("#btnSaveClass").html();
                $.ajax({
                    type: "POST",
                    url: "Class.aspx/SendParameters",
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
                        if (r.d == 'Class Already Exists') {
                            $("#<%=lblError.ClientID%>").html('Class Already Exists');
                              $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                          }
                          if (r.d == 'Class Updated Successfully') {
                              $("#<%=lblMsg.ClientID%>").html('Class Updated Successfully');
                        }
                          if (r.d == 'Class Saved Successfully') {
                              $("#<%=lblMsg.ClientID%>").html('Class Saved Successfully');
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
                //   alert('fd');
                var objDelete = {};
                objDelete.classid = $.trim($("[id*=hdnClassId]").val());
                $.ajax({
                    type: "POST",
                    url: "Class.aspx/DeleteClass",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Class Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Class Deleted Successfully');
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
            $("[id*=btnNewClass]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveClass").html('Add');
            $('#<%=ddlClass.ClientID%>').val('-1');
            $("[id*=hdnClassId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteClass").css("display", "none");
        }
    </script>
    <%--<script type="text/javascript">
        // It is important to place this JavaScript code after ScriptManager1
        var pageIndex,xPos,yPos;
        var prm = Sys.WebForms.PageRequestManager.getInstance();
       
      <%--  prm.add_beginRequest(function (source, args) {
            alert("begin");
            var pageIndex = $("ul.pagination li.active").find('a:first').text();
            $('#<%=hdnvalue.ClientID%>').val(pageIndex);
        });
        prm.add_endRequest(function (source, args) {
            alert("end");
             alert($('<%=hdnvalue.ClientID%>').val());
        });--%>

    <%--  function BeginRequestHandler(sender, args) {
           if ($get('<%=Panel1.ClientID%>') != null) {
                // Get X and Y positions of scrollbar before the partial postback
                xPos = $get('<%=Panel1.ClientID%>').scrollLeft;
                yPos = $get('<%=Panel1.ClientID%>').scrollTop;
            }
        }--%>

    <%--        function EndRequestHandler(sender, args) {

           // $("ul.pagination").find(pageIndex).click();
            // $(pageIndex).click();
           
           // var current = $("ul.pagination li.active");
         //   $(current).removeClass('active');
          //  $(pageIndex).addClass('active');
           // alert("workingend");
             if ($get('<%=Panel1.ClientID%>') != null) {
                // Set X and Y positions back to the scrollbar
                // after partial postback
                $get('<%=Panel1.ClientID%>').scrollLeft = xPos;
                $get('<%=Panel1.ClientID%>').scrollTop = yPos;
            }
        }

     //   prm.add_beginRequest(BeginRequestHandler);
     //   prm.add_endRequest(EndRequestHandler);
    </script>--%>
</asp:Content>
