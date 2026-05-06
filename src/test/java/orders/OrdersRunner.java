package orders;

import com.intuit.karate.junit5.Karate;

class OrdersRunner {

    @Karate.Test
    Karate testOrders() {
        return Karate.run().relativeTo(getClass());
    }
}
