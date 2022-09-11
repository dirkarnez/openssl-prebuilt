
find_path(OPENSSL_INCLUDE_DIR
          NAMES openssl/ssl.h
          PATH_SUFFIXES include
          HINTS ${OPENSSL_DIR})

set(_OPENSSL_LIB_NAME libssl.a)
set(_OPENSSL_CRYPTO_LIB_NAME libcrypto.a)

find_library(OPENSSL_LIBRARY
             NAMES ${_OPENSSL_LIB_NAME}
             PATH_SUFFIXES lib64
             HINTS ${OPENSSL_DIR})

find_library(OPENSSL_CRYPTO_LIBRARY
             NAMES ${_OPENSSL_CRYPTO_LIB_NAME}
             PATH_SUFFIXES lib64
             HINTS ${OPENSSL_DIR})

set(OPENSSL_LIBRARIES ${OPENSSL_LIBRARY} ${OPENSSL_CRYPTO_LIBRARY})

set(OPENSSL_FOUND TRUE)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSSL
                                  FOUND_VAR OPENSSL_FOUND
                                  REQUIRED_VARS
                                      OPENSSL_INCLUDE_DIR
                                      OPENSSL_LIBRARY
                                      OPENSSL_CRYPTO_LIBRARY)


add_library(openssl STATIC IMPORTED)
set_target_properties(openssl PROPERTIES 
    INTERFACE_INCLUDE_DIRECTORIES "${OPENSSL_INCLUDE_DIR}"
    IMPORTED_LOCATION "${OPENSSL_LIBRARY}")


add_library(opensslcrypto UNKNOWN IMPORTED)
set_target_properties(opensslcrypto PROPERTIES
                      IMPORTED_LOCATION "${OPENSSL_CRYPTO_LIBRARY}")