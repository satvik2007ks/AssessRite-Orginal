<%@ Page Title="" Language="C#" MasterPageFile="~/AssessRite/DE/de.Master" AutoEventWireup="true" CodeBehind="Concept.aspx.cs" Inherits="AssessRite.DE.Concept" EnableEventValidation="false"%>

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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnConceptsSave" />
                    <asp:PostBackTrigger ControlID="btnYes" />
                </Triggers>
                <ContentTemplate>--%>
            <div class="row">
                <div class="col-lg-5">
                    <div class="row" style="margin-top: 20px;">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center">
                            <asp:Button ID="btnNew" runat="server" CssClass="btn btn-primary hide" Text="New" OnClick="btnNew_Click" />
                            <button id="btnNewConcept" class="btn btn-primary">New</button>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblClassName" runat="server" Text="Class"></asp:Label>
                        <asp:DropDownList ID="ddlClassName" runat="server" CssClass="form-control"></asp:DropDownList>
                        <%--<select id="ddlClass">
            </select>--%>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSubject" runat="server" Text="Subject"></asp:Label>
                        <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblConcepts" runat="server" Text="Concepts"></asp:Label>
                        <asp:TextBox ID="txtConcepts" runat="server" CssClass="form-control" MaxLength="48"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Check if this concept appeared in lower classes"></asp:Label>
                        <div style="overflow-y: scroll; height: 180px; margin-bottom: 20px;" id="dvCheckBoxListControl">
                            <asp:CheckBoxList ID="chkClass" runat="server" CssClass="form-control checkbox hide">
                            </asp:CheckBoxList>
                        </div>
                        <div class="help-block" id="divError" runat="server" style="display: none">
                            <asp:Label ID="lblError" runat="server" Style="color: red" Text="Please Enter Class"></asp:Label>
                        </div>
                    </div>
                    <input type="hidden" id="hdnConceptId" />
                    <a href="#" id="btnSaveConcept" class="btn btn-primary">Save</a>
                    <asp:Button ID="btnConceptsSave" runat="server" Text="Save" CssClass="btn btn-primary hide" OnClick="btnConceptsSave_Click" />
                </div>
                <div class="col-lg-7">
                    <div class="table-responsive hide">
                        <asp:GridView ID="gridConcept" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridConcept_RowDataBound" OnSelectedIndexChanged="gridConcept_SelectedIndexChanged" DataKeyNames="ConceptId">
                            <Columns>
                                <asp:BoundField DataField="ClassName" HeaderText="Class" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="SubjectName" HeaderText="Subject" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                                <asp:BoundField DataField="ConceptName" HeaderText="Concept" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                                <asp:BoundField DataField="ClassId" HeaderText="ClassId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                                <asp:BoundField DataField="SubjectId" HeaderText="SubjectId" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hideGridColumn" ItemStyle-CssClass="hideGridColumn" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-bordered" id="myTable" style="width: 100%">
                            <thead>
                                <tr>
                                    <th style="display: none">ConceptId</th>
                                    <th>ClassName</th>
                                    <th>SubjectName</th>
                                    <th>ConceptName</th>
                                    <th style="display: none">ClassId</th>
                                    <th style="display: none">SubjectId</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="text-align: center; margin-bottom: 10px">
                            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary hide" Text="Delete" OnClick="btnDelete_Click" Visible="false" />
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal1" id="btnDeleteConcept" style="display: none; margin: 0 auto">Delete</button>
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
                                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="btn btn-primary hide" OnClick="btnYes_Click" />
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
    <%-- <script>
        $(document).ready(function () {
            $("#navbar li").removeClass("current-menu-item");//this will remove the active class from  
            //$("#navbar1 li").removeClass("current-menu-item");//this will remove the active class from  
            $('#liConcepts').addClass('current-menu-item');
            //$('#liConcepts1').addClass('current-menu-item');
            $('#subjectname').addClass('active');
        });
    </script>
    <script>
        //function pageLoad(sender, args) {
        //    $(".dataTable tbody").before("<thead><tr></tr></thead>");
        //    $(".dataTable thead tr").append($(".dataTable th"));
        //    $(".dataTable tbody tr:first").remove();

        //    $(".dataTable").DataTable();
        //}
    </script>--%>

    <script>
        var table;
        $(document).ready(function () {
            $(document).ajaxStart(function () {

                //  $("#loading").data('timeout', window.setTimeout(function () { $("#loading").show() }, 100));

            }).ajaxStop(function () {
                $('#myTable_filter').prop('title', 'Please Enter Atleast 3 Characters For Better Search Results');
                //  window.clearTimeout($("#loading").hide().data('timeout'));

            });
            loadClass();
            PopulateCheckBoxList();
            loadtable(0);

        });

        function loadClass() {
            var ddlClassDropDownListXML = $('#<%=ddlClassName.ClientID%>');
            ddlClassDropDownListXML.empty();
            var tableName = "Table";
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/LoadConceptDropdownsClass",
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
                        var OptionValue = $(this).find('ClassId').text();
                        var OptionText = $(this).find('ClassName').text();
                        // Create an Option for DropDownList.
                        var option = $("<option>" + OptionText + "</option>");
                        option.attr("value", OptionValue);
                        ddlClassDropDownListXML.append(option);
                    });
                    $('#<%=ddlClassName.ClientID%>').prepend('<option value="-1" selected="selected">--Select Class--</option>');
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        $('#<%=ddlClassName.ClientID%>').change(function () {
            var selectedVal = $('#<%=ddlClassName.ClientID%>').val();
            loadSubject(selectedVal, "-1");
        });

        function loadSubject(classid, selectvalue) {
            var ddlSubjectDropDownListXML = $('#<%=ddlSubject.ClientID%>');
            ddlSubjectDropDownListXML.empty();
            $.ajax({
                type: "POST",
                url: "../WebMethods/GetData.asmx/LoadConceptDropdownsSubject",
                data: '{classid: "' + classid + '"}',
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
              //  $(this).removeClass('selected');
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
            $("#<%=ddlClassName.ClientID%>").val(classId);
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
                if ($("#<%=ddlClassName.ClientID%>").val() == '-1') {
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
                else if (trimmedValue == '') {
                    $("#<%=lblError.ClientID%>").html('Concept Cannot Be Blank');
                         $("#<%=divError.ClientID%>").css("display", "block");
                    return false;
                     }
                     else {
                         $("#<%=divError.ClientID%>").css("display", "none");
                     }
                var obj = {};
                //obj.ids = [];
                 obj.classname=$("#<%=ddlClassName.ClientID%> option:selected").text();
                obj.classid = $.trim($("[id*=<%=ddlClassName.ClientID%>]").val());
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
                    url: "Concept.aspx/SendParameters",
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
                        if (r.d == 'Concept Cannot Have Special Characters') {
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
                        clear();
                        loadClass();
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
            $("#<%=ddlClassName.ClientID%>").val('-1');
            //  $("#<%=ddlSubject.ClientID%>").val('-1');
            $('#<%=ddlSubject.ClientID%>').empty();
            $('#<%=txtConcepts.ClientID%>').val('');
            $("[id*=hdnConceptId]").val('');
            $("#<%=divError.ClientID%>").css("display", "none");
            $('#dvCheckBoxListControl').empty();
            PopulateCheckBoxList();
        }

        //$.ajaxSetup({
        //    beforeSend: function () {
        //        // show gif here, eg:
        //        alert("start");
        //        $("#loading").show();
        //    },
        //    complete: function () {
        //        // hide gif here, eg:
        //        alert("end");
        //        $("#loading").hide();
        //    }
        //});

    </script>
</asp:Content>
