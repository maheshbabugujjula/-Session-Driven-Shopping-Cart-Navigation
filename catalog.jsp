<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    /*
     * ============================================================
     * ELECTROMART - CATALOG PAGE
     * ============================================================
     *
     * JSP IMPLICIT OBJECTS:
     *
     * session -> authentication and shopping cart
     * request -> selected product
     *
     * CONTROL TRANSFER:
     *
     * <jsp:forward> -> sends unauthenticated users to login.jsp
     *
     * ============================================================
     */


    // ------------------------------------------------------------
    // AUTHENTICATION CHECK
    // ------------------------------------------------------------

    Boolean authenticated =
        (Boolean) session.getAttribute("authenticated");


    /*
     * If the user is not authenticated,
     * transfer control to login.jsp.
     */

    if (authenticated == null || !authenticated) {
%>

<jsp:forward page="login.jsp"/>

<%
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
     * Create a cart if it does not exist.
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
    // GET PRODUCT FROM REQUEST
    // ------------------------------------------------------------

    String selectedProduct =
        request.getParameter("product");


    /*
     * request.getParameter("product")
     *
     * receives the product selected by the user.
     */

    if (selectedProduct != null &&
        !selectedProduct.trim().isEmpty()) {


        // Add product to SESSION cart

        cart.add(selectedProduct);


        // Save updated cart

        session.setAttribute(
            "cart",
            cart
        );


        /*
         * Allow another checkout after adding a new product.
         */

        session.setAttribute(
            "checkoutProcessed",
            Boolean.FALSE
        );


        /*
         * Redirect after adding product.
         *
         * This prevents duplicate additions when
         * the browser is refreshed.
         */

        response.sendRedirect("catalog.jsp");

        return;
    }


    // ------------------------------------------------------------
    // PRODUCT DATA
    // ------------------------------------------------------------

    String[] productNames = {

        "iPhone 17 Pro",
        "Samsung Galaxy S26 Ultra",
        "MacBook Pro",
        "Dell XPS 15",
        "Sony WH-1000XM6",
        "AirPods Pro",
        "Apple Watch Series 11",
        "Sony Alpha Camera",
        "PlayStation 5",
        "4K Smart TV",
        "1TB External SSD",
        "JBL Bluetooth Speaker"
    };


    String[] productPrices = {

        "₹1,34,900",
        "₹1,29,999",
        "₹1,69,900",
        "₹1,45,000",
        "₹39,990",
        "₹24,900",
        "₹46,900",
        "₹1,19,990",
        "₹54,990",
        "₹54,999",
        "₹8,499",
        "₹9,999"
    };


    String[] productImages = {

        "images/iphone.jpg",
        "images/samsung.jpg",
        "images/macbook.jpg",
        "images/dell.jpg",
        "images/sony-headphones.jpg",
        "images/airpods.jpg",
        "images/apple-watch.jpg",
        "images/sony-camera.jpg",
        "images/ps5.jpg",
        "images/smart-tv.jpg",
        "images/ssd.jpg",
        "images/jbl.jpg"
    };


    String[] productDescriptions = {

        "Professional smartphone with advanced camera and performance.",
        "Premium flagship smartphone with powerful performance.",
        "High-performance laptop for professionals and creators.",
        "Premium Windows laptop with a sleek modern design.",
        "Premium wireless noise-cancelling headphones.",
        "Wireless earbuds with active noise cancellation.",
        "Advanced smartwatch for health and everyday connectivity.",
        "Professional mirrorless camera for photography.",
        "Next-generation gaming console with immersive graphics.",
        "Large 4K smart television for home entertainment.",
        "High-speed 1TB portable external SSD.",
        "Portable Bluetooth speaker with powerful sound."
    };

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ElectroMart - Products
    </title>

    <link rel="stylesheet"
          href="css/style.css">

</head>


<body>


    <!-- ========================================================
         COMMON HEADER
         REQUIRED JSP INCLUDE
         ======================================================== -->

    <jsp:include page="header.jsp"/>


    <main class="container">


        <!-- ====================================================
             HERO
             ==================================================== -->

        <section class="hero">

            <div class="hero-content">

                <p class="hero-label">
                    NEW ARRIVALS
                </p>


                <h1>
                    Technology That
                    <br>
                    Moves You Forward
                </h1>


                <p>
                    Discover the latest smartphones, laptops,
                    gaming devices, cameras and accessories.
                </p>


                <a
                    href="#products"
                    class="hero-btn"
                >
                    Explore Products
                </a>

            </div>

        </section>


        <!-- ====================================================
             WELCOME
             ==================================================== -->

        <section class="welcome">

            <h2>
                Welcome, <%= username %>!
            </h2>


            <p>
                Choose your favorite electronics and add them
                to your shopping cart.
            </p>

        </section>


        <!-- ====================================================
             PRODUCTS
             ==================================================== -->

        <section
            id="products"
            class="products-section"
        >


            <div class="section-heading">


                <div>

                    <h2>
                        Featured Electronics
                    </h2>


                    <p>
                        Premium technology at great prices
                    </p>

                </div>


                <div class="product-count">

                    <%= productNames.length %>
                    Products

                </div>


            </div>


            <div class="product-grid">


<%

    for (int i = 0;
         i < productNames.length;
         i++) {

%>


                <div class="product-card">


                    <!-- PRODUCT IMAGE -->

                    <div class="product-image">

                        <img
                            src="<%= productImages[i] %>"
                            alt="<%= productNames[i] %>"
                        >

                    </div>


                    <!-- PRODUCT INFORMATION -->

                    <div class="product-info">


                        <h3>
                            <%= productNames[i] %>
                        </h3>


                        <p class="product-description">

                            <%= productDescriptions[i] %>

                        </p>


                        <div class="product-bottom">


                            <span class="product-price">

                                <%= productPrices[i] %>

                            </span>


                            <!-- ADD TO CART -->

                            <form
                                method="post"
                                action="catalog.jsp"
                            >

                                <button
                                    type="submit"
                                    name="product"
                                    value="<%= productNames[i] %>"
                                    class="add-cart-btn"
                                >

                                    Add to Cart

                                </button>

                            </form>


                        </div>

                    </div>


                </div>


<%

    }

%>


            </div>


        </section>


        <!-- ====================================================
             SESSION INFORMATION
             ==================================================== -->

        <section class="session-info">


            <h3>
                Shopping Session
            </h3>


            <p>

                Items currently in your cart:

                <strong>
                    <%= cart.size() %>
                </strong>

            </p>


            <p>

                Your cart is stored using the
                <strong>session</strong>
                implicit object.

            </p>


        </section>


    </main>


</body>

</html>