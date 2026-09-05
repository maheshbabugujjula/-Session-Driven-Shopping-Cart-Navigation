<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     * ============================================================
     * ELECTROMART - COMMON HEADER
     * ============================================================
     *
     * This file is included in the main JSP pages using:
     *
     * <jsp:include page="header.jsp"/>
     *
     * JSP IMPLICIT OBJECT USED:
     *
     * session -> retrieves username and cart information
     *
     * ============================================================
     */


    // Get username from SESSION

    String headerUser =
        (String) session.getAttribute("username");


    // Get cart from SESSION

    java.util.List<String> headerCart =
        (java.util.List<String>)
        session.getAttribute("cart");


    // Calculate cart item count

    int headerCartCount = 0;


    if (headerCart != null) {

        headerCartCount =
            headerCart.size();
    }

%>


<header class="navbar">


    <div class="nav-container">


        <!-- ====================================================
             BRAND
             ==================================================== -->

        <a href="catalog.jsp"
           class="brand">

            <span class="brand-icon">
                ⚡
            </span>

            ElectroMart

        </a>


        <!-- ====================================================
             NAVIGATION
             ==================================================== -->

        <nav class="nav-links">


            <a href="catalog.jsp">

                Products

            </a>


            <a href="cart.jsp"
               class="cart-link">

                🛒 Cart

                <span class="badge">

                    <%= headerCartCount %>

                </span>

            </a>


        </nav>


        <!-- ====================================================
             USER INFORMATION
             ==================================================== -->

        <div class="user-info">

            <span class="user-icon">
                👤
            </span>


            <span>

                <%= headerUser == null
                    ? "Guest"
                    : headerUser %>

            </span>

        </div>


    </div>


</header>