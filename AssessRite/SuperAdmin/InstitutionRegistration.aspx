<%@ Page Title="" Language="C#" MasterPageFile="~/SuperAdmin/superadmin.Master" AutoEventWireup="true" CodeBehind="InstitutionRegistration.aspx.cs" Inherits="AssessRite.SuperAdmin.InstitutionRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table1 tr, td, th {
            text-align: center !important;
        }

        .hideGridColumn {
            display: none;
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

        .hideDiv {
            display: none;
        }

        .showDiv {
            display: block;
        }
    </style>
    <link href="../css/jquery-ui.css" rel="stylesheet" />
    <link href="../css/bootstrap-timepicker.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-ui.js"></script>
    <script src="../Scripts/bootstrap-timepicker.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="breadcrumb">
        <h5 class="breadcrumbheading">Institution Registration</h5>
    </div>
    <div id="divStep1">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">
                        <h5><b>STEP 1 of 3</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">Add Insitution Info</div>
                </div>
            </div>
            <div class="card-body">
                <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="lblMsg" runat="server" Text="School Info Saved Successfully"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-lg-4"></div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <asp:Label ID="lblInstitutionName" runat="server" Text="Institution Name*"></asp:Label>
                            <asp:TextBox ID="txtInstitutionName" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label5" runat="server" Text="Institution Type*"></asp:Label>
                            <asp:DropDownList ID="ddlInstitutionType" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblInstitutionAddress" runat="server" Text="Institution Address*"></asp:Label>
                            <asp:TextBox ID="txtInstitutionAddress" runat="server" TextMode="Multiline" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblCounty" runat="server" Text="Country*"></asp:Label>
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" Text="State*"></asp:Label>
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" Text="Zip Code*"></asp:Label>
                            <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control onlynumber" MaxLength="8"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" runat="server" Text="Contact No#*"></asp:Label>
                            <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control onlynumber" MaxLength="15"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label4" runat="server" Text="Email ID*"></asp:Label>
                            <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                        </div>
                        <%--  <div class="form-group">
                        <asp:Label ID="Label12" runat="server" Text="Principal Name"></asp:Label>
                        <asp:TextBox ID="txtPrincipalName" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                    </div>--%>
                        <div class="form-group">
                            <asp:Label ID="Label13" runat="server" Text="Emergency Contact No."></asp:Label>
                            <asp:TextBox ID="txtEmergencyContact" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                            <div class="help-block" id="divError" runat="server" style="display: none">
                                <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                            </div>

                        </div>

                        <input type="hidden" id="hdnInstitutionId" />
                        <a href="#" id="btnSaveInstitution" class="btn btn-primary">Save & Next</a>
                    </div>
                    <div class="col-lg-4"></div>
                </div>
            </div>
            <div class="card-footer small text-muted"></div>
        </div>
    </div>
    <div id="divStep2" class="hideDiv">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">
                        <h5><b>STEP 2 of 3</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">Add Admin</div>
                </div>
            </div>
            <div class="card-body">
                <div style="display: none; text-align: center" id="Div1" runat="server" class="alert alert-success col-sm-12">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="Label6" runat="server" Text="School Info Saved Successfully"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-lg-4"></div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <asp:Label ID="Label18" runat="server" Text="Institution"></asp:Label>
                            <asp:DropDownList ID="ddlInsitution" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label7" runat="server" Text="Admin Name*"></asp:Label>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label9" runat="server" Text="Admin Address*"></asp:Label>
                            <asp:TextBox ID="TextBox2" runat="server" TextMode="Multiline" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label14" runat="server" Text="Contact No#*"></asp:Label>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control onlynumber" MaxLength="15"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label15" runat="server" Text="Email ID*"></asp:Label>
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" MaxLength="99"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblUsername" runat="server" Text="UserName*"></asp:Label>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPassword" runat="server" Text="Password*"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                            <div class="help-block" id="div2" runat="server" style="display: none">
                                <asp:Label ID="Label8" runat="server" Style="color: red" Text="Please Enter School"></asp:Label>
                            </div>
                        </div>
                        <%--<input type="hidden" id="hdnSchoolId" />--%>
                        <a href="#" id="btnGoToStep1" class="btn btn-primary">Previous</a>
                        <a href="#" id="btnSaveAdmin" class="btn btn-primary">Save & Next</a>
                    </div>
                    <div class="col-lg-4"></div>
                </div>
            </div>
            <div class="card-footer small text-muted"></div>
        </div>
    </div>
    <div id="divStep3" class="hideDiv">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">
                        <h5><b>STEP 3 of 3</b></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12" style="text-align: center">Subscription Details</div>
                </div>
            </div>
            <div class="card-body">
                <div style="display: none; text-align: center" id="Div3" runat="server" class="alert alert-success col-sm-12">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="Label10" runat="server" Text="School Info Saved Successfully"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-lg-4"></div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <asp:Label ID="Label11" runat="server" Text="Subscription Type"></asp:Label>
                            <asp:DropDownList ID="ddlSubscriptionType" runat="server" CssClass="form-control">
                                <asp:ListItem Value="Yearly" Selected="True">Yearly</asp:ListItem>
                                <asp:ListItem Value="Monthly">Monthly</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label23" runat="server" Text="Curriculum Type"></asp:Label>
                            <asp:DropDownList ID="ddlCurriculumType" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label24" runat="server" Text="Content Type"></asp:Label>
                            <asp:DropDownList ID="ddlContentType" runat="server" CssClass="form-control">
                                <asp:ListItem Value="-1">--Select Content Type--</asp:ListItem>
                                <asp:ListItem Value="-1">Generic Content</asp:ListItem>
                                <asp:ListItem Value="-1">Custom Content</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label12" runat="server" Text="No. of Students*"></asp:Label>
                            <asp:TextBox ID="txtNoOfStudents" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </div>
                        <div class="form-group" id="divCheckbox">
                            <asp:Label ID="Label34" runat="server" Text="Test Type"></asp:Label>
                            <asp:CheckBoxList ID="chkTestType" runat="server" CssClass="checkbox">
                                <asp:ListItem Value="Online">Online</asp:ListItem>
                                <asp:ListItem Value="Offline">Offline</asp:ListItem>
                                <asp:ListItem Value="ZeroNet">ZeroNet</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label19" runat="server" Text="Subscription Start Date*"></asp:Label>
                            <asp:TextBox ID="txtSubscriptionStartDate" runat="server" CssClass="form-control Otherdatepicker" MaxLength="99"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label20" runat="server" Text="Subscription End Date*"></asp:Label>
                            <asp:TextBox ID="txtSubscriptionEndDate" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label25" runat="server" Text="Mode of Payment"></asp:Label>
                            <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="form-control"></asp:DropDownList>
                            <div class="help-block" id="div4" runat="server" style="display: none">
                                <asp:Label ID="Label22" runat="server" Style="color: red" Text="Please Enter School"></asp:Label>
                            </div>
                        </div>
                        <%--<input type="hidden" id="hdnSchoolId" />--%>
                        <a href="#" id="btnGoToStep2" class="btn btn-primary">Previous</a>
                        <a href="#" id="btnSaveSubscription" class="btn btn-primary">Save</a>
                    </div>
                    <div class="col-lg-4"></div>
                </div>
            </div>
            <div class="card-footer small text-muted"></div>
        </div>
    </div>
    <input type="hidden" id="hdnpage" />

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
    <script>
        var table;
        $('.Otherdatepicker').datepicker();
        $(document).ready(function () {
            loadCountry();
            loadInstitutionType();
            OnlyNumber();
        });

        function OnlyNumber() {
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
        }
        function loadCountry() {
            var ddlCountryDropDownListXML = $('#<%=ddlCountry.ClientID%>');
            ddlCountryDropDownListXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/LoadSchoolDropdownCountry",
                data: '{tableName: "' + tableName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    //  console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('CountryId').text();
                        var OptionText = $(this).find('CountryName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlCountryDropDownListXML.append(option);
                    });
                    $('#<%=ddlCountry.ClientID%>').prepend('<option value="-1" selected="selected">--Select Country--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $('#<%=ddlCountry.ClientID%>').change(function () {
            var selectedVal = $('#<%=ddlCountry.ClientID%>').val();
            loadState(selectedVal, "-1");
        });

        function loadState(countryid, selectvalue) {
            var ddlStateDropDownListXML = $('#<%=ddlState.ClientID%>');
            ddlStateDropDownListXML.empty();
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/LoadSchoolDropdownState",
                data: '{countryid: "' + countryid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('StateId').text();
                        var OptionText = $(this).find('StateName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlStateDropDownListXML.append(option);
                    });
                    $('#<%=ddlState.ClientID%>').prepend('<option value="-1" selected="selected">--Select State--</option>');
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No States Found For This Country');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlState.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlState.ClientID%>").val(selectvalue);
                }
            }, 200);
        }

        function loadInstitutionType() {
            var ddlInstitutionTypeXML = $('#<%=ddlInstitutionType.ClientID%>');
            ddlInstitutionTypeXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/GetInstitutionTypesForDropDown",
                data: '{tableName: "' + tableName + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    //  console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('InstitutionTypeId').text();
                        var OptionText = $(this).find('InstitutionType').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlInstitutionTypeXML.append(option);
                    });
                    $('#<%=ddlInstitutionType.ClientID%>').prepend('<option value="-1" selected="selected">--Select Institution Type--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }



     <%--   function loadSchoolTestTypes(schoolid) {
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebService/SuperAdminWebService.asmx/getAllTestTypesForSchool",
                data: '{schoolid: "' + schoolid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    var checkboxes = $("[id*=<%= chkTestType.ClientID %>] input:checkbox");
                    checkboxes.each(function () {
                        $(this).attr('checked', false);
                    });
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        var TestType = $(this).find('TestType').text();
                        var checkboxes = $("[id*=<%= chkTestType.ClientID %>] input:checkbox");
                        checkboxes.each(function () {
                            var value = $(this).val();
                            if (value == TestType) {
                                $(this).attr('checked', true);
                            }
                        });

                    });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }--%>

        $(function () {
            $("[id*=btnSaveInstitution]").click(function (e) {
                var CountryId = $('#<%=ddlCountry.ClientID%>').val();
                var StateId = $('#<%=ddlState.ClientID%>').val();
                var InstitutionTypeId = $('#<%=ddlInstitutionType.ClientID%>').val();
                loadCurriculumType(InstitutionTypeId, CountryId, StateId, "-1");

                $("#divStep1").hide(1000);
                $("#divStep2").show();
                $(window).scrollTop(0);
                e.preventDefault();
            });
        });

        function loadCurriculumType(institutiontypeid, countryid, stateid, selectvalue) {
            var ddlCurriculumTypeDropDownListXML = $('#<%=ddlCurriculumType.ClientID%>');
              ddlCurriculumTypeDropDownListXML.empty();
              var paramobj = {};
              paramobj.countryid = countryid;
              paramobj.stateid = stateid;
              paramobj.institutionTypeId = institutiontypeid;
              $.ajax({
                  type: "POST",
                  url: "../WebService/SuperAdminWebService.asmx/LoadDropDownCurriculumType",
                  data: JSON.stringify(paramobj),
                  //  data: '{institutiontypeid: "' + institutiontypeid + '",countryid="' + countryid + '",stateid="' + stateid + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                      // console.log(response.d);
                      $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('CurriculumTypeId').text();
                        var OptionText = $(this).find('CurriculumType').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlCurriculumTypeDropDownListXML.append(option);
                    });
                    $('#<%=ddlCurriculumType.ClientID%>').prepend('<option value="-1" selected="selected">--Select Curriculum Type--</option>');
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No Curriculum Type Found');
                     $("#<%=divError.ClientID%>").css("display", "block");
                      return;
                  }
              });
              var interval = setInterval(function () {
                  if (document.querySelectorAll('#<%=ddlCurriculumType.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlCurriculumType.ClientID%>").val(selectvalue);
                }
            }, 200);
        }

        $(function () {
            $("[id*=btnGoToStep1]").click(function (e) {
                $("#divStep2").hide();
                $("#divStep1").show(1000);
                e.preventDefault();
            });
        });

        $(function () {
            $("[id*=btnSaveAdmin]").click(function (e) {
                $("#divStep2").hide(1000);
                $("#divStep3").show();
                $(window).scrollTop(0);
                e.preventDefault();
            });
        });


        $(function () {
            $("[id*=btnGoToStep2]").click(function (e) {
                $("#divStep3").hide();
                $("#divStep2").show(1000);
                e.preventDefault();
            });
        });

        $("#<%=txtSubscriptionStartDate.ClientID%>").change(function () {
            alert("working");
            var tt = $("#<%=txtSubscriptionStartDate.ClientID%>").val();
                var date = new Date(tt);
                var newdate = new Date(date);

            if ($("#<%=ddlSubscriptionType.ClientID%>").val() == 'Monthly') {
                newdate.setDate(newdate.getDate() + 30);
                var dd = newdate.getDate();
                var mm = newdate.getMonth() + 1;
                var y = newdate.getFullYear();

                var someFormattedDate = mm + '/' + dd + '/' + y;
                $("#<%=txtSubscriptionEndDate.ClientID%>").val(someFormattedDate);
            }
            else if ($("#<%=ddlSubscriptionType.ClientID%>").val() == 'Yearly') {
                 newdate.setDate(newdate.getDate());
                var dd = newdate.getDate();
                var mm = newdate.getMonth();
                var y = newdate.getFullYear()+1;
                var someFormattedDate = mm + '/' + dd + '/' + y;
                $("#<%=txtSubscriptionEndDate.ClientID%>").val(someFormattedDate);
            }
        });
        $(function () {
            $("[id*=btnSaveSubscription]").click(function (e) {
                e.preventDefault();
            });
        });



        $(function () {
            $("[id*=btnSaveSchool]").click(function () {
                //  alert('fd');
                if (jQuery.trim($("#<%=txtInstitutionName.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Name');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtInstitutionAddress.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Address');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlCountry.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Country');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlState.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select State');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtZipCode.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Zipcode');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtContactNo.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School Contact No#');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if (jQuery.trim($("#<%=txtEmailID.ClientID%>").val()) == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter School E-Mail');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                if (jQuery.trim($("#<%=txtEmailID.ClientID%>").val()) != '') {
                    if (!validateEmail($("#<%=txtEmailID.ClientID%>").val())) {
                        $("#<%=lblError.ClientID%>").html('Invalid E-Mail-ID');
                        $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                    }
                }
                <%--var chks = $("#<%= chkTestType.ClientID %> input:checkbox");
                var hasChecked = false;
                for (var i = 0; i < chks.length; i++) {
                    if (chks[i].checked) {
                        hasChecked = true;
                        break;
                    }
                }
                if (hasChecked == false) {
                    alert("Please select at least one Test Type!");
                    return false;
                }--%>
                var obj = {};
                obj.schoolid = "0";

                if ($('#hdnSchoolId').val() != '') {
                    obj.schoolid = $.trim($("[id*=hdnSchoolId]").val());
                }
               <%-- obj.testtype = $("#<%= chkTestType.ClientID %> input:checkbox:checked").map(function () {
                    return $(this).closest("td").find("label").html();
                }).get();--%>
                obj.schoolname = $.trim($("[id*=<%=txtInstitutionName.ClientID%>]").val());
                obj.schooladdress = $.trim($("[id*=<%=txtInstitutionAddress.ClientID%>]").val());
                obj.countryid = $.trim($("[id*=<%=ddlCountry.ClientID%>]").val());
                obj.stateid = $.trim($("[id*=<%=ddlState.ClientID%>]").val());
                obj.zipcode = $.trim($("[id*=<%=txtZipCode.ClientID%>]").val());
                obj.contactno = $.trim($("[id*=<%=txtContactNo.ClientID%>]").val());
                obj.emailid = $.trim($("[id*=<%=txtEmailID.ClientID%>]").val());
               <%-- obj.noofstudents = "0";
                if ($.trim($("[id*=<%=txtNoOfStudent.ClientID%>]").val()) != '') {
                    obj.noofstudents = $.trim($("[id*=<%=txtNoOfStudent.ClientID%>]").val());
                }
                obj.principalname = $.trim($("[id*=<%=txtPrincipalName.ClientID%>]").val());--%>
                obj.emergencycontact = $.trim($("[id*=<%=txtEmergencyContact.ClientID%>]").val());
                obj.buttontext = $("#btnSaveSchool").html();
                //   alert(obj.schoolid, obj.schoolname, obj.schooladdress, obj.countryid, obj.stateid, obj.zipcode, obj.contactno, obj.emailid, obj.emailid, obj.noofstudents, obj.principalname, obj.emergencycontact,obj.buttontext);
                $.ajax({
                    type: "POST",
                    url: "SchoolInfo.aspx/SendParameters",
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
                        if (r.d == 'School Info Already Exists') {
                            $("#<%=lblError.ClientID%>").html('School Info Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'UserName Already Exists') {
                            $("#<%=lblError.ClientID%>").html('UserName Already Exists');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'School Info Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('School Info Updated Successfully');
                        }
                        if (r.d == 'School Added Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('School Added Successfully');
                        }
                        runEffect1();
                        clear();
                    }
                });
                return false;
            });
        });


        function validateEmail($email) {
            var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            return emailReg.test($email);
        }


        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $('#hdnSchoolId').val('');
            $('#<%=txtInstitutionName.ClientID%>').val('');
            $('#<%=txtInstitutionAddress.ClientID%>').val('');
            $('#<%=ddlCountry.ClientID%>').val('-1');
            $('#<%=ddlState.ClientID%>').val('-1');
            $('#<%=txtZipCode.ClientID%>').val('');
            $('#<%=txtContactNo.ClientID%>').val('');
            $('#<%=txtEmailID.ClientID%>').val('');
           <%-- $('#<%=txtPrincipalName.ClientID%>').val('');  --%>
            $('#<%=txtEmergencyContact.ClientID%>').val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $("#btnDeleteSchool").css("display", "none");
            $("#btnSaveSchool").html('Save');
        <%--$("#<%= chkTestType.ClientID %> input:checkbox").removeAttr('checked'); --%>
        }
    </script>
</asp:Content>
