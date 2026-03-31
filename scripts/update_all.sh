#!/usr/bin/env bash
# Script to copy all vendor assets into project after running `npm install`

# Define directories
ASSETS_JS_DIR="assets/js/vendor/"
ASSETS_CSS_DIR="assets/css/vendor/"
ASSETS_SCSS_DIR="assets/sass/vendor/"

# Create directories if they don't exist
mkdir -p $ASSETS_JS_DIR
mkdir -p $ASSETS_CSS_DIR
mkdir -p $ASSETS_SCSS_DIR/bootstrap/  # Bootstrap needs special SCSS directory

# 1. Bootstrap
cp node_modules/bootstrap/dist/js/bootstrap.min.js $ASSETS_JS_DIR
cp -r node_modules/bootstrap/scss/* $ASSETS_SCSS_DIR/bootstrap/

# 2. jQuery
cp node_modules/jquery/dist/jquery.min.js $ASSETS_JS_DIR

# 3. Academicons
cp node_modules/academicons/css/academicons.min.css $ASSETS_CSS_DIR

# 4. Font Awesome
mkdir -p $ASSETS_SCSS_DIR/fontawesome/
cp -r node_modules/@fortawesome/fontawesome-free/css/all.min.css $ASSETS_CSS_DIR
cp -r node_modules/@fortawesome/fontawesome-free/scss/* $ASSETS_SCSS_DIR/fontawesome/

# 5. Fancybox
cp node_modules/fancybox/dist/css/jquery.fancybox.css $ASSETS_CSS_DIR
cp node_modules/fancybox/dist/js/jquery.fancybox.js $ASSETS_JS_DIR

# 6. Highlight.js
mkdir -p $ASSETS_CSS_DIR/highlightjs/
cp node_modules/highlight.js/styles/github.min.css $ASSETS_CSS_DIR/highlightjs/
cp node_modules/highlight.js/styles/base16/dracula.min.css $ASSETS_CSS_DIR/highlightjs/
cp node_modules/highlight.js/lib/highlight.min.js $ASSETS_JS_DIR

# 7. Leaflet
cp node_modules/leaflet/dist/leaflet.css $ASSETS_CSS_DIR
cp node_modules/leaflet/dist/leaflet.js $ASSETS_JS_DIR

# 8. Popper.js (if needed for Bootstrap)
cp node_modules/popper.js/dist/umd/popper.min.js $ASSETS_JS_DIR

echo "All vendor assets have been copied to their respective directories"
