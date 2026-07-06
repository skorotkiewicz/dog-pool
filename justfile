# https://github.com/casey/just

[private]
default:
    @just --list

build:
    rm -f index.html
    bunx html-minifier-terser \
        --collapse-whitespace \
        --remove-comments \
        --minify-css true \
        --minify-js true \
        -o index.html \
        resources/index.html

serve: build
    bunx serve .

check:
    bunx html-validate resources/index.html

check-vnu:
    docker run --rm -v "$PWD:/data" ghcr.io/validator/validator:latest vnu /data/resources/index.html

clean:
    rm -f index.html
