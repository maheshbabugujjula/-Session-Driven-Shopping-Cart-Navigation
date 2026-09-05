# Session-Driven Shopping Cart Navigation

## Project Overview

**ElectroMart** is a Java JSP-based e-commerce web application developed as part of the **Session-Driven Shopping Cart Navigation** assignment.

The project demonstrates the use of JSP implicit objects:

- `session`
- `request`
- `application`

It also demonstrates JSP control transfer using:

- `<jsp:forward>`
- `<jsp:include>`

The application follows a simple e-commerce flow:

**Login → Catalog → Cart → Checkout

### "Session-Driven Shopping Cart" Navigation

**Core Topics Tested:**  
Implicit JSP Objects (`session`, `request`, `application`) and Control Transfer (`<jsp:forward>`, `<jsp:include>`).

### Task

Create a multi-page e-commerce flow:

**Catalog → Cart → Checkout**

### Interactive Requirements

- Use the `session` implicit object to persist shopping cart items across page updates.
- Use the `application` implicit object to track total store-wide items sold.
- Store-wide statistics must be shared across active user sessions.
- Use `<jsp:forward>` for control transfer based on authentication status.
- Use `<jsp:include>` for reusable page content.

### Deliverable

A mini flow of three main JSP pages demonstrating proper scope management:

**Session vs. Application**

---

## Project Features

### User Authentication

- Login functionality
- Session-based authentication
- Username stored in session
- Authentication status maintained using session

### Product Catalog

ElectroMart contains 12 electronic products:

1. iPhone 17 Pro
2. Samsung Galaxy S26 Ultra
3. MacBook Pro
4. Dell XPS 15
5. Sony WH-1000XM6
6. AirPods Pro
7. Apple Watch Series 11
8. Sony Alpha Camera
9. PlayStation 5
10. 4K Smart TV
11. 1TB External SSD
12. JBL Bluetooth Speaker

### Shopping Cart

- Add products
- View products
- Remove products
- Maintain cart using session
- Calculate subtotal
- Calculate delivery charge
- Calculate final total

### Checkout

- Process orders
- Generate order ID
- Calculate order total
- Display order confirmation
- Clear cart after checkout
- Update store-wide statistics

---

## JSP Implicit Objects

### 1. Session

The `session` implicit object is used for user-specific information.

It stores:

```text
username
authenticated
cart
checkoutProcessed
lastOrderId
lastPurchasedItems
lastOrderTotal
