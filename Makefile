PY=python
PELICAN=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

FTP_HOST=localhost
FTP_USER=anonymous
FTP_TARGET_DIR=/

SSH_HOST=localhost
SSH_PORT=22
SSH_USER=root
SSH_TARGET_DIR=/var/www

S3_BUCKET=my_s3_bucket

CLOUDFILES_USERNAME=my_rackspace_username
CLOUDFILES_API_KEY=my_rackspace_api_key
CLOUDFILES_CONTAINER=my_cloudfiles_container

DROPBOX_DIR=~/Dropbox/Public/

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif                                                                      

all: build

.PHONY: build
build:  ## Generate the output
	$(PELICAN) -s $(CONFFILE) $(PELICANOPTS)
	cp $(INPUTDIR)/favicon.ico $(OUTPUTDIR)
	cp $(INPUTDIR)/robots.txt $(OUTPUTDIR)
	cp -r $(INPUTDIR)/pages/* $(OUTPUTDIR)


.PHONY: clean
clean:  ## Remove the generated output
	@rm -rf $(OUTPUTDIR) *.pid

.PHONY: cleanall
cleanall:  ## Remove dev environment
	@rm -rf $(ENV)

.PHONY: regenerate
regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

.PHONY: serve
serve:  ## Serve the output
ifdef PORT
	cd $(OUTPUTDIR) && $(PY) -m pelican.server $(PORT)
else
	cd $(OUTPUTDIR) && $(PY) -m pelican.server
endif

.PHONY: devserver
devserver:  ## Start the live-reload webserver
ifdef PORT
	$(BASEDIR)/develop_server.sh restart $(PORT)
else
	$(BASEDIR)/develop_server.sh restart
endif

.PHONY: stopserver
stopserver:  ## Stop the live-reload webserver
	kill -9 `cat pelican.pid`
	kill -9 `cat srv.pid`
	@echo 'Stopped Pelican and SimpleHTTPServer processes running in background.'

.PHONY: publish
publish:  ## Generate output ready for publish
	$(PELICAN) -s $(PUBLISHCONF) $(PELICANOPTS)
	cp $(INPUTDIR)/favicon.ico $(OUTPUTDIR)
	cp $(INPUTDIR)/robots.txt $(OUTPUTDIR)
	git add .
	git commit -m "Some notes added to pelican-blog"
	git push -u origin master
	rm -rf ../quangdtsc.github.io/*
	mv $(OUTPUTDIR)/* ../quangdtsc.github.io/
	cd ../quangdtsc.github.io/ && pwd && git add . && git commit -m "Some notes added to quangdtsc.github.io" && git push -u origin master

.PHONY: bootstrap
bootstrap:  ## Create the dev environment
	@echo "==> Bootstrapping environment"
	@pipenv install --skip-lock

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

EDITOR = code
PAGESDIR=$(INPUTDIR)/pages
DATE := $(shell date +'%Y-%m-%d %H:%M:%S')
SLUG := $(shell echo '${name}' | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z)
EXT ?= md
YEAR := $(shell date +'%Y')

paper:
ifdef name
	mkdir -p $(INPUTDIR)/blog/paper/$(year)/$(SLUG)
	echo "Title: $(name)" >  $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "Slug: $(SLUG)" >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "Date: $(DATE)" >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "Tags: , $(year), PAPER" >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "Author: Quang Nguyen" >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "Category: paper" >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo "TopPost: no"   >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/paper/$(year)/$(SLUG)/$(SLUG).$(EXT)		
	${EDITOR} ${INPUTDIR}/blog/paper/$(year)/$(SLUG)
else
	@echo 'Variable name is not defined.'
	@echo 'Do: make paper name='"'"'Post name'" year='"'"'year'"'"
endif

tut:
ifdef name
	mkdir -p $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)
	echo "Title: $(name)" >  $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Slug: $(SLUG)" >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Date: $(DATE)" >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Tags: , TUTORIAL" >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Author: Quang Nguyen" >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Category: tutorial" >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "TopPost: no"   >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/tutorial/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)		
	${EDITOR} ${INPUTDIR}/blog/tutorial/$(YEAR)/$(SLUG)
else
	@echo 'Variable name is not defined.'
	@echo 'Do: make tut name='"'"'Post name'"'"
endif

book:
ifdef name
	mkdir -p $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)
	echo "Title: $(name)" >  $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Slug: $(SLUG)" >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Date: $(DATE)" >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Tags: , BOOK" >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Author: Quang Nguyen" >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Category: paper" >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "TopPost: no"   >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/book/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)		
	${EDITOR} ${INPUTDIR}/blog/book/$(YEAR)/$(SLUG)
else
	@echo 'Variable name is not defined.'
	@echo 'Do: make book name='"'"'Post name'"'"
endif

other:
ifdef name
	mkdir -p $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)
	echo "Title: $(name)" >  $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Slug: $(SLUG)" >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Date: $(DATE)" >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Tags: , OTHER" >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Author: Quang Nguyen" >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "Category: other" >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo "TopPost: no"   >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/blog/other/$(YEAR)/$(SLUG)/$(SLUG).$(EXT)		
	${EDITOR} ${INPUTDIR}/blog/other/$(YEAR)/$(SLUG)
else
	@echo 'Variable name is not defined.'
	@echo 'Do make other name='"'"'Post name'"'"
endif
