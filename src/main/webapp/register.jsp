<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/21/2024
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/login.css" rel="stylesheet">

</head>
<body>
<!-- HEADER -->
<header>
    <!-- MAIN HEADER -->
    <div id="header">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <img src="home/./img/logo.png" alt="">
                    </div>
                </div>
                <!-- /LOGO -->
            </div>
            <!-- row -->
        </div>
        <!-- container -->
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->

<section class="form-02-main">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="_lk_de">
                    <div class="form-03-main">
                        <div class="logo">
                            <img src="assets/img/user.png">
                        </div>
                        <div class="form-group">
                            <input type="firstname" name="firstname" class="form-control _ge_de_ol" type="text" placeholder="Insert your First Name" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input type="lastname" name="lastname" class="form-control _ge_de_ol" type="text" placeholder="Insert your Last Name" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input type="email" name="email" class="form-control _ge_de_ol" type="text" placeholder="Insert your Email" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input type="password" name="password" class="form-control _ge_de_ol" type="text" placeholder="Insert your Password" required="" aria-required="true">
                        </div>

                        <div class="form-group">
                            <input type="confirmpassword" name="confirmpassword" class="form-control _ge_de_ol" type="text" placeholder="Confirm your Password" required="" aria-required="true">
                        </div>

                                <a href="Login.jsp">Already have an account?</a>

                        <div class="form-group">
                            <div class="_btn_04">
                                <a href="#">Submit</a>
                            </div>
                        </div>

                        <div class="form-group nm_lk"><p>Or Register With</p></div>

                        <div class="form-group pt-0">
                            <div class="_social_04">
                                <ol>
                                    <li><i class="fa fa-google-plus"></i></li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>