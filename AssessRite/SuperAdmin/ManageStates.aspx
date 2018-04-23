<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="ManageStates.aspx.cs" Inherits="AssessRite.SuperAdmin.ManageStates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Update/Delete State</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update State</div>
                <div class="col-lg-7" style="text-align: center">View / Delete State</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Subject Saved Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewState" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCountryName" runat="server" Text="Country"></asp:Label>
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblState" runat="server" Text="State"></asp:Label>
                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Country Name"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnStateId" />
                    <a href="#" id="btnSaveState" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblState" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">CountryId</th>
                                    <th style="display: none">StateId</th>
                                    <th>Country</th>
                                    <th>State</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteState" style="display: none;">Delete</button>
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
                                <div class="modal-body">Deleting this State might impact all its dependencies. Are you sure you want to delete this State?</div>
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
        </div>
        <div class="card-footer small text-muted">
        </div>
    </div>
    <input type="hidden" id="hdnpage" />

    <script>
        $(document).ready(function () {
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liState').addClass('current-menu-item');
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
                url: "../WebService/SuperAdminWebService.asmx/GetStates",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblState').DataTable({
                        data: json,

                        select: true,
                        columns: [
                            { className: "hide", data: 'CountryId' },
                            { className: "hide", data: 'StateId' },
                            { data: 'CountryName' },
                            { data: 'StateName' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#tblState tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //     $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveState").html('Update');
            $("#btnDeleteState").css("display", "block");
            var CountryId = $(this).find('td:nth-child(1)').text();
            $('#hdnStateId').val($(this).find('td:nth-child(2)').text());
            $('#<%=txtState.ClientID%>').val($(this).find('td:nth-child(4)').text());
            $("#<%=ddlCountry.ClientID%>").val(CountryId);
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });

        $(function () {
            $("[id*=btnSaveState]").click(function () {
                //  alert('fd');
                var english = /^[A-Za-z0-9 ]*$/;
                var trimmedValue = jQuery.trim($('#<%=txtState.ClientID%>').val());
                if ($("#<%=ddlCountry.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtState.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Subject Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.stateid = "0";
                if ($('#hdnStateId').val() != '') {
                    obj.subjectid = $.trim($("[id*=hdnStateId]").val());
                }
                obj.state = $.trim($("[id*=<%=txtState.ClientID%>]").val());
                obj.countryid = $.trim($("[id*=<%=ddlCountry.ClientID%>]").val());
                obj.buttontext = $("#btnSaveState").html();
                $.ajax({
                    type: "POST",
                    url: "ManageStates.aspx/SaveState",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#tblState').DataTable().destroy();
                        $('#tblState tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'State Already Found') {
                            $("#<%=lblError.ClientID%>").html('State Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'State Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('State Updated Successfully');
                        }
                        if (r.d == 'State Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('State Saved Successfully');
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
                objDelete.subjectid = $.trim($("[id*=hdnStateId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageStates.aspx/DeleteState",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#tblState').DataTable().destroy();
                        $('#tblState tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'State Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('State Deleted Successfully');
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
            $("[id*=btnNewState]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#tblState tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveState").html('Save');
            $("#btnDeleteState").css("display", "none");
            $("#<%=ddlCountry.ClientID%>").val('-1');
            $('#<%=txtState.ClientID%>').val('');
            $("[id*=hdnStateId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
        }
    </script>
</asp:Content>
