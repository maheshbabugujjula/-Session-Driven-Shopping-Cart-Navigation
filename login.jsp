<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     * ============================================================
     * ELECTROMART - LOGIN PAGE
     * ============================================================
     *
     * JSP IMPLICIT OBJECTS:
     *
     * request     -> receives username and password
     * session     -> stores authentication and cart
     *
     * CONTROL TRANSFER:
     *
     * <jsp:forward> -> sends authenticated user to catalog.jsp
     * ============================================================
     */


    // ------------------------------------------------------------
    // CHECK LOGIN REQUEST
    // ------------------------------------------------------------

    String username =
        request.getParameter("username");

    String password =
        request.getParameter("password");


    /*
     * If username and password are submitted,
     * process the login.
     */

    if (username != null &&
        password != null &&
        !username.trim().isEmpty() &&
        !password.trim().isEmpty()) {


        // --------------------------------------------------------
        // STORE AUTHENTICATION INFORMATION IN SESSION
        // --------------------------------------------------------

        session.setAttribute(
            "username",
            username
        );


        session.setAttribute(
            "authenticated",
            Boolean.TRUE
        );


        // --------------------------------------------------------
        // CREATE NEW SHOPPING CART
        // --------------------------------------------------------

        java.util.List<String> cart =
            new java.util.ArrayList<String>();


        session.setAttribute(
            "cart",
            cart
        );


        // --------------------------------------------------------
        // RESET CHECKOUT STATUS
        // --------------------------------------------------------

        session.setAttribute(
            "checkoutProcessed",
            Boolean.FALSE
        );


        /*
         * ========================================================
         * REQUIRED CONTROL TRANSFER
         * ========================================================
         *
         * After successful authentication,
         * forward the request to catalog.jsp.
         */

%>

<jsp:forward page="catalog.jsp"/>

<%
        return;
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ElectroMart - Login
    </title>

    <link rel="stylesheet"
          href="css/style.css">

</head>


<body>


    <div class="login-page">


        <div class="login-card">


            <div class="login-logo">
                ⚡
            </div>


            <h1>
                ElectroMart
            </h1>


            <p class="login-subtitle">
                Your Complete Electronics Store
            </p>


            <form
                method="post"
                action="login.jsp"
            >


                <div class="form-group">

                    <label for="username">
                        Username
                    </label>


                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username"
                        required
                    >

                </div>


                <div class="form-group">

                    <label for="password">
                        Password
                    </label>


                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required
                    >

                </div>


                <button
                    type="submit"
                    class="login-btn"
                >

                    Login to ElectroMart

                </button>


            </form>


            <p class="login-note">

                Demo application — use any username
                and password.

            </p>


        </div>


    </div>


</body>

</html>