-- Insert vendors FIRST (before products need them)
INSERT IGNORE INTO vendor (id, title) VALUES 
(1, 'Test Vendor'),
(999, 'Test Vendor 999');

-- Insert categories
INSERT IGNORE INTO category (id, title, alias, enabled, image, parent_id, all_parent_ids) VALUES
(1, 'Electronics', 'electronics', true, 'electronics.jpg', NULL, NULL),
(2, 'Computers', 'computers', true, 'computers.jpg', 1, '1'),
(999, 'Test Category', 'test-electronics', true, 'electronics.jpg', NULL, NULL);

-- Insert products (with valid vendor_id)
INSERT IGNORE INTO product (id, title, alias, description, price, image, category_id, vendor_id) VALUES
(1, 'Test Product', 'test-product', 'Test Description', 99.99, 'test.jpg', 1, 1),
(2, 'Another Product', 'another-product', 'Another Description', 149.99, 'another.jpg', 2, 1),
(12, 'Update Product', 'update-product', 'Update Description', 199.99, 'update.jpg', 1, 1),
(999, 'Test Product 999', 'test-product-999', 'Test Description', 99.99, 'test.jpg', 999, 999);

-- Insert user
INSERT IGNORE INTO user (id, login, email, password, role) VALUES
(1, 'testuser', 'test@example.com', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 'ROLE_USER'),
(999, 'testuser999', 'test999@example.com', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 'ROLE_USER');