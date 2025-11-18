-- Insert test data (use INSERT IGNORE since data might exist)
INSERT IGNORE INTO category (id, title, alias, enabled, image, parent_id, all_parent_ids) VALUES
(1, 'Electronics', 'electronics', true, 'electronics.jpg', NULL, NULL),
(2, 'Computers', 'computers', true, 'computers.jpg', 1, '1');

INSERT IGNORE INTO vendor (id, title) VALUES (1, 'Test Vendor');

INSERT IGNORE INTO product (id, title, alias, description, price, image, category_id, vendor_id) VALUES
(1, 'Test Product', 'test-product', 'Test Description', 99.99, 'test.jpg', 1, 1),
(2, 'Another Product', 'another-product', 'Another Description', 149.99, 'another.jpg', 2, 1),
(12, 'Update Product', 'update-product', 'Update Description', 199.99, 'update.jpg', 1, 1);

INSERT IGNORE INTO user (id, login, email, password, role) VALUES
(1, 'testuser', 'test@example.com', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 'ROLE_USER');

INSERT IGNORE INTO order_basket (id, user_id, product_id, quantity) VALUES
(1, 1, 1, 2);