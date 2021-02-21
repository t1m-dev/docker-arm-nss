FROM ghcr.io/toltec-dev/base:latest

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -yy git build-essential autoconf libtool \
       autoconf-archive gyp python ninja-build

RUN cd /root \
    && curl https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_62_RTM/src/nss-3.62-with-nspr-4.29.tar.gz -o nss-3.62-with-nspr-4.29.tar.gz \
    && tar xf nss-3.62-with-nspr-4.29.tar.gz

# build nspr first
RUN cd /root/nss-3.62/nspr \
    && ./configure --host=arm --target=$CHOST --prefix=/usr \
    && make \
    && DESTDIR="$SYSROOT" make install

# use nspr as system library
RUN cd /root/nss-3.62/nss \
    && AS="${CROSS_COMPILE}as" CC="${CROSS_COMPILE}gcc" \
       CXX="${CROSS_COMPILE}g++" CPP="${CROSS_COMPILE}cpp" \ 
       LD="${CROSS_COMPILE}ld" AR="${CROSS_COMPILE}ar" \ 
       RANLIB="${CROSS_COMPILE}ranlib" STRIP="${CROSS_COMPILE}strip" \ 
       LDFLAGS="-Wl,-rpath-link=.lib --sysroot=$SYSROOT $LDFLAGS" \
       ./build.sh --with-nspr=$SYSROOT/usr/include/nspr:$SYSROOT/lib \
       --target=arm-unknown-linux-gnueabihf -o
