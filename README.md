# The web site of Relax-and-Recover

To develop install `jekyll` and `ruby-kramdown` and start the jekyll server with `./serve.sh`

To just start a live server without local dependencies via Docker run `./docker.sh`

## Notes

### Convert Markdown HTML content to ASCII text

We use [Lynx](https://lynx.invisible-island.net/) to convert Markdown to ASCII. It creates a text file with the HTML content and adds the links as footnotes.

You can either install `lynx` on your system or use the Docker image `alpine/lynx`.

```bash
docker run --rm -it -e LC_ALL=POSIX -e LANG=POSIX  alpine/lynx --dump URL > output.txt
```

Example for release notes:

```bash
docker run --rm -it -e LC_ALL=POSIX -e LANG=POSIX alpine/lynx -dont_wrap_pre -width=100 --dump https://relax-and-recover.org/documentation/release-notes-2-8 > release-notes-2-8.txt
```
Using '-dont_wrap_pre' avoids line breaks in the git commit messages (we have them in 'pre' sections) and '-width=100' avoids ugly looking line breaks in normal text (e.g. URLs that get wrapped within a word) because longer lines make it less likely that things must be shown wrapped.

To use it with Docker to convert from the local development server (*however note, that the links will also point to the local server*):

```bash
docker run --rm -it -e LC_ALL=POSIX -e LANG=POSIX  alpine/lynx -dont_wrap_pre -width=100 --dump http://host.docker.internal:4000/documentation/release-notes-2-8
```
