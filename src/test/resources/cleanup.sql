-- Clean up test data in reverse order of foreign key dependencies
DELETE FROM order_basket WHERE id IN (1, 2, 999);
DELETE FROM product WHERE id IN (1, 2, 3, 4, 5, 6, 7, 12, 999);
DELETE FROM user WHERE id IN (1, 999);
DELETE FROM category WHERE id IN (1, 2, 3, 4, 5, 6, 999);
DELETE FROM vendor WHERE id IN (1, 2, 3, 999);