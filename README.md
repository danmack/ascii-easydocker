# AsciiDoctor with Docker Workflow

## Overview

Using latex, sphinx, asciidoctor, etc is a great way to work with
documentation like we do with programming language code and
configuration files. However, these packages all require a huge number
of dependencies - so, this is a good use-case for a container.

This repo contains an example workflow you can copy that does the
following:

 1. a Dockerfile which can run the asciidoctor and asciidoctor-pdf
    binaries against your source files.

 2. a sample Makefile to improve your quality of life which can
    help you make your docker image and manage the document
    generation.

 3. an example.adoc asciidoctor docutment which the Makefile can
    convert to html and PDF formats

This idea to use a container came from the asciidoctor github
repository.  I simply switched to a different method of building the
container and made sure it worked with the current release of
asciidoctor,and, without having to include JAVA as a dependency. For
my purposes, this is much cleaner and likely to keep working as
asciidoctor evolves.

## How to use these recipes

### Create docker image on your system

    $ make dockerimg
    docker build -t alpdoc .
    Sending build context to Docker daemon  40.45kB
    Step 1/6 : FROM alpine
     ---> 7328f6f8b418
    Step 2/6 : COPY add-pkgs /root/add-pkgs
     ---> Using cache
     ---> dce930c455a4
    Step 3/6 : RUN /root/add-pkgs
     ---> Using cache
     ---> 8069bdb8e6bb
    Step 4/6 : WORKDIR /docs
     ---> Using cache
     ---> 2d252fa5991b
    Step 5/6 : VOLUME /docs
     ---> Using cache
     ---> 5bdefb1a9d80
    Step 6/6 : CMD /bin/bash
     ---> Using cache
     ---> d6f2de846cf7
    Successfully built d6f2de846cf7
    Successfully tagged alpdoc:latest

Now, in this example, we have a docker image named "alpdoc" on our
system.  This is the default as configured in the provided Makefile.


### Use the Makefile to convert the example file

    pandora% tree .
    .
    ├── Dockerfile
    ├── Makefile
    ├── README.md
    ├── add-pkgs
    └── example.adoc

    pandora%  make
    docker run -it -v /Users/mack/src/ascii-docker://docs/ alpdoc asciidoctor-pdf example.adoc
    docker run -it -v /Users/mack/src/ascii-docker://docs/ alpdoc     asciidoctor example.adoc

    pandora% ls -l example.pdf example.html
    -rw-r--r--  1 mack  staff  33150 Sep  6 10:20 example.html
    -rw-r--r--  1 mack  staff  48208 Sep  6 10:20 example.pdf

Go ahead and open up the html and PDF file with your viewer, enjoy the
beauty of asciidoctor :-)

Hope you find this useful.



