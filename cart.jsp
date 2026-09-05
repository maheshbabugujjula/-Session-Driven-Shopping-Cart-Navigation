<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     * ============================================================
     * ELECTROMART - SHOPPING CART
     * ============================================================
     *
     * IMPLICIT JSP OBJECTS USED:
     *
     * session -> stores user's shopping cart
     * request -> receives remove-product request
     *
     * Authentication control is handled with response.sendRedirect
     * here. The required <jsp:forward> is already implemented in
     * login.jsp and catalog.jsp.
     * ============================================================
     */


    // ------------------------------------------------------------
    // AUTHENTICATION CHECK
    // ------------------------------------------------------------

    Boolean authenticated =
        (Boolean) session.getAttribute("authenticated");


    if (authenticated == null || !authenticated) {

        response.sendRedirect("login.jsp");

        return;
    }


    // ------------------------------------------------------------
    // GET USERNAME FROM SESSION
    // ------------------------------------------------------------

    String username =
        (String) session.getAttribute("username");


    // ------------------------------------------------------------
    // GET CART FROM SESSION
    // ------------------------------------------------------------

    java.util.List<String> cart =
        (java.util.List<String>)
        session.getAttribute("cart");


    /*
     * Create cart if it does not exist.
     */

    if (cart == null) {

        cart =
            new java.util.ArrayList<String>();

        session.setAttribute(
            "cart",
            cart
        );
    }


    // ------------------------------------------------------------
    // REMOVE PRODUCT
    // ------------------------------------------------------------

    String removeProduct =
        request.getParameter("remove");


    if (removeProduct != null &&
        !removeProduct.trim().isEmpty()) {


        cart.remove(removeProduct);


        session.setAttribute(
            "cart",
            cart
        );


        response.sendRedirect("cart.jsp");

        return;
    }


    // ------------------------------------------------------------
    // PRODUCT PRICES
    // ------------------------------------------------------------

    java.util.Map<String, Double> prices =
        new java.util.HashMap<String, Double>();


    prices.put("iPhone 17 Pro", 134900.0);

    prices.put("Samsung Galaxy S26 Ultra", 129999.0);

    prices.put("MacBook Pro", 169900.0);

    prices.put("Dell XPS 15", 145000.0);

    prices.put("Sony WH-1000XM6", 39990.0);

    prices.put("AirPods Pro", 24900.0);

    prices.put("Apple Watch Series 11", 46900.0);

    prices.put("Sony Alpha Camera", 119990.0);

    prices.put("PlayStation 5", 54990.0);

    prices.put("4K Smart TV", 54999.0);

    prices.put("1TB External SSD", 8499.0);

    prices.put("JBL Bluetooth Speaker", 9999.0);


    // ------------------------------------------------------------
    // PRODUCT IMAGES
    // ------------------------------------------------------------

    java.util.Map<String, String> images =
        new java.util.HashMap<String, String>();


    images.put(
        "iPhone 17 Pro",
        "images/iphone.jpg"
    );

    images.put(
        "Samsung Galaxy S26 Ultra",
        "images/samsung.jpg"
    );

    images.put(
        "MacBook Pro",
        "images/macbook.jpg"
    );

    images.put(
        "Dell XPS 15",
        "images/dell.jpg"
    );

    images.put(
        "Sony WH-1000XM6",
        "images/sony-headphones.jpg"
    );

    images.put(
        "AirPods Pro",
        "images/airpods.jpg"
    );

    images.put(
        "Apple Watch Series 11",
        "images/apple-watch.jpg"
    );

    images.put(
        "Sony Alpha Camera",
        "images/sony-camera.jpg"
    );

    images.put(
        "PlayStation 5",
        "images/ps5.jpg"
    );

    images.put(
        "4K Smart TV",
        "images/smart-tv.jpg"
    );

    images.put(
        "1TB External SSD",
        "images/ssd.jpg"
    );

    images.put(
        "JBL Bluetooth Speaker",
        "images/jbl.jpg"
    );


    // ------------------------------------------------------------
    // CALCULATE SUBTOTAL
    // ------------------------------------------------------------

    double subtotal = 0.0;


    for (String item : cart) {

        Double price =
            prices.get(item);


        if (price != null) {

            subtotal += price;
        }
    }


    // ------------------------------------------------------------
    // DELIVERY CHARGE
    // ------------------------------------------------------------

    double delivery = 0.0;


    if (subtotal > 0 && subtotal < 50000) {

        delivery = 499.0;
    }


    // ------------------------------------------------------------
    // TOTAL
    // ------------------------------------------------------------

    double total =
        subtotal + delivery;


    // ------------------------------------------------------------
    // CART COUNT
    // ------------------------------------------------------------

    int cartCount =
        cart.size();

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ElectroMart - Shopping Cart
    </title>

    <link rel="stylesheet"
          href="css/style.css">

</head>


