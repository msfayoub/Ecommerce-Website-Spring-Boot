-- Insert vendors FIRST (required for foreign key constraints)
INSERT IGNORE INTO vendor (id, title) VALUES 
(1, 'Apple'),
(2, 'Samsung'),
(3, 'Dell'),
(999, 'Test Vendor');

-- Insert categories with proper hierarchy
INSERT IGNORE INTO category (id, title, alias, enabled, image, parent_id, all_parent_ids) VALUES
-- Root categories
(1, 'Electronics', 'electronics', true, 'electronics.jpg', NULL, NULL),
(2, 'Computers', 'computers', true, 'computers.jpg', 1, '1'),
(3, 'Phones', 'phones', true, 'phones.jpg', 1, '1'),
-- Test category for CategoryRepoTest.categoryFindByAlias
(999, 'Test Electronics', 'test-electronics', true, 'test-electronics.jpg', NULL, NULL),
-- Subcategories for testGetCategory
(4, 'Laptops', 'laptops', true, 'laptops.jpg', 2, '1-2'),
(5, 'Desktops', 'desktops', true, 'desktops.jpg', 2, '1-2'),
(6, 'Sensor phones', 'sensor-phones', true, 'sensor-phones.jpg', 3, '1-3');

-- Insert users (required for order basket tests)
INSERT IGNORE INTO user (id, login, email, password, role) VALUES
(1, 'admin', 'test@example.com', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 'USER'),
(999, 'testuser999', 'test999@example.com', '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HZWzG3YB1tlRy.fqvM/BG', 'USER');

-- Insert products (with valid vendor_id and category_id)
INSERT IGNORE INTO product (id, title, alias, description, price, image, category_id, vendor_id) VALUES
-- Products for general tests
(1, 'Test Product', 'test-product', 'Test Description', 99.99, 'test.jpg', 1, 1),
(2, 'Another Product', 'another-product', 'Another Description', 149.99, 'another.jpg', 2, 1),
(12, 'Update Product', 'update-product', 'Update Description', 199.99, 'update.jpg', 1, 1),
(999, 'Test Product 999', 'test-product-999', 'Test Description 999', 99.99, 'test999.jpg', 999, 999),
-- Product with alias "phones" for ProductRepositoryTest
(7, 'Generic Phone', 'phones', 'A generic phone for testing', 599.99, 'phone.jpg', 3, 2),
-- Products for search test (containing searchable keywords)
(3, 'iPhone 14 Pro', 'iphone-14-pro', 'Latest Apple smartphone with amazing features', 999.99, 'iphone14.jpg', 3, 1),
(4, 'Samsung Galaxy S23', 'samsung-galaxy-s23', 'Powerful Samsung phone', 899.99, 'galaxy-s23.jpg', 3, 2),
(5, 'MacBook Pro', 'macbook-pro', 'Apple laptop for professionals', 1999.99, 'macbook.jpg', 4, 1),
(6, 'Dell XPS 15', 'dell-xps-15', 'High performance Dell laptop', 1499.99, 'xps15.jpg', 4, 3);

-- Insert order basket items (for testGetOrderBasketProdByUser)
INSERT IGNORE INTO order_basket (id, product_id, quantity, user_id) VALUES
(1, 1, 2, 1),
(2, 2, 1, 1),
(999, 999, 1, 999);