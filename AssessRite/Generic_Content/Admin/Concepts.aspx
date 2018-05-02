<%@ Page Title="" Language="C#" MasterPageFile="~/Generic_Content/Admin/GCAdmin.Master" AutoEventWireup="true" CodeBehind="Concepts.aspx.cs" EnableEventValidation="false" Inherits="AssessRite.Generic_Content.Admin.Concepts" %>
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
        <h5 class="breadcrumbheading">Add/View/Update/Delete Concepts</h5>
    </div>
    <div class="card mb-3">
        <div class="card-header">
            <div class="row">
                <div class="col-lg-5" style="text-align: center">Add / Update Concept</div>
                <div class="col-lg-7" style="text-align: center">View / Delete Concept</div>
            </div>
        </div>
        <div class="card-body">
            <div style="display: none; text-align: center" id="myMessage1" runat="server" class="alert alert-success col-sm-12">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <asp:Label ID="lblMsg" runat="server" Text="Concept Saved Successfully"></asp:Label>
            </div>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <button id="btnNewConcept" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblInstitutionType" runat="server" Text="Institution Type"></asp:Label>
                        <asp:DropDownList ID="ddlInstitutionType" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Curriculum Type"></asp:Label>
                        <asp:DropDownList ID="ddlCurriculumType" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" Text="Level"></asp:Label>
                        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblClassName" runat="server" Text="Sub-Level"></asp:Label>
                        <asp:DropDownList ID="ddlSubLevel" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblConcepts" runat="server" Text="Concepts"></asp:Label>
                        <asp:TextBox ID="txtConcepts" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                    </div>
                    <div class="form-group hide" id="divChkClass">
                        <asp:Label ID="Label1" runat="server" Text="Check if this concept appeared in lower classes"></asp:Label>
                        <div style="overflow-y: scroll; height: 180px; margin-bottom: 20px;" id="dvCheckBoxListControl">
                            <asp:CheckBoxList ID="chkClass" runat="server" CssClass="form-control checkbox hide">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="form-group">
                         <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnConceptId" />
                    <a href="#" id="btnSaveConcept" class="btn btn-primary">Save</a>
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width:100%">
                            <thead>
                                <tr>
                                    <th style="display: none">ConceptId</th>
                                    <th>Sub-Level</th>
                                    <th>Subject</th>
                                    <th>Concept</th>
                                    <th style="display: none">SubLevelId</th>
                                    <th style="display: none">SubjectId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteConcept" style="display: none;margin:0 auto">Delete</button>
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
                                <div class="modal-body">Deleting this Concept might impact all its dependencies. Are you sure you want to delete this Concept?</div>
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
        <div class="card-footer small text-muted"></div>
    </div>
 <input type="hidden" id="hdnpage" />
     <asp:HiddenField ID="hdnCountry" runat="server" />
    <asp:HiddenField ID="hdnState" runat="server" />
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
        var table;
        $(document).ready(function () {
            $('#collapseExamplePages li').removeClass("current-menu-item");
            $('#liConcept').addClass('current-menu-item');
            $("#collapseExamplePages").addClass('sidenav-second-level collapse show');
            $(document).ajaxStart(function () {
             //   $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));
            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
              //  window.clearTimeout($("#loading").hide().data('timeout'));
            });
             loadInstitutionType();
           
            loadtable(0);
           
        });

        function loadInstitutionType() {
            var ddlInstitutionTypeXML = $('#<%=ddlInstitutionType.ClientID%>');
            ddlInstitutionTypeXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../../WebService/SuperAdminWebService.asmx/GetInstitutionTypesForDropDown",
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

        $('#<%=ddlInstitutionType.ClientID%>').change(function () {
            if ($("#<%=ddlInstitutionType.ClientID%> option:selected").text() == "School") {
                PopulateCheckBoxList();
                $('#divChkClass').show();
            }
            else {
                $('#divChkClass').hide();
            }
            $("#<%=ddlLevel.ClientID%>").empty();
            var CountryId = $('#<%=hdnCountry.ClientID%>').val();
            var StateId = $('#<%=hdnState.ClientID%>').val();
            var InstitutionTypeId = $('#<%=ddlInstitutionType.ClientID%>').val();
            loadCurriculumType(InstitutionTypeId, CountryId, StateId, "-1");
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
                url: "../../WebService/SuperAdminWebService.asmx/LoadDropDownCurriculumType",
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

          $('#<%=ddlCurriculumType.ClientID%>').change(function () {
            var curriculumtypeId = $('#<%=ddlCurriculumType.ClientID%>').val();
            loadLevels(curriculumtypeId, "1");
        });

         function loadLevels(curriculumtypeId, selectvalue) {
            var ddlLevelDropDownXML = $('#<%=ddlLevel.ClientID%>');
            ddlLevelDropDownXML.empty();
            var paramobj = {};
            paramobj.curriculumtypeId = curriculumtypeId;
            $.ajax({
                type: "POST",
                url: "../../WebService/SuperAdminWebService.asmx/LoadDropDownLevels",
                data: JSON.stringify(paramobj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    $(xmlDoc).find('Table').each(function () {
                        var OptionValue = $(this).find('LevelId').text();
                        var OptionText = $(this).find('LevelName').text();
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlLevelDropDownXML.append(option);
                    });
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No Level Found');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlCurriculumType.ClientID%> option').length > 0) {
                    clearInterval(interval);
                    $("#<%=ddlLevel.ClientID%>").val(selectvalue);
                }
            }, 200);
        }

          $('#<%=ddlLevel.ClientID%>').change(function () {
            var levelid = $('#<%=ddlLevel.ClientID%>').val();
            loadSubLevels(levelid, "1");
        });

        function loadSubLevels(levelid, selectvalue) {
            var ddlSubLevelDropDownXML = $('#<%=ddlSubLevel.ClientID%>');
            ddlSubLevelDropDownXML.empty();
            var paramobj = {};
            paramobj.levelid = levelid;
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/LoadDropDownSubLevels",
                data: JSON.stringify(paramobj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    $(xmlDoc).find('Table').each(function () {
                        var OptionValue = $(this).find('LevelId').text();
                        var OptionText = $(this).find('LevelName').text();
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlSubLevelDropDownXML.append(option);
                    });
                },
                error: function (response) {
                    $("#<%=lblError.ClientID%>").html('No Level Found');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlCurriculumType.ClientID%> option').length > 0) {
                    clearInterval(interval);
                    $("#<%=ddlLevel.ClientID%>").val(selectvalue);
                }
            }, 200);
        }

        $('#<%=ddlSubLevel.ClientID%>').change(function () {
            var sublevelid = $('#<%=ddlSubLevel.ClientID%>').val();
               loadSubject(sublevelid, "-1");
           });

        function loadSubject(sublevelid, selectvalue) {
            var ddlSubjectDropDownListXML = $('#<%=ddlSubject.ClientID%>');
            ddlSubjectDropDownListXML.empty();
            $.ajax({
                type: "POST",
                url: "../WebService/GCWebService.asmx/LoadDropdownSubjects",
                data: '{sublevelid: "' + sublevelid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // console.log(response.d);
                    $("#<%=divError.ClientID%>").css("display", "none");
                    var xmlDoc = $.parseXML(response.d);
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table2').each(function () {
                        // Get the OptionValue and OptionText Column values.
                        var OptionValue = $(this).find('SubjectId').text();
                        var OptionText = $(this).find('SubjectName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlSubjectDropDownListXML.append(option);
                    });
                    $('#<%=ddlSubject.ClientID%>').prepend('<option value="-1" selected="selected">--Select Subject--</option>');
                },
                error: function (response) {
                      $("#<%=lblError.ClientID%>").html('No Subjects Found For This Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return;
                }
            });
            var interval = setInterval(function () {
                if (document.querySelectorAll('#<%=ddlSubject.ClientID%> option').length > 0) {
                    //console.log('List is definitely populated!');
                    clearInterval(interval);
                    $("#<%=ddlSubject.ClientID%>").val(selectvalue);
                }
            }, 200);
        }


        function PopulateCheckBoxList() {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/LoadConceptCheckboxlist",
                contentType: "application/json; charset=utf-8",
                data: "{}",
                dataType: "json",
                success: AjaxSucceeded,
                error: AjaxFailed
            });
        }
        function AjaxSucceeded(result) {
            BindCheckBoxList(result);
        }
        function AjaxFailed(result) {
            alert('Failed to load checkbox list');
        }
        function BindCheckBoxList(result) {

            var items = JSON.parse(result.d);
            CreateCheckBoxList(items);
        }
        function CreateCheckBoxList(checkboxlistItems) {
            var table = $('<table class="checkbox" id="chkLowerClasses"></table>');
            var counter = 0;
            $(checkboxlistItems).each(function () {
                table.append($('<tr></tr>').append($('<td></td>').append($('<input>').attr({
                    type: 'checkbox', name: 'chklistitem', value: this.ClassId, id: 'chklistitem' + this.ClassId
                })).append(
                $('<label>').attr({
                    for: 'chklistitem' + this.ClassId++
                }).text(this.ClassName))));
            });

            $('#dvCheckBoxListControl').append(table);
        }

        function loadtable(defaultpage) {
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/GetConceptData",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // console.log(data.d)
                    var json = JSON.parse(data.d);
                    table = $('#myTable').DataTable({
                        data: json,
                        select: true,
                        columns: [
        { className: "hide", data: 'ConceptId' },
        { data: 'ClassName' },
        { data: 'SubjectName' },
        { data: 'ConceptName' },
        { className: "hide", data: 'ClassId' },
        { className: "hide", data: 'SubjectId' }
                        ]
                    });
                    table.page(defaultpage).draw(false);
                }
            });
        }

        $(document).on('click', '#myTable tbody tr', function () {
            $("#<%=divError.ClientID%>").css("display", "none");
            if ($(this).hasClass('selected')) {
            //    $(this).removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
            $("#btnSaveConcept").html('Update');
            // $("#id").css("display", "none");
            $("#btnDeleteConcept").css("display", "block");
            var classId = $(this).find('td:nth-child(5)').text();
            var subjectId = $(this).find('td:nth-child(6)').text();
            $('#hdnConceptId').val($(this).find('td:first').text());
            $("#<%=ddlSubLevel.ClientID%>").val(classId);
            loadSubject(classId, subjectId);
            $('#<%=txtConcepts.ClientID%>').val($(this).find('td:nth-child(4)').text());
            loadConceptLowerClasses($(this).find('td:first').text());
            var info = table.page.info();
            $('#hdnpage').val(info.page + 1);

        });

        function loadConceptLowerClasses(conceptid) {
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/getAllConceptAppearedinLowerClasses",
                data: '{conceptid: "' + conceptid + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response.d);
                    var xmlDoc = $.parseXML(response.d);
                    //if (xmlDoc == null) {
                    var checkboxes = $("[id*=chkLowerClasses] input:checkbox");
                    checkboxes.each(function () {
                        $(this).attr('checked', false);
                    });
                    // }
                    // console.log(xmlDoc);
                    // Now find the Table from response and loop through each item (row).
                    $(xmlDoc).find('Table').each(function () {
                        var classID = $(this).find('ClassId').text();
                        //  var checkboxid = "chklistitem" + classID;
                        // alert(classID + "," + checkboxid + "," + $(checkboxid).val());
                        var checkboxes = $("[id*=chkLowerClasses] input:checkbox");
                        //if($(checkboxid).val()==classID)
                        //{
                        //    $(checkboxid).attr('checked', true);
                        //}
                        checkboxes.each(function () {
                            var value = $(this).val();
                            //  alert("ClassId:" + classID + " checkboxvalue:" + value);
                            //   var text = $(this).closest("td").find("label").html();
                            if (value == classID) {
                                $(this).attr('checked', true);
                            }
                            //else {
                            //    $(this).attr('checked', false);
                            //}
                        });

                    });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $(function () {
            $("[id*=btnSaveConcept]").click(function () {
                //  alert('fd');
                var trimmedValue = jQuery.trim($('#<%=txtConcepts.ClientID%>').val());
                if ($("#<%=ddlSubLevel.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Class');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=ddlSubject.ClientID%>").val() == '-1') {
                    $("#<%=lblError.ClientID%>").html('Please Select Subject');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                else if ($("#<%=txtConcepts.ClientID%>").val() == '') {
                    $("#<%=lblError.ClientID%>").html('Please Enter Concept');
                    $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                }
                    else if (trimmedValue=='') {
                    $("#<%=lblError.ClientID%>").html('Concept Cannot Be Blank');
                    $("#<%=divError.ClientID%>").css("display", "block");
                        return false;
                }
                else {
                    $("#<%=divError.ClientID%>").css("display", "none");
                }
                var obj = {};
                //obj.ids = [];
                obj.classname=$("#<%=ddlSubLevel.ClientID%> option:selected").text();
                obj.classid = $.trim($("[id*=<%=ddlSubLevel.ClientID%>]").val());
                obj.subjectid = $.trim($("[id*=<%=ddlSubject.ClientID%>]").val());
                obj.concept = $.trim($("[id*=<%=txtConcepts.ClientID%>]").val());
                obj.buttontext = $("#btnSaveConcept").html();
                obj.ids = $("#chkLowerClasses input:checkbox:checked").map(function () {
                    return $(this).val();
                }).get();
                obj.chktext = $("#chkLowerClasses input:checkbox:checked").map(function () {
                    return $(this).closest("td").find("label").html();
                }).get();
                obj.conceptid = "0";
                if ($('#hdnConceptId').val() != '') {
                    obj.conceptid = $.trim($("[id*=hdnConceptId]").val());
                }
                $.ajax({
                    type: "POST",
                    url: "Concepts.aspx/SendParameters",
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
                        if (r.d == 'Invalid Lower Class')
                        {
                            $("#<%=lblError.ClientID%>").html('Invalid Lower Class');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                       if (r.d == 'Concept Cannot Have Special Characters')
                        {
                            $("#<%=lblError.ClientID%>").html('Concept Cannot Have Special Characters');
                            $("#<%=divError.ClientID%>").css("display", "block");
                           return false;
                        }
                        if (r.d == 'Concept Already Found') {
                            $("#<%=lblError.ClientID%>").html('Concept Already Found');
                            $("#<%=divError.ClientID%>").css("display", "block");
                            return false;
                        }
                        if (r.d == 'Concept Updated Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Concept Updated Successfully');
                        }
                        if (r.d == 'Concept Saved Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Concept Saved Successfully');
                        }
                        runEffect1();
                        loadClass();
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
                objDelete.conceptid = $.trim($("[id*=hdnConceptId]").val());
                $.ajax({
                    type: "POST",
                    url: "Concepts.aspx/DeleteConcept",
                    data: JSON.stringify(objDelete),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        // alert(r.d);
                        $('#myTable').DataTable().destroy();
                        $('#myTable tbody').empty();
                        var pagenum = parseInt($('#hdnpage').val()) - 1;
                        loadtable(pagenum);
                        loadClass();
                        if (r.d == 'Concept Deleted Successfully') {
                            $("#<%=lblMsg.ClientID%>").html('Concept Deleted Successfully');
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
            $("[id*=btnNewConcept]").click(function () {
                clear();
                return false;
            });

        });

        function clear() {
            $('#myTable tbody tr').siblings('.selected').removeClass('selected');
            $("#btnSaveConcept").html('Save');
            $("#btnDeleteConcept").css("display", "none");
            $("#<%=ddlSubLevel.ClientID%>").val('-1');
            //  $("#<%=ddlSubject.ClientID%>").val('-1');
            $('#<%=ddlSubject.ClientID%>').empty();
            $('#<%=txtConcepts.ClientID%>').val('');
            $("[id*=hdnConceptId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $('#dvCheckBoxListControl').empty();
            PopulateCheckBoxList();
        }
    </script>
</asp:Content>
