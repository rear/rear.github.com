#!/bin/bash
exec docker run --rm -it \
    --volume="$PWD:/srv/jekyll:Z" \
    --publish [::1]:4000-4001:4000-4001 \
    --name jekyll \
    --platform linux/amd64 \
    jekyll/jekyll:3.8 \
    jekyll serve \
    --port 4000 \
    --livereload --livereload-port 4001 \
    --watch --force_polling
