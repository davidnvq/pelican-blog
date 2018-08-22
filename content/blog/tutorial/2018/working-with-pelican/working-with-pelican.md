Title: Working with Pelican
Slug: working-with-pelican
Date: 2018-08-22 14:57:38
Tags: Pelican, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no


# Copying favicon/robots.txt
## First solution
If you used the pelican-quickstart command to create a Makefile and want certain files copied to your web root — such as favicon.ico, robots.txt, or other files — create a folder called extra next to your Makefile and edit your Makefile to look like this:
```
 $(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	if test -d $(BASEDIR)/extra; then cp $(BASEDIR)/extra/* $(OUTPUTDIR)/; fi
```
```
publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)
	if test -d $(BASEDIR)/extra; then cp $(BASEDIR)/extra/* $(OUTPUTDIR)/; fi
```
# Second solution, using STATIC_PATHS
Add `favicon.ico` and `robots.txt` to the content/extra folder and add the following to `pelicanconf.py`:
```
STATIC_PATHS = ['images', 'extra/robots.txt', 'extra/favicon.ico']
EXTRA_PATH_METADATA = {
    'extra/robots.txt': {'path': 'robots.txt'},
    'extra/favicon.ico': {'path': 'favicon.ico'}
}
```

# Make

Make is available on almost any Unix-derived system but is old and can be clunky for building anything other than code. Many people prefer to use Rake (ruby make) or Fabric (a Pythonic tool for remote execution and deployment). Please post your examples and tips below for awesome development, testing, and deployment.

## Make newpost
You can edit your Makefile to give you a handful of new commands that might make it slightly easier to get writing. Just add the following lines to your Makefile:

```bash

PAGESDIR=$(INPUTDIR)/pages
DATE := $(shell date +'%Y-%m-%d %H:%M:%S')
SLUG := $(shell echo '${NAME}' | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z)
EXT ?= md

newpost:
ifdef NAME
        echo "Title: $(NAME)" >  $(INPUTDIR)/$(SLUG).$(EXT)
        echo "Slug: $(SLUG)" >> $(INPUTDIR)/$(SLUG).$(EXT)
        echo "Date: $(DATE)" >> $(INPUTDIR)/$(SLUG).$(EXT)
        echo ""              >> $(INPUTDIR)/$(SLUG).$(EXT)
        echo ""              >> $(INPUTDIR)/$(SLUG).$(EXT)
        ${EDITOR} ${INPUTDIR}/${SLUG}.${EXT} &
else
        @echo 'Variable NAME is not defined.'
        @echo 'Do make newpost NAME='"'"'Post Name'"'"
endif

editpost:
ifdef NAME
        ${EDITOR} ${INPUTDIR}/${SLUG}.${EXT} &
else
        @echo 'Variable NAME is not defined.'
        @echo 'Do make editpost NAME='"'"'Post Name'"'"
endif

newpage:
ifdef NAME
        echo "Title: $(NAME)" >  $(PAGESDIR)/$(SLUG).$(EXT)
        echo "Slug: $(SLUG)" >> $(PAGESDIR)/$(SLUG).$(EXT)
        echo ""              >> $(PAGESDIR)/$(SLUG).$(EXT)
        echo ""              >> $(PAGESDIR)/$(SLUG).$(EXT)
        ${EDITOR} ${PAGESDIR}/${SLUG}.$(EXT)
else
        @echo 'Variable NAME is not defined.'
        @echo 'Do make newpage NAME='"'"'Page Name'"'"
endif

editpage:
ifdef NAME
        ${EDITOR} ${PAGESDIR}/${SLUG}.$(EXT)
else
        @echo 'Variable NAME is not defined.'
        @echo 'Do make editpage NAME='"'"'Page Name'"'"
endif
```

To use this, make sure you've set the EDITOR environment variable to the name of your favourite editor, (or set it again within the Makefile), and then do
```bash
$ make newpost NAME='Your Exciting Post Name Here'
```

Your editor will appear with the beginnings of a new post. You can set 'EXT' to whatever extension you use most often, and then overwrite it by passing "EXT='newext'" to make. Equally, this change assumes that all your pages are stored in content/pages, which may not be true for you. This sample should work well enough for you to base any modifications off, though.

