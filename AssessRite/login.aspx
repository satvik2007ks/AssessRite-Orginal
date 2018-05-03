<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AssessRite.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>AssessRite</title>
    <!-- Bootstrap core CSS-->
    <link href="Scripts/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Custom fonts for this template-->
    <link href="Scripts/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet" />
    <style>
        .aligncenter{
            text-align: center;
        }
    </style>
</head>
<body class="bg-dark">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
        <a class="navbar-brand" href="index.html">
            <img src="Images/AssessRiteLogo.Full.png" />
        </a>
        <%-- <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>--%>
    </nav>

    <div class="container">
        <div class="card card-login mx-auto mt-5" style="margin-top: 6rem !important;">
            <div class="card-header">Login</div>
            <div class="card-body">
                <form id="form1" runat="server">

                    <div class="form-group">
                        <label for="exampleInputEmail1">Username</label>
                        <%--<input class="form-control" id="exampleInputEmail1" type="email" aria-describedby="emailHelp" placeholder="Enter email">--%>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter Username" MaxLength="20"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <%--<input class="form-control" id="exampleInputPassword1" type="password" placeholder="Password">--%>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" MaxLength="20"></asp:TextBox>

                    </div>
                    <!--<div class="form-group">
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox"> Remember Password</label>
            </div>
          </div>-->
                    <%--<a class="btn btn-primary btn-block" href="index.html">Login</a>--%>
                    <div class="row aligncenter" runat="server" id="divError" style="display: none;">
                        <asp:Label ID="lblError" runat="server" Style="color: red;" Text="Invalid UserName or Password"></asp:Label>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block" OnClick="btnLogin_Click" ValidationGroup="login" />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="UserName Required*" Style="color: red; margin-left: 28%;" ControlToValidate="txtUserName" ValidationGroup="login"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password Required*" Style="color: red; margin-left: 28%;" ControlToValidate="txtPassword" ValidationGroup="login"></asp:RequiredFieldValidator>

                </form>
                <!--<div class="text-center">
          <a class="d-block small mt-3" href="register.html">Register an Account</a>
          <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
        </div>-->
            </div>
        </div>
    </div>

    <footer class="sticky-footer" style="width: 100% !important; background-color: #343A40; color: white;">
        <div class="container">
            <div class="text-center">
                <small>Copyright © AssessRite 2017</small>
            </div>
        </div>
    </footer>
    <!-- Bootstrap core JavaScript-->
    <script src="Scripts/vendor/jquery/jquery.min.js"></script>
    <script src="Scripts/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="Scripts/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
