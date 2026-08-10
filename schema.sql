CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    signup_date     DATE NOT NULL,
    country         VARCHAR(50)
);

CREATE TABLE categories (
    category_id     SERIAL PRIMARY KEY,
    category_name   VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id      SERIAL PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    category_id     INT REFERENCES categories(category_id),
    unit_price      NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    created_at      DATE NOT NULL
);

CREATE TABLE inventory (
    product_id      INT PRIMARY KEY REFERENCES products(product_id),
    stock_quantity  INT NOT NULL CHECK (stock_quantity >= 0),
    reorder_level   INT NOT NULL DEFAULT 10
);

CREATE TABLE orders (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    order_date      DATE NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'completed'
);

CREATE TABLE order_items (
    order_item_id   SERIAL PRIMARY KEY,
    order_id        INT REFERENCES orders(order_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT NOT NULL CHECK (quantity > 0),
    unit_price      NUMERIC(10,2) NOT NULL
);

CREATE TABLE payments (
    payment_id      SERIAL PRIMARY KEY,
    order_id        INT REFERENCES orders(order_id),
    payment_date    DATE NOT NULL,
    amount          NUMERIC(10,2) NOT NULL,
    method          VARCHAR(30) NOT NULL
);

CREATE TABLE reviews (
    review_id       SERIAL PRIMARY KEY,
    product_id      INT REFERENCES products(product_id),
    customer_id     INT REFERENCES customers(customer_id),
    rating          INT CHECK (rating BETWEEN 1 AND 5),
    review_date     DATE NOT NULL
);
