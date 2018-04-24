<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="ManageInstitutionTypes.aspx.cs" Inherits="AssessRite.SuperAdmin.ManageInstitutionTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Delete Institution Type</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-6" style="text-align: center">Add Institution Type</div>
                <div class="col-lg-6" style="text-align: center">View / Delete Institution Type</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Institution Type Saved Successfully"></asp:Label>
            </div>
            <asp:HiddenField ID="hdnvalue" runat="server" />
            <div class="row">
                <div class="col-lg-6">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewInstitutionType" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblInstitutionType" runat="server" Text="Institution Type"></asp:Label>
                        <asp:TextBox ID="txtInstitutionType" runat="server" CssClass="form-control" ValidationGroup="g" MaxLength="30" placeholder="Enter Institution Type"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Institution Type"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnInstitutionTypeId" />
                    <a href="#" id="btnSaveInstitutionType" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-6" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblInstitutionType" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>InstitutionType</th>
                                    <th style="display: none">InstitutionTypeId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteInstitutionType" style="display: none; margin: 0 auto">
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
                            <div class="modal-body">Deleting this Institution Type might impact all its dependencies. Are you sure you want to delete this Institution Type?</div>
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
        </div>
        <div class="card-footer small text-muted"></div>
    </div>
    <input type="hidden" id="hdnpage" />
    <script>
        $(document).ready(function () {
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liInstitution').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');
        });
    </script>
    <script>
        var table;
        $(document).ready(function () {
            loadtable(0);
        });
        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/GetInstitutionTypes",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblInstitutionType').DataTable({
                        data: json,
                        select: true,
                        columns: [
                            { data: 'InstitutionType' },
                            { className: "hide", data: 'InstitutionTypeId' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#tblInstitutionType tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //     $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            if ($(this).find("td:eq(0)").text() == 'No data available in table') {
                table.$('tr.selected').removeClass('selected');
            }
            else {
                $("#btnSaveInstitutionType").html('Update');
                $("#btnDeleteInstitutionType").css("display", "block");
                $('#hdnInstitutionTypeId').val($(this).find('td:nth-child(2)').text());
                $('#<%=txtInstitutionType.ClientID%>').val($(this).find('td:nth-child(1)').text());
                var info = table.page.info();
                $('#hdnpage').val(info.page + 1);
            }
        });


        $(function () {
            $("[id*=btnSaveInstitutionType]").click(function () {
                var trimmedValue = jQuery.trim($('#<%=txtInstitutionType.ClientID%>').val());
                if ($("#<%=txtInstitutionType.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Institution Type');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Institution Type Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.institutiontypeid = "0";
                if ($('#hdnInstitutionTypeId').val() != '') {
                    obj.institutiontypeid = $.trim($("[id*=hdnInstitutionTypeId]").val());
                }
                obj.institutiontype = $.trim($("[id*=<%=txtInstitutionType.ClientID%>]").val());
                obj.buttontext = $("#btnSaveInstitutionType").html();
                $.ajax({
                    type: "POST",
                    url: "ManageInstitutionTypes.aspx/SaveInstitutionType",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#tblInstitutionType').DataTable().destroy();
                        $('#tblInstitutionType tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'Institution Type Already Found') {
                            $("#<%=lblError.ClientID%>").html('Institution Type Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Institution Type Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Institution Type Updated Successfully');
                        }
                        if (r.d == 'Institution Type Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Institution Type Saved Successfully');
                        }
                        clear();
                        runEffect1();
                    }
                });
                return false;
            });
        });

        $(function () {
            $("[id*=btnDeleteYes]").click(function () {
                //  alert('fd');
                var objDelete = {};
                objDelete.institutiontypeid = $.trim($("[id*=hdnInstitutionTypeId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageInstitutionTypes.aspx/DeleteInstitutionType",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        $('#tblInstitutionType').DataTable().destroy();
                        $('#tblInstitutionType tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Institution Type Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Institution Type Deleted Successfully');
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
            $("[id*=btnNewInstitutionType]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#tblInstitutionType tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveInstitutionType").html('Save');
            $("#btnDeleteInstitutionType").css("display", "none");
            $('#<%=txtInstitutionType.ClientID%>').val('');
            $("[id*=hdnInstitutionTypeId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
        }
    </script>
    <script type="text/javascript">
        function runEffect1() {
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
