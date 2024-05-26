<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 5/25/2024
  Time: 12:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- bootstrap 5 stylesheet -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.1/css/bootstrap.min.css"/>
    <!-- fontawesome 6 stylesheet -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>


    <style>
        body{
            background-color: #ebecf0;
        }
        .otp-letter-input{
            max-width: 100%;
            height: 90px;
            border: 1px solid #000000;
            border-radius:10px;
            color: #000000;
            font-size: 60px;
            text-align: center;
            font-weight: bold;
        }
        .btn{
            height: 50px;
        }
        .btn-success {
            background: #D10024;
        }
        .fa-envelope-circle-check{
            color:  #D10024;
        }

    </style>
</head>
<body>
<div class="container p-5">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 mt-3">
            <div class="bg-white p-5 rounded-3 shadow-sm border">
                <form method="post" action="verify" id="otpForm">
                    <p class="text-center text-success" style="font-size: 5.5rem;"><i class="fa-solid fa-envelope-circle-check"></i></p>
                    <p class="text-center text-center h5 ">Xin vui lòng kiểm tra email của bạn</p>
                    <p class="text-muted text-center">Chúng tôi đã gửi mã xác thự đến email ${user.email}</p>
                    <div class="row pt-4 pb-2">
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 1)" onkeyup="moveToPreviousInput(event, 0)">
                        </div>
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 2)" onkeyup="moveToPreviousInput(event, 1)">
                        </div>
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 3)" onkeyup="moveToPreviousInput(event, 2)">
                        </div>
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 4)" onkeyup="moveToPreviousInput(event, 3)">
                        </div>
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 5)" onkeyup="moveToPreviousInput(event, 4)">
                        </div>
                        <div class="col-2">
                            <input class="otp-letter-input" name="opt" required type="text" maxlength="1" oninput="moveToNextInput(this, 6)" onkeyup="moveToPreviousInput(event, 5)">
                        </div>

                    </div>
                    <c:if test="${alert != null}">
                        <p class="text-danger font-italic text-center">${alert}</p>
                    </c:if>
                    <p class="text-muted text-center">Không nhận được email? <a href="verify?index=1" class="text-success">Gửi lại.</a></p>

                    <div class="row pt-5">
                        <div class="col-6 offset-3">
                            <button class="btn btn-success w-100" onclick="submitForm(event)">Xác nhận</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function moveToNextInput(input, nextInputIndex) {
        if (input.value.length === 1) {
            var nextInput = document.getElementsByClassName("otp-letter-input")[nextInputIndex];
            if (nextInput) {
                nextInput.focus();
            }
        }
    }

    function moveToPreviousInput(event, previousInputIndex) {
        console.log("Pressed key:", event.key);
        var inputFields = document.getElementsByClassName("otp-letter-input");
        if (event.key === "Backspace") {
            var previousInput = inputFields[previousInputIndex - 1];
            if (previousInput) {
                previousInput.focus();
            }
        }
    }

    function submitForm(event) {
        event.preventDefault();  // Prevent the default form submission
        var form = document.getElementById("otpForm");
        // Add any additional validation or processing logic here
        form.submit();  // Submit the form
    }
</script>
</body>
</html>
