# Hardcode Babel to 6.26.0 since Duktape doesn't work with newer versions.

install:
	wget -O ./src/murg/support/babel.js https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.js