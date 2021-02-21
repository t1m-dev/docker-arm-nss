# NSS for arm-linux-gnueabihf
Setting up cross-compilation support for `arm-linux-gnueabihf`. Currently, the build crashes, see `log.txt`.
```
docker build . > log.txt
```

## Linking freebl error
```
[658/1210] SOLINK /root/nss-3.62/dist/Release/lib/libfreeblpriv3.so
FAILED: /root/nss-3.62/dist/Release/lib/libfreeblpriv3.so /root/nss-3.62/dist/Release/lib/libfreeblpriv3.so.TOC 
if [ ! -e /root/nss-3.62/dist/Release/lib/libfreeblpriv3.so -o ! -e /root/nss-3.62/dist/Release/lib/libfreeblpriv3.so.TOC ]; then arm-linux-gnueabihf-gcc -shared -Wl,-rpath-link=.lib --sysro
/opt/x-tools/arm-remarkable-linux-gnueabihf/lib/gcc/arm-remarkable-linux-gnueabihf/8.3.0/../../../../arm-remarkable-linux-gnueabihf/bin/ld.bfd: obj/lib/freebl/freeblpriv3.gcm.o: in function 
gcm.c:(.text.gcmHash_InitContext+0xa4): undefined reference to `gcm_HashInit_hw'
/opt/x-tools/arm-remarkable-linux-gnueabihf/lib/gcc/arm-remarkable-linux-gnueabihf/8.3.0/../../../../arm-remarkable-linux-gnueabihf/bin/ld.bfd: obj/lib/freebl/freeblpriv3.gcm.o: in function 
gcm.c:(.text.gcmHash_Final+0xdc): undefined reference to `gcm_HashWrite_hw'
/opt/x-tools/arm-remarkable-linux-gnueabihf/lib/gcc/arm-remarkable-linux-gnueabihf/8.3.0/../../../../arm-remarkable-linux-gnueabihf/bin/ld.bfd: obj/lib/freebl/freeblpriv3.gcm.o: in function 
gcm.c:(.text.gcmHash_Reset+0x90): undefined reference to `gcm_HashZeroX_hw'
collect2: error: ld returned 1 exit status
```
