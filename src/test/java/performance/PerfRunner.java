package performance;

import com.intuit.karate.junit5.Karate;

class PerfRunner {

    @Karate.Test
    Karate testPerformance() {
        return Karate.run().relativeTo(getClass());
    }
}
