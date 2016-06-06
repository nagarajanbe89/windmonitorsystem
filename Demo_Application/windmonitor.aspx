<%@ Page Title="Home Page" Language="vb" MasterPageFile="Site.Master" AutoEventWireup="false"
    CodeBehind="windmonitor.aspx.vb" Inherits="Demo_Application._Default" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript">
        $(function () {
            $('#<%=btnclick.ClientID%>').click(function () {
                $("#popupdiv").dialog({
                    title: "Last 10 Days Data",
                    width: 1000,
                    height: 500,
                    modal: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog('close');
                        }
                    }
                });
                return false;
            });
        })
    </script>
    <div class="col-lg-12 text-center">
        <table width="100%" cellspacing="10" cellpadding="10">
            <tr>
                <td width="40%" align="left">
                    <span id="sp_state" title="State">State</span>
                </td>
                <td width="20%">
                </td>
                <td width="40%" align="left">
                    <span id="sp_city" title="City">City</span>
                </td>
            </tr>
            <tr>
                <td>
                    <select id="cbostate" runat="server" class="form-control" onchange="javascript:popcity();">
                    </select>
                </td>
                <td>
                </td>
                <td>
                    <select id="cbocity" runat="server" class="form-control" onchange="javascript:popstation_code();">
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="sp_stationcode" >Station Code</span>
                </td>
                <td>
                </td>
                <td align="left">
                    <span id="sp_date" >Date</span>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txt_stationcode" runat="server" class="form-control input-sm " />
                </td>
                <td>
                </td>
                <td align="left">
                    <input type="text" id="txtfrom_date" runat="server" class="datepicker  input-sm" onchange="javascript:popstation_code()" />
                    <asp:Button ID="btnclick" class="btn-link" runat="server" Text="Previous Data" />
                    <%--<button type="button" class="btn btn-link btn-sm" data-toggle="modal" data-target="#myModal">Past Data</button>--%>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="sp_predicted" title="State">Predicted Speed (KM/H)</span>
                </td>
                <td>
                </td>
                <td align="left">
                    <span id="sp_actual" title="City">Actual Speed (KM/H)</span>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtpredicted_speed" runat="server" class="form-control input-sm" />
                </td>
                <td>
                </td>
                <td align="left">
                    <input type="text" id="txtactual_speed" runat="server" class="form-control input-sm"
                        onchange="javascript:variance();" />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <span id="sp_variance" title="State">Variance</span>
                </td>
                <td>
                </td>
                <td align="left">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <input type="text" id="txtvariance" runat="server" class="form-control" />
                </td>
                <td>
                </td>
                <td align="left">
                    <button id="btnsave" type="button" runat="server" class="btn btn-default" onclick="javascript:insert();">
                        Save</button>
                    <button id="btnclear" type="button" runat="server" class="btn btn-default" onclick="javascript:clear();">
                        Cancel</button>
                </td>
            </tr>
        </table>
    </div>
    <div >
        <div id="popupdiv" title="Basic modal dialog" style="display: none" >
            <table id="tbDetails" cellpadding="0" cellspacing="0" width="100%">
                <thead style="background-color: #DC5807; color: White; font-weight: bold">
                    <tr style="border: solid 1px #000000">
                        <td>
                            State
                        </td>
                        <td>
                            City
                        </td>
                        <td>
                            Station Code
                        </td>
                        <td>
                            Date
                        </td>
                        <td>
                            Predicted Speed
                        </td>
                        <td>
                            Actual Speed
                        </td>
                        <td>
                            Variance
                        </td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            popstate();

        });
    </script>
    <script type="text/javascript">
        function popstate() {
            $.ajax({
                type: "POST",
                url: "services.asmx/getstate",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = JSON.parse(data.d);
                    var ddlCustomers = $("[id*=cbostate]");
                    ddlCustomers.empty().append('<option selected="selected" value="0">--Select State--</option>');
                    $.each(obj.mst_state, function (key, value) {
                        if (value != null) {
                            var state_id = value[0];
                            var state_name = value[1]
                            var value1 = [];
                            value1.push(state_id);
                            var value2 = [];
                            value2.push(state_name);
                            for (i = 0; i < value1.length; i++) {
                                ddlCustomers.append($("<option value = '" + value1[i] + "'>" + value2[i] + "</option>"));
                            }
                        }
                    });
                },
                error: function (result) {
                    alert(result.d);
                }
            });


        }
    </script>
    <script type="text/javascript">
        function popcity() {
            var state = $('#<%=cbostate.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: "services.asmx/getcity",
                data: JSON.stringify({ 'state_id': state }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = JSON.parse(data.d);
                    var ddlCustomers = $("[id*=cbocity]");
                    ddlCustomers.empty().append('<option selected="selected" value="0">--Select City--</option>');
                    $.each(obj.mst_city, function (key, value) {
                        if (value != null) {
                            var city_id = value[0];
                            var city_name = value[1]
                            var value1 = [];
                            value1.push(city_id);
                            var value2 = [];
                            value2.push(city_name);
                            for (i = 0; i < value1.length; i++) {
                                ddlCustomers.append($("<option value = '" + value1[i] + "'>" + value2[i] + "</option>"));
                            }
                        }
                    });
                },
                error: function (result) {
                    alert(result.d);
                }
            });


        }
    </script>
    <script type="text/javascript">
        function popstation_code() {
            var city = $('#<%=cbocity.ClientID%>').val();
            var date = $('#<%=txtfrom_date.ClientID%>').val();
            $.ajax({
                type: "POST",
                url: "services.asmx/getstationcode",
                data: JSON.stringify({ 'city_id': city,'need_date' : date }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var obj = JSON.parse(data.d)

                    $('#<%=txt_stationcode.ClientID%>').val(obj[0].station);
                    $('#<%=txtpredicted_speed.ClientID%>').val(obj[0].predicted);
                },
                error: function (result) {
                    alert(result.d);
                }
            });


        }
    </script>
    <script type="text/javascript">
        function variance() {
            var text;
            var predicted = $('#<%=txtpredicted_speed.ClientID%>').val();
            var actual = $('#<%=txtactual_speed.ClientID%>').val();
            var variance = predicted - actual;

            $('#<%=txtvariance.ClientID%>').val(variance);
            $('#<%=txtvariance.ClientID%>').css("font-weight", "bold");
            if (variance == 1 || variance == -1) {
                
                $('#<%=txtvariance.ClientID%>').css("color", "black");

            }
            else if (variance == 3 || variance == -3) {
                $('#<%=txtvariance.ClientID%>').css("color", "#800080");
            }
            else if (variance <= -5 || variance > 5) {
                $('#<%=txtvariance.ClientID%>').css("color", "red");
            }
            else {
                $('#<%=txtvariance.ClientID%>').css("color", "black");
            }


        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".datepicker").datepicker({ format: 'MM dd,yyyy', autoclose: true, todayBtn: 'linked' });
            var currentDate = new Date();
            $(".datepicker").datepicker("setDate", currentDate);
        });
    </script>
    <script type="text/javascript">
        function insert() {
            var state = $('#<%=cbostate.ClientID%>').val();
            var city = $('#<%=cbocity.ClientID%>').val();
            var station = $('#<%=txt_stationcode.ClientID%>').val();
            var from_date = $('#<%=txtfrom_date.ClientID%>').val();
            var predicted = $('#<%=txtpredicted_speed.ClientID%>').val();
            var actual = $('#<%=txtactual_speed.ClientID%>').val();
            var variance = $('#<%=txtvariance.ClientID%>').val();

            $.ajax({
                type: "POST",
                url: "services.asmx/insert",
                data: JSON.stringify({ 'state': state, 'city': city, 'station': station, 'from_date': from_date, 'predicted': predicted, 'actual': actual, 'variance': variance }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    alert(data.d);
                },
                error: function (result) {
                    alert(result.d);
                }
            });
        }
    </script>
    <script type="text/javascript">
       
        function clear() {
            $('#<%=txt_stationcode.ClientID%>').val();
            $(".datepicker").datepicker("setDate", currentDate);
            $('#<%=txtpredicted_speed.ClientID%>').val();
            $('#<%=txtactual_speed.ClientID%>').val();
            $('#<%=txtvariance.ClientID%>').val();


        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "services.asmx/getdata",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    var obj = JSON.parse(data.d)
                    $.each(obj.trn_historicaldata, function (key, value) {
                        if (value != null) {
                            var city_name = value[0];
                            var state_name = value[1];
                            var station_code = value[2];
                            var trn_date = value[3];
                            var predicted_speed = value[4];
                            var actual_speed = value[5];
                            var vairance = value[6];
                            var value1 = [];
                            value1.push(city_name);
                            var value2 = [];
                            value2.push(state_name);
                            var value3 = [];
                            value3.push(station_code);
                            var value4 = [];
                            value4.push(trn_date);
                            var value5 = [];
                            value5.push(predicted_speed);
                            var value6 = [];
                            value6.push(actual_speed);
                            var value7 = [];
                            value7.push(vairance);

                            for (i = 0; i < value1.length; i++) {
                                $("#tbDetails").append("<tr><td>" + value1[i] + "</td><td>" + value2[i] + "</td><td>" + value3[i] + "</td><td>" + value4[i] + "</td><td>" + value5[i] + "</td><td>" + value6[i] + "</td><td>" + value7[i] + "</td></tr>");
                            }
                        }
                    });

                },
                error: function (result) {
                    alert("Error");
                }
            });
        });
    </script>
</asp:Content>
