if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

# Let pip find native libs it needs
export LDFLAGS="-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/include -I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/usr/local/opt/openssl/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig"
if command -v xcrun >/dev/null 2>&1; then
  export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
fi


