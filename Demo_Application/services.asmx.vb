Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Data.Odbc

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService([Namespace]:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<System.Web.Script.Services.ScriptService()> _
<ToolboxItem(False)> _
Public Class services
    Inherits System.Web.Services.WebService
    Dim conn As New dbconn
    Dim mssql As String
    Dim objodbcdatareader, objodbcdatareader2 As OdbcDataReader
    Dim ds_data As New DataSet

    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=False)> _
    Public Function getstate()
        conn.OpenConn()
        Dim result As String
        mssql = "select state_id, state_name from mst_state order by state_name"
        ds_data = conn.GetDataSet(mssql, "mst_state")
        result = DataSetToJSON(ds_data)
        conn.CloseConn()
        Return result
    End Function
    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=False)> _
    Public Function getcity(ByVal state_id As String)
        conn.OpenConn()
        Dim result As String
        mssql = "select city_id, city_name from mst_city where state_id='" & state_id & "' order by city_name"
        ds_data = conn.GetDataSet(mssql, "mst_city")
        result = DataSetToJSON(ds_data)
        conn.CloseConn()
        Return result
    End Function
    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=False)> _
    Public Function getdata()
        conn.OpenConn()
        Dim result As String
        mssql = "select city_name,state_name,a.station_code,cast(date_format(trn_date,'%d %M,%Y') as char) as trn_date,predicted_speed,actual_speed,a.vairance from trn_historicaldata a " & _
                " left join mst_city b on a.city_id=b.city_id " & _
                " left join mst_state c on a.state_id=c.state_id "
        ds_data = conn.GetDataSet(mssql, "trn_historicaldata")
        result = DataSetToJSON(ds_data)
        conn.CloseConn()
        Return result
    End Function
    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=False)> _
    Public Function insert(ByVal state As String, ByVal city As String, ByVal station As String, ByVal from_date As Date, ByVal predicted As String, ByVal actual As String, ByVal variance As String)
        conn.OpenConn()
        Dim mnresult As Integer
        Dim result As String = "Failure"
        mssql = "select historicaldata_id from trn_historicaldata where station_code='" & station & "' and trn_date='" & from_date.ToString("yyyy-MM-dd") & "'"
        objodbcdatareader = conn.GetDataReader(mssql)
        If objodbcdatareader.HasRows = True Then
            mssql = "update trn_historicaldata set actual_speed='" & actual & "', vairance='" & variance & "' " & _
                    " where historicaldata_id='" & objodbcdatareader.Item("historicaldata_id") & "'"
            mnresult = conn.ExecuteNonQuerySQL(mssql)
            If mnresult = 1 Then
                result = "Data Updated Successfully"
            End If
        Else
            mssql = "insert into trn_historicaldata (" & _
                " city_id, state_id, station_code, trn_date, predicted_speed, actual_speed, vairance ) " & _
                " values ( " & _
                "'" & city & "'," & _
                "'" & state & "'," & _
                "'" & station & "'," & _
                "'" & from_date.ToString("yyyy-MM-dd") & "'," & _
                "'" & predicted & "'," & _
                  "'" & actual & "'," & _
                    "'" & variance & "')"
            mnresult = conn.ExecuteNonQuerySQL(mssql)
            If mnresult = 1 Then
                result = "Data Inserted Successfully"
            End If
        End If
        objodbcdatareader.Close()
        

        Return result
    End Function
    Function DataSetToJSON(ByVal ds As DataSet) As String
        Dim dict As New Dictionary(Of String, Object)

        For Each dt As DataTable In ds.Tables
            Dim arr(dt.Rows.Count) As Object
            'dt.Columns.Remove("corporate_user_gid")
            For i As Integer = 0 To dt.Rows.Count - 1

                arr(i) = dt.Rows(i).ItemArray
            Next

            dict.Add(dt.TableName, arr)
        Next

        Dim json As New JavaScriptSerializer
        Return json.Serialize(dict)

    End Function
    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=False)> _
    Public Function getstationcode(ByVal city_id As String, ByVal need_date As Date)
        Dim station_code, predicted_speed As String
        Dim data As String
        Dim dt_table As New DataTable("details")
        dt_table.Columns.Add("station", GetType(System.String))
        dt_table.Columns.Add("predicted", GetType(System.String))
        conn.OpenConn()
        mssql = "select station_code from mst_city where city_id='" & city_id & "'"
        station_code = conn.GetExecuteScalar(mssql)
        mssql = "select ifnull(predicted_speed,0) as predicted_speed from trn_historicaldata where station_code='" & station_code & "' and trn_date='" & need_date.ToString("yyyy-MM-dd") & "'"
        predicted_speed = conn.GetExecuteScalar(mssql)
        If IsNothing(predicted_speed) Then
            predicted_speed = 0
        End If
        conn.CloseConn()
        dt_table.Rows.Add(station_code, predicted_speed)
        data = DataTable2JSON(dt_table)
        Return data
    End Function
    <WebMethod(Enablesession:=True), ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=True)> _
    Public Function putpredicted(ByVal station_code As String, ByVal air_speed As Integer)
        conn.OpenConn()
        Dim mnresult As Integer
        Dim result As String = "Failure"
        mssql = "select historicaldata_id from trn_historicaldata where station_code='" & station_code & "' and trn_date='" & Now.ToString("yyyy-MM-dd") & "'"
        objodbcdatareader = conn.GetDataReader(mssql)
        If objodbcdatareader.HasRows = True Then
            mssql = "update trn_historicaldata set predicted_speed='" & air_speed & "' " & _
                    " where historicaldata_id='" & objodbcdatareader.Item("historicaldata_id") & "'"
            mnresult = conn.ExecuteNonQuerySQL(mssql)
            If mnresult = 1 Then
                result = "Success"
            End If
        Else
            mssql = "select city_id, state_id from mst_city where station_code='" & station_code & "'"
            objodbcdatareader2 = conn.GetDataReader(mssql)
            If objodbcdatareader2.HasRows = True Then
                objodbcdatareader2.Read()
                mssql = "insert into trn_historicaldata " & _
                        " ( city_id, state_id, station_code, trn_date, predicted_speed) " & _
                        " values ( " & _
                        "'" & objodbcdatareader2.Item("city_id") & "'," & _
                            "'" & objodbcdatareader2.Item("state_id") & "'," & _
                              "'" & station_code & "'," & _
                                 "'" & Now.ToString("yyyy-MM-dd") & "'," & _
                                    "'" & air_speed & "')"
                mnresult = conn.ExecuteNonQuerySQL(mssql)
                If mnresult = 1 Then
                    result = "Success"
                End If

            End If
            objodbcdatareader2.Close()
        End If

        objodbcdatareader.Close()

        Dim json As New JavaScriptSerializer
        Return json.Serialize(result)
      
    End Function
    Public Function DataTable2JSON(ByVal dt As DataTable) As String
        Dim RowList As New List(Of [Object])()
        For Each dr As DataRow In dt.Rows
            Dim ColList As New Dictionary(Of [Object], [Object])()
            For Each dc As DataColumn In dt.Columns
                Dim t As String = DirectCast(If((String.Empty = dr(dc).ToString()), Nothing, dr(dc).ToString()), String)
                ColList.Add(dc.ColumnName, t)
            Next
            RowList.Add(ColList)
        Next
        Dim js As New JavaScriptSerializer()
        Dim JSON As String = js.Serialize(RowList)
        Return JSON
    End Function
End Class