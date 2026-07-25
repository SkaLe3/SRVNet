set(SRVNTEST_SOURCE
    Dummy.test.cpp
)

srvn_add_test(test-srvn SOURCES ${SRVNTEST_SOURCE} DEPENDS srvn-test-main)

catch_discover_tests(test-srvn)
