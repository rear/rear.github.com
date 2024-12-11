# The web site of Relax-and-Recover

To develop install `jekyll` and `ruby-kramdown` and start the jekyll server with `./serve.sh`

To just start a live server without local dependencies via Docker run `./docker.sh`

## Notes

### Convert Markdown to HTML

We use [Lynx](https://lynx.invisible-island.net/) to convert Markdown to HTML. It creates a text file with the HTML content and adds the links as footnotes.

You can either install `lynx` on your system or use the Docker image `alpine/lynx`.

```bash
docker run --rm -it alpine/lynx --dump URL > output.txt
```

Example for release notes:

```bash
docker run --rm -it alpine/lynx --dump https://relax-and-recover.org/documentation/release-notes-2-8 > release-notes-2-8.txt
```

To use it with Docker to convert from the local development server (*however note, that the links will also point to the local server*):

```bash
docker run --rm -it alpine/lynx --dump http://host.docker.internal:4000/documentation/release-notes-2-8
```
