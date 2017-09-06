
# the name of your source ascii doctor files
SRC=example.adoc

# the output files
DOCS=example.pdf example.html

# name of your docker image with ascii doctor installed
DCON=alpdoc

# the shared directory path between the host and the docker image
# this should match WORKDIR and VOLUME in Dockerfile
DOCDIR=/docs

DIR := ${CURDIR}

all: $(DOCS)

example.html: $(SRC)
	docker run -it -v $(DIR):$(DOCDIR)/ $(DCON)     asciidoctor $(SRC)

example.pdf: $(SRC)
	docker run -it -v $(DIR):$(DOCDIR)/ $(DCON) asciidoctor-pdf $(SRC)

dockerimg:
	docker build -t alpdoc .

.PHONY: clean

clean:
	rm -f *.pdf *.html

dockerclean:
	docker rm $(docker ps -aq)
	docker rmi $(docker images -q)

