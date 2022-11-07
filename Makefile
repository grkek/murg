# Hardcode Babel to 6.26.0 since Duktape doesn't work with newer versions.
# Hardocde CoreJS to 2.6.11 since Duktape doesn't work with newer versions.

install:
	wget -O ./src/murg/support/babel.js https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.js
	wget -O ./src/murg/support/core.js https://cdnjs.cloudflare.com/ajax/libs/core-js/2.6.11/core.js