echo 123;

export PATH="D:\a\openssl-prebuilt\openssl-prebuilt/mingw64:D:\a\openssl-prebuilt\openssl-prebuilt/mingw64/bin:D:\a\openssl-prebuilt\openssl-prebuilt/cmake-3.24.0-windows-x86_64/bin:D:\a\openssl-prebuilt\openssl-prebuilt/msys64/usr/bin" && 
cd "D:\a\openssl-prebuilt\openssl-prebuilt\openssl" && ./Configure mingw64 --prefix="D:\a\openssl-prebuilt\openssl-prebuilt/openssl-installation" && mingw32-make.exe install
