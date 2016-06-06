Imports System.Data.Odbc
Imports System.Data
Imports System.IO
Public Class dbconn
    Public gs_ConnDB As OdbcConnection
    Public objCnf As ConfigurationManager
    Dim objODBCDataReader As OdbcDataReader
    Dim lsobjDR As OdbcDataReader
    Public trans As OdbcTransaction
    Dim conparameter As New List(Of String)
    Dim lsConnectionString As String = ""
    Public Sub OpenConn()
        If lsConnectionString = "" Then
            If System.Web.HttpContext.Current.Session IsNot Nothing Then
                Dim lsServer As String = Nothing
                Dim lsDatabase As String = Nothing
                Dim lsUserID As String = Nothing
                Dim lsPassword As String = Nothing
                Dim lsConnectionParameter As String = "pooling=true;Protocol=TCP;Min Pool Size=1;Max Pool Size=5;Connection Lifetime=0;Convert Zero Datetime=True"
                
                lsServer = "localhost"
                lsDatabase = "wind_monitor"
                lsUserID = "root"
                lsPassword = "vision18"
                lsConnectionString = "Driver={MySQL ODBC 3.51 Driver};" & _
                                         "Server=" & lsServer & ";" & _
                                         "Database=" & lsDatabase & ";" & _
                                         "User=" & lsUserID & ";" & _
                                         "Password=" & lsPassword & ";" & _
                                         "option=3;" & lsConnectionParameter
               
            End If
        End If

        gs_ConnDB = New OdbcConnection(lsConnectionString)
        If gs_ConnDB.State <> ConnectionState.Open Then
            Try
                gs_ConnDB.Open()
               
            Catch ex As Exception
                'If HttpContext.Current.Request.Url.Host = "localhost" Or HttpContext.Current.Request.Url.Host Like "1.*.*.*" Then
                '    HttpContext.Current.Session.RemoveAll()
                '    HttpContext.Current.Session.Abandon()
                '    HttpContext.Current.Response.Redirect("http://" & HttpContext.Current.Request.Url.Host & "/EMS" & "/Framework/login.aspx?msgcode=ACCESS_002")
                'Else
                '    HttpContext.Current.Session.RemoveAll()
                '    HttpContext.Current.Session.Abandon()
                '    HttpContext.Current.Response.Redirect("http://" & HttpContext.Current.Request.Url.Host & "/Framework/login.aspx?msgcode=ACCESS_002")
                'End If
            End Try
        End If
    End Sub
    Public Function GetDatatable(ByVal SQL As String) As DataTable
        'This function will Retrieve Data and Return as Dataset together with table name
        Dim lobjDataAdapter As New OdbcDataAdapter(SQL, gs_ConnDB)
        Dim lobjDataTable As New DataTable
        lobjDataAdapter.Fill(lobjDataTable)
        Return lobjDataTable
    End Function

    
   
    Public Function GetDataReader(ByVal SQL As String) As OdbcDataReader
        Dim cmdQuery As New OdbcCommand
        cmdQuery.Connection = gs_ConnDB
        cmdQuery.CommandText = SQL
        cmdQuery.CommandType = CommandType.Text
        lsobjDR = cmdQuery.ExecuteReader
        Return lsobjDR
    End Function
    Public Function GetDataSet(ByVal SQL As String, ByVal tblName As String) As DataSet
        'This function will Retrieve Data and Return as Dataset together with table name
        Dim lobjDataAdapter As New OdbcDataAdapter(SQL, gs_ConnDB)
        Dim lobjDataSet As New DataSet
        lobjDataAdapter.Fill(lobjDataSet, tblName)
        Return lobjDataSet
    End Function

    Public Function ExecuteNonQuerySQL(ByVal SQL As String) As Integer
        Dim mnResult As Integer
        Using cmdQuery = New OdbcCommand
            cmdQuery.Connection = gs_ConnDB
            cmdQuery.CommandText = SQL
            cmdQuery.CommandType = CommandType.Text
            Try
                mnResult = cmdQuery.ExecuteNonQuery
                mnResult = 1
            Catch ex As OdbcException
                mnResult = 0
            End Try
        End Using
        Return mnResult
    End Function

    Public Sub CloseConn()
        gs_ConnDB.Close()
        gs_ConnDB.Dispose()
    End Sub
 
    Public Function GetExecuteScalar(ByVal SQL As String) As String
        Using lobjCommand = New OdbcCommand
            Try
                lobjCommand.Connection = gs_ConnDB
                lobjCommand.CommandText = SQL
                lobjCommand.CommandType = CommandType.Text
                GetExecuteScalar = lobjCommand.ExecuteScalar
                Return GetExecuteScalar
            Catch ex As Exception
                GetExecuteScalar = " "
            End Try
        End Using
    End Function
    
End Class