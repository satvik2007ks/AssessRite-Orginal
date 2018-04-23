<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="ManageCountries.aspx.cs" Inherits="AssessRite.SuperAdmin.ManageCountries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Add/View/Delete Country</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-6" style="text-align: center">Add Country</div>
                <div class="col-lg-6" style="text-align: center">View / Delete Country</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Country Saved Successfully"></asp:Label>
            </div>
            <asp:HiddenField ID="hdnvalue" runat="server" />
            <div class="row">
                <div class="col-lg-6">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewCountry" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCountry" runat="server" Text="Country"></asp:Label>
                        <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" ValidationGroup="g" MaxLength="30" placeholder="Enter Country Name"></asp:TextBox>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Country Name"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnCountryId" />
                    <a href="#" id="btnSaveCountry" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-6" style="border-left: lightgray; border-left-width: 1px; border-left-style: solid;">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="tblCountries" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Country</th>
                                    <th style="display: none">CountryId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px;">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteCountry" style="display: none; margin: 0 auto">
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
                            <div class="modal-body">Deleting this Country might impact all its dependencies. Are you sure you want to delete this Country?</div>
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
            $('#liCountry').addClass('current-menu-item');
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
                url: "../WebService/SuperAdminWebService.asmx/GetCountries",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#tblCountries').DataTable({
                        data: json,
                        select: true,
                        columns: [
                            { data: 'CountryName' },
                            { className: "hide", data: 'CountryId' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#tblCountries tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
                //     $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveCountry").html('Update');
            $("#btnDeleteCountry").css("display", "block");
            $('#hdnCountryId').val($(this).find('td:nth-child(2)').text());
            $('#<%=txtCountry.ClientID%>').val($(this).find('td:nth-child(1)').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);
        });


        $(function () {
            $("[id*=btnSaveCountry]").click(function () {
                var trimmedValue = jQuery.trim($('#<%=txtCountry.ClientID%>').val());
                if ($("#<%=txtCountry.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Country Name');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Country Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                obj.countryid = "0";
                if ($('#hdnCountryId').val() != '') {
                    obj.countryid = $.trim($("[id*=hdnCountryId]").val());
                }
                obj.country = $.trim($("[id*=<%=txtCountry.ClientID%>]").val());
                obj.buttontext = $("#btnSaveCountry").html();
                $.ajax({
                    type: "POST",
                    url: "ManageCountries.aspx/SaveCountry",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        //  alert(r.d);
                        $('#tblCountries').DataTable().destroy();
                        $('#tblCountries tbody').empty();
                        var pagenum;
                        if ($('#hdnpage').val() == '') {
                            pagenum = 0;
                        }
                        else {
                            pagenum = parseInt($('#hdnpage').val()) - 1;
                        }
                        loadtable(pagenum);
                        if (r.d == 'Country Name Already Found') {
                            $("#<%=lblError.ClientID%>").html('Country Name Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Country Name Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Country Name Updated Successfully');
                        }
                        if (r.d == 'Country Name Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Country Name Saved Successfully');
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
                objDelete.countryid = $.trim($("[id*=hdnCountryId]").val());
                $.ajax({
                    type: "POST",
                    url: "ManageCountries.aspx/DeleteCountry",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        $('#tblCountries').DataTable().destroy();
                        $('#tblCountries tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        if (r.d == 'Country Name Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Country Name Deleted Successfully');
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
            $("[id*=btnNewCountry]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#tblCountries tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveCountry").html('Save');
            $("#btnDeleteCountry").css("display", "none");
            $('#<%=txtCountry.ClientID%>').val('');
                $("[id*=hdnCountryId]").val('');
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
