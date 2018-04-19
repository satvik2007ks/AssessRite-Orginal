<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="VMP_1._0.AccessDenied" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AssessRite</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="Content/style.css" />
</head>
<body>
     <header class="site-header">
        <div class="primary-header">
            <div class="container">
                <a href="index.html" id="branding">
                    <img src="Images/AssessRiteLogo.Full.png" alt="AssessRite" />
                </a>
                <!-- #branding -->
            </div>
        </div>
    </header>
    <form id="form1" runat="server">
     <div style="margin-top:15%;">
            <div style="text-align:center;color:red;"><h1>ACCESS DENIED</h1></div>
            <div style="text-align:center;">
                <img style="width:12%;" src="images/abort-146072_960_720.png" /></div>
            <div style="text-align:center;"><h3>If you think you are authorised and you are getting this error message please contact admin for more details or <a href="login.aspx">Login </a> again</h3></div>
        </div>
    </form>
</body>
</html>