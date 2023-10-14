set(OPENSSL_VERSION 3.1.3)
set(OPENSSL_VERSION_MAJOR 3)
set(OPENSSL_VERSION_MINOR 1)
set(OPENSSL_VERSION_PATCH 3)

find_path(OPENSSL_INCLUDE_DIR
          NAMES openssl/ssl.h
          PATH_SUFFIXES include
          HINTS ${OpenSSL_DIR}
        )

find_library(OPENSSL_SSL_LIBRARY
    NAMES ssl
    PATH_SUFFIXES lib lib64
    HINTS ${OpenSSL_DIR}
)

find_library(OPENSSL_CRYPTO_LIBRARY
NAMES crypto
PATH_SUFFIXES lib lib64
HINTS ${OpenSSL_DIR}
)

mark_as_advanced(OPENSSL_CRYPTO_LIBRARY OPENSSL_SSL_LIBRARY)

set(OPENSSL_SSL_LIBRARIES ${OPENSSL_SSL_LIBRARY})
set(OPENSSL_CRYPTO_LIBRARIES ${OPENSSL_CRYPTO_LIBRARY})
set(OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARIES} ${OPENSSL_CRYPTO_LIBRARIES} )
set(OPENSSL_INCLUDE_DIRS ${OPENSSL_INCLUDE_DIR})
set(OPENSSL_FOUND TRUE)

set(OpenSSL_Crypto_FOUND TRUE)
set(OpenSSL_SSL_FOUND TRUE)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSSL
                            REQUIRED_VARS
                                OPENSSL_CRYPTO_LIBRARY
                                OPENSSL_INCLUDE_DIRS
                            VERSION_VAR
                              OPENSSL_VERSION
                            HANDLE_VERSION_RANGE
                            HANDLE_COMPONENTS
                          )


add_library(OpenSSL::Crypto UNKNOWN IMPORTED)
set_target_properties(OpenSSL::Crypto PROPERTIES
                    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIRS}")       
set_target_properties(OpenSSL::Crypto PROPERTIES
                    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                    IMPORTED_LOCATION "${OPENSSL_CRYPTO_LIBRARIES}")
                    
set_property( TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES ws2_32 )
set_property( TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES crypt32 )
        
add_library(OpenSSL::SSL UNKNOWN IMPORTED)
set_target_properties(OpenSSL::SSL PROPERTIES
          INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIRS}")
set_target_properties(OpenSSL::SSL PROPERTIES
            IMPORTED_LINK_INTERFACE_LANGUAGES "C"
            IMPORTED_LOCATION "${OPENSSL_SSL_LIBRARIES}")

set_property( TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES ws2_32 )
set_property( TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES crypt32 )
