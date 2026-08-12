INSERT INTO categories (category_name) VALUES
('Electronics'), ('Home & Kitchen'), ('Books'), ('Clothing'), ('Sports');

INSERT INTO customers (first_name, last_name, email, signup_date, country) VALUES
('Asha', 'Rao', 'asha.rao@example.com', '2024-01-15', 'India'),
('Liam', 'Smith', 'liam.smith@example.com', '2024-02-02', 'USA'),
('Mei', 'Chen', 'mei.chen@example.com', '2024-02-20', 'China'),
('Carlos', 'Diaz', 'carlos.diaz@example.com', '2024-03-05', 'Mexico'),
('Priya', 'Nair', 'priya.nair@example.com', '2024-03-18', 'India');

INSERT INTO products (product_name, category_id, unit_price, created_at) VALUES
('Wireless Mouse', 1, 799.00, '2024-01-01'),
('Bluetooth Speaker', 1, 1999.00, '2024-01-01'),
('Non-stick Pan', 2, 1299.00, '2024-01-05'),
('Novel: The Silent Hour', 3, 349.00, '2024-01-10'),
('Running Shoes', 5, 2999.00, '2024-01-12');

INSERT INTO inventory (product_id, stock_quantity, reorder_level) VALUES
(1, 50, 10), (2, 30, 10), (3, 15, 5), (4, 100, 20), (5, 8, 10);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-04-01', 'completed'),
(2, '2024-04-03', 'completed'),
(1, '2024-05-10', 'completed'),
(3, '2024-05-15', 'completed'),
(4, '2024-06-01', 'completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 799.00),
(1, 4, 1, 349.00),
(2, 2, 1, 1999.00),
(3, 5, 1, 2999.00),
(4, 3, 1, 1299.00),
(5, 1, 1, 799.00);

INSERT INTO payments (order_id, payment_date, amount, method) VALUES
(1, '2024-04-01', 1947.00, 'credit_card'),
(2, '2024-04-03', 1999.00, 'upi'),
(3, '2024-05-10', 2999.00, 'credit_card'),
(4, '2024-05-15', 1299.00, 'debit_card'),
(5, '2024-06-01', 799.00, 'upi');

INSERT INTO reviews (product_id, customer_id, rating, review_date) VALUES
(1, 1, 5, '2024-04-05'),
(4, 1, 4, '2024-04-06'),
(2, 2, 3, '2024-04-10'),
(5, 3, 5, '2024-05-20');
