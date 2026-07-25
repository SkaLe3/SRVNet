set(SANDBOX_SOURCES
    Sandbox.cpp
)

srvn_add_example(Sandbox SOURCES ${SANDBOX_SOURCES} DEPENDS SRVNet)