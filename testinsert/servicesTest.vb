Imports System

Imports Microsoft.VisualStudio.TestTools.UnitTesting.Web

Imports Microsoft.VisualStudio.TestTools.UnitTesting

Imports Demo_Application



'''<summary>
'''This is a test class for servicesTest and is intended
'''to contain all servicesTest Unit Tests
'''</summary>
<TestClass()> _
Public Class servicesTest


    Private testContextInstance As TestContext

    '''<summary>
    '''Gets or sets the test context which provides
    '''information about and functionality for the current test run.
    '''</summary>
    Public Property TestContext() As TestContext
        Get
            Return testContextInstance
        End Get
        Set(ByVal value As TestContext)
            testContextInstance = Value
        End Set
    End Property

#Region "Additional test attributes"
    '
    'You can use the following additional attributes as you write your tests:
    '
    'Use ClassInitialize to run code before running the first test in the class
    '<ClassInitialize()>  _
    'Public Shared Sub MyClassInitialize(ByVal testContext As TestContext)
    'End Sub
    '
    'Use ClassCleanup to run code after all tests in a class have run
    '<ClassCleanup()>  _
    'Public Shared Sub MyClassCleanup()
    'End Sub
    '
    'Use TestInitialize to run code before running each test
    '<TestInitialize()>  _
    'Public Sub MyTestInitialize()
    'End Sub
    '
    'Use TestCleanup to run code after each test has run
    '<TestCleanup()>  _
    'Public Sub MyTestCleanup()
    'End Sub
    '
#End Region


    'TODO: Ensure that the UrlToTest attribute specifies a URL to an ASP.NET page (for example,
    ' http://.../Default.aspx). This is necessary for the unit test to be executed on the web server,
    ' whether you are testing a page, web service, or a WCF service.
    '''<summary>
    '''A test for insert
    '''</summary>
    <TestMethod(), _
     HostType("ASP.NET"), _
     AspNetDevelopmentServerHost("F:\Web\Demo_Application\Demo_Application", "/"), _
     UrlToTest("http://localhost:60072/")> _
    Public Sub insertTest()
        Dim target As services = New services() ' TODO: Initialize to an appropriate value
        Dim state As String = "5" ' TODO: Initialize to an appropriate value
        Dim city As String = "10" ' TODO: Initialize to an appropriate value
        Dim station As String = "AS-GU-01" ' TODO: Initialize to an appropriate value
        Dim from_date As DateTime = Now.Date ' TODO: Initialize to an appropriate value
        Dim predicted As String = "10" ' TODO: Initialize to an appropriate value
        Dim actual As String = "8" ' TODO: Initialize to an appropriate value
        Dim variance As String = "2" ' TODO: Initialize to an appropriate value
        Dim expected As Object = "Data Inserted Successfully" ' TODO: Initialize to an appropriate value
        Dim actual1 As Object
        actual1 = target.insert(state, city, station, from_date, predicted, actual, variance)
        Assert.AreEqual(expected, actual1)
        Assert.Inconclusive("Verify the correctness of this test method.")
    End Sub
End Class
