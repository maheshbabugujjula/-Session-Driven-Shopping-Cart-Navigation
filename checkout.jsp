<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     * ============================================================
     * ELECTROMART - CHECKOUT PAGE
     * ============================================================
     *
     * JSP IMPLICIT OBJECTS USED:
     *
     * session     -> current user's cart and username
     * request     -> receives checkout POST request
     * application -> store-wide total items sold and orders
     *
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
    // GET USER INFORMATION
    // ------------------------------------------------------------

    String username =
        (String) session.getAttribute("username");


    // ------------------------------------------------------------
    // GET CART FROM SESSION
    // ------------------------------------------------------------

    java.util.List<String> cart =
        (java.util.List<String>)
        session.getAttribute("cart");


    if (cart == null) {

        cart =
            new java.util.ArrayList<String>();

        session.setAttribute(
            "cart",
            cart
        );
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
    // CHECKOUT PROCESS
    // ------------------------------------------------------------

    String method =
        request.getMethod();


    Boolean checkoutProcessed =
        (Boolean)
        session.getAttribute("checkoutProcessed");


    /*
     * Only process the order when:
     *
     * 1. Request is POST
     * 2. Cart is not empty
     * 3. This order has not already been processed
     */

    if ("POST".equalsIgnoreCase(method)
        && !cart.isEmpty()
        && (checkoutProcessed == null
            || !checkoutProcessed)) {


        // --------------------------------------------------------
        // CALCULATE ORDER TOTAL
        // --------------------------------------------------------

        double orderTotal = 0.0;


        int purchasedItems =
            cart.size();


        for (String item : cart) {

            Double price =
                prices.get(item);


            if (price != null) {

                orderTotal += price;
            }
        }


        // --------------------------------------------------------
        // DELIVERY
        // --------------------------------------------------------

        if (orderTotal > 0 &&
            orderTotal < 50000) {

            orderTotal += 499.0;
        }


        // --------------------------------------------------------
        // APPLICATION SCOPE
        // --------------------------------------------------------

        /*
         * application is shared by ALL users of this
         * web application.
         *
         * Therefore totalSold and totalOrders are
         * store-wide values.
         */


        synchronized (application) {


            // --------------------------------------------
            // GET CURRENT TOTAL ITEMS SOLD
            // --------------------------------------------

            Integer currentTotalSold =
                (Integer)
                application.getAttribute(
                    "totalSold"
                );


            if (currentTotalSold == null) {

                currentTotalSold = 0;
            }


            // --------------------------------------------
            // UPDATE TOTAL ITEMS SOLD
            // --------------------------------------------

            int newTotalSold =
                currentTotalSold
                + purchasedItems;


            application.setAttribute(
                "totalSold",
                newTotalSold
            );


            // --------------------------------------------
            // GET CURRENT TOTAL ORDERS
            // --------------------------------------------

            Integer currentTotalOrders =
                (Integer)
                application.getAttribute(
                    "totalOrders"
                );


            if (currentTotalOrders == null) {

                currentTotalOrders = 0;
            }


            // --------------------------------------------
            // UPDATE TOTAL ORDERS
            // --------------------------------------------

            int newTotalOrders =
                currentTotalOrders + 1;


            application.setAttribute(
                "totalOrders",
                newTotalOrders
            );


            // --------------------------------------------
            // STORE ORDER INFORMATION IN SESSION
            // --------------------------------------------

            String orderId =
                "EM"
                + System.currentTimeMillis();


            session.setAttribute(
                "lastOrderId",
                orderId
            );


            session.setAttribute(
                "lastPurchasedItems",
                purchasedItems
            );


            session.setAttribute(
                "lastOrderTotal",
                orderTotal
            );


            // --------------------------------------------
            // MARK CHECKOUT AS PROCESSED
            // --------------------------------------------

            session.setAttribute(
                "checkoutProcessed",
                Boolean.TRUE
            );


            // --------------------------------------------
            // CLEAR USER CART
            // --------------------------------------------

            session.removeAttribute("cart");


            // Create a new empty cart after checkout

            java.util.List<String> newCart =
                new java.util.ArrayList<String>();


            session.setAttribute(
                "cart",
                newCart
            );
        }
    }


    // ------------------------------------------------------------
    // GET LAST ORDER INFORMATION
    // ------------------------------------------------------------

    String orderId =
        (String)
        session.getAttribute("lastOrderId");


    Integer purchasedItems =
        (Integer)
        session.getAttribute("lastPurchasedItems");


    Double orderTotal =
        (Double)
        session.getAttribute("lastOrderTotal");


    // ------------------------------------------------------------
    // GET APPLICATION-WIDE STATISTICS
    // ------------------------------------------------------------

    Integer totalSold =
        (Integer)
        application.getAttribute("totalSold");


    Integer totalOrders =
        (Integer)
        application.getAttribute("totalOrders");


    if (totalSold == null) {

        totalSold = 0;
    }


    if (totalOrders == null) {

        totalOrders = 0;
    }


    // ------------------------------------------------------------
    // DEFAULT VALUES
    // ------------------------------------------------------------

    if (purchasedItems == null) {

        purchasedItems = 0;
    }


    if (orderTotal == null) {

        orderTotal = 0.0;
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ElectroMart - Checkout
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
                        0
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
         MAIN CHECKOUT CONTENT
         ======================================================== -->

    <main class="container">


        <section class="checkout-page">


            <!-- =================================================
                 SUCCESS MESSAGE
                 ================================================= -->

            <div class="checkout-success">


                <div class="success-icon">
                    ✓
                </div>


                <h1>
                    Order Confirmed!
                </h1>


                <p>

                    Thank you,

                    <strong>
                        <%= username %>
                    </strong>

                    !

                </p>


                <p>
                    Your ElectroMart order has been successfully
                    placed.
                </p>


            </div>


            <!-- =================================================
                 ORDER DETAILS
                 ================================================= -->

            <div class="order-details">


                <h2>
                    Order Details
                </h2>


                <div class="summary-row">


                    <span>
                        Order ID
                    </span>


                    <strong>

                        <%= orderId == null
                            ? "N/A"
                            : orderId %>

                    </strong>


                </div>


                <div class="summary-row">


                    <span>
                        Customer
                    </span>


                    <strong>

                        <%= username %>

                    </strong>


                </div>


                <div class="summary-row">


                    <span>
                        Items Purchased
                    </span>


                    <strong>

                        <%= purchasedItems %>

                    </strong>


                </div>


                <div class="summary-row">


                    <span>
                        Payment Status
                    </span>


                    <strong>
                        Paid
                    </strong>


                </div>


                <hr>


                <div class="summary-total">


                    <span>
                        Order Total
                    </span>


                    <strong>

                        ₹<%= String.format(
                            "%,.0f",
                            orderTotal
                        ) %>

                    </strong>


                </div>


            </div>


            <!-- =================================================
                 APPLICATION SCOPE STATISTICS
                 ================================================= -->

            <div class="store-stats">


                <h2>
                    ElectroMart Store Statistics
                </h2>


                <p class="stats-description">

                    These values are maintained using the
                    <strong>application</strong>
                    implicit object and are shared across
                    all user sessions.

                </p>


                <div class="stats-grid">


                    <div class="stat-card">


                        <div class="stat-number">

                            <%= totalSold %>

                        </div>


                        <div class="stat-label">

                            Total Items Sold

                        </div>


                    </div>


                    <div class="stat-card">


                        <div class="stat-number">

                            <%= totalOrders %>

                        </div>


                        <div class="stat-label">

                            Total Orders

                        </div>


                    </div>


                </div>


            </div>


            <!-- =================================================
                 NAVIGATION
                 ================================================= -->

            <div class="checkout-actions">


                <a
                    href="catalog.jsp"
                    class="checkout-btn"
                >

                    Continue Shopping

                </a>


            </div>


        </section>


    </main>


</body>

</html>