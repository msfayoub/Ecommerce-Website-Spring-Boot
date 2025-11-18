package com.khomsi.site_project;

import com.khomsi.site_project.entity.OrderBasket;
import com.khomsi.site_project.entity.Product;
import com.khomsi.site_project.entity.User;
import com.khomsi.site_project.repository.OrderBasketRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class OrderBasketTests extends BaseIntegrationTest {

    @Autowired
    private OrderBasketRepository orderBasketRep;

    @Autowired
    private TestEntityManager entityManager;

    @Test
    public void testAddOneOrderBasketProduct() {
        // Product id 6 exists in your SQL (Dell XPS 15)
        Product product = entityManager.find(Product.class, 6);
        // User id 1 exists in your SQL
        User user = entityManager.find(User.class, 1);

        assertNotNull(product, "Product with id=6 must exist in test-data.sql");
        assertNotNull(user, "User with id=1 must exist in test-data.sql");

        OrderBasket newOrderBasket = new OrderBasket();
        newOrderBasket.setUser(user);
        newOrderBasket.setProduct(product);
        newOrderBasket.setQuantity(1);

        OrderBasket savedOrderBasket = orderBasketRep.save(newOrderBasket);

        assertNotNull(savedOrderBasket.getId());
        assertTrue(savedOrderBasket.getId() > 0);
    }

    @Test
    public void testGetOrderBasketProdByUser() {
        // Get the managed User entity with id 1
        User user = entityManager.find(User.class, 1);
        assertNotNull(user, "User with id=1 must exist in test-data.sql");

        List<OrderBasket> orderBaskets = orderBasketRep.findByUser(user);

        // In your SQL you have:
        // (1, 1, 2, 1),
        // (2, 2, 1, 1),
        // so user 1 has exactly 2 order_basket rows.
        assertEquals(2, orderBaskets.size());
    }
}