<body>


    <!-- ========================================================
         NAVIGATION BAR
         ======================================================== -->

    <header class="navbar">

        <div class="nav-container">


            <a
                href="catalog.jsp"
                class="brand"
            >
                ElectroMart
            </a>


            <nav>


                <a href="catalog.jsp">
                    Products
                </a>


                <a href="cart.jsp">

                    Cart

                    <span class="badge">

                        <%= cartCount %>

                    </span>

                </a>


            </nav>


            <div class="user">

                User:

                <%= username == null
                    ? "Guest"
                    : username %>

            </div>


        </div>

    </header>


    <!-- ========================================================
         MAIN CONTENT
         ======================================================== -->

    <main class="container">


        <!-- ====================================================
             CART HEADING
             ==================================================== -->

        <section class="cart-heading-box">


            <div>


                <h1>
                    Shopping Cart
                </h1>


                <span>

                    <%= cartCount %>
                    item(s) in your cart

                </span>


            </div>


            <a
                href="catalog.jsp"
                class="continue-shopping"
            >

                Continue Shopping

            </a>


        </section>


<%

    // ------------------------------------------------------------
    // EMPTY CART
    // ------------------------------------------------------------

    if (cart.isEmpty()) {

%>


        <section class="empty-cart">


            <div class="empty-cart-icon">
                🛒
            </div>


            <h2>
                Your Cart is Empty
            </h2>


            <p>
                You haven't added any products yet.
            </p>


            <a
                href="catalog.jsp"
                class="checkout-btn"
            >

                Browse Products

            </a>


        </section>


<%

    } else {

%>


        <!-- ====================================================
             CART LAYOUT
             ==================================================== -->

        <section class="cart-layout">


            <!-- =================================================
                 CART ITEMS
                 ================================================= -->

            <div class="cart-items">


<%

        for (String item : cart) {


            Double price =
                prices.get(item);


            String image =
                images.get(item);


            if (price == null) {

                price = 0.0;
            }


            if (image == null) {

                image = "images/iphone.jpg";
            }

%>


                <div class="cart-item">


                    <!-- PRODUCT IMAGE -->

                    <div class="cart-item-image">


                        <img
                            src="<%= image %>"
                            alt="<%= item %>"
                        >


                    </div>


                    <!-- PRODUCT DETAILS -->

                    <div class="cart-item-details">


                        <h3>

                            <%= item %>

                        </h3>


                        <p>
                            Electronics
                        </p>


                        <span class="cart-item-price">

                            ₹<%= String.format(
                                "%,.0f",
                                price
                            ) %>

                        </span>


                    </div>


                    <!-- REMOVE BUTTON -->

                    <div class="cart-item-action">


                        <a
                            href="cart.jsp?remove=<%= java.net.URLEncoder.encode(item, "UTF-8") %>"
                            class="remove-btn"
                        >

                            Remove

                        </a>


                    </div>


                </div>


<%

        }

%>


            </div>


            <!-- =================================================
                 ORDER SUMMARY
                 ================================================= -->

            <div class="cart-summary">


                <h2>
                    Order Summary
                </h2>


                <div class="summary-row">


                    <span>
                        Total Items
                    </span>


                    <strong>

                        <%= cartCount %>

                    </strong>


                </div>


                <div class="summary-row">


                    <span>
                        Subtotal
                    </span>


                    <strong>

                        ₹<%= String.format(
                            "%,.0f",
                            subtotal
                        ) %>

                    </strong>


                </div>


                <div class="summary-row">


                    <span>
                        Delivery
                    </span>


                    <strong>


<%

    if (delivery == 0) {

%>

                        FREE

<%

    } else {

%>

                        ₹<%= String.format(
                            "%,.0f",
                            delivery
                        ) %>

<%

    }

%>


                    </strong>


                </div>


                <hr>


                <div class="summary-total">


                    <span>
                        Total
                    </span>


                    <strong>

                        ₹<%= String.format(
                            "%,.0f",
                            total
                        ) %>

                    </strong>


                </div>


                <!-- CHECKOUT -->

                <form
                    method="post"
                    action="checkout.jsp"
                >


                    <button
                        type="submit"
                        class="checkout-btn"
                    >

                        Proceed to Checkout

                    </button>


                </form>


                <a
                    href="catalog.jsp"
                    class="continue-shopping"
                >

                    ← Continue Shopping

                </a>


            </div>


        </section>


        <!-- ====================================================
             SESSION INFORMATION
             ==================================================== -->

        <section class="session-info">


            <h3>
                Session Information
            </h3>


            <p>

                Welcome,

                <strong>
                    <%= username %>
                </strong>

            </p>


            <p>

                Your cart contains

                <strong>
                    <%= cartCount %>
                </strong>

                item(s).

            </p>


            <p>

                The shopping cart is stored using the
                <strong>session</strong>
                implicit object.

            </p>


        </section>


<%

    }

%>


    </main>


</body>

</html>