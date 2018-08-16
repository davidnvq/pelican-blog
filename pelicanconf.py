from __future__ import unicode_literals

SITEURL = "/"
AUTHOR = "Quang Nguyen"
SITENAME = "Quang Nguyen"
TIMEZONE = "UTC"
DEFAULT_DATE_FORMAT = "%B %d, %Y"

DEFAULT_LANG = "en"
IGNORE_FILES = [".ipynb_checkpoints"]
MARKUP = ("md",)
SUMMARY_MAX_LENGTH = 150
DEFAULT_PAGINATION = 10
THEME = "theme"

DEFAULT_HEADER_BG = "favicon.ico"
OUTPUT_PATH = "output/"
ARTICLE_PATHS = ["content"]
USE_FOLDER_AS_CATEGORY = True
DEFAULT_CATEGORY = "misc"
PAGE_PATHS = ["content/pages"]
CACHE_PATH = "cache/"
CACHE_CONTENT = False
LOAD_CONTENT_CACHE = False
DELETE_OUTPUT_DIRECTORY = True
PYGMENTS_RST_OPTIONS = {'classprefix': 'pgcss', 'linenos': 'table'}


ARTICLE_URL = "blog/{category}/{date:%Y}/{slug}/"
ARTICLE_SAVE_AS = "blog/{category}/{date:%Y}/{slug}/index.html"
PAGE_URL = "{category}/{slug}/"
PAGE_SAVE_AS = "{category}/{slug}/index.html"
FEED_ALL_ATOM = "feeds/all.atom.xml"
CATEGORY_FEED_ATOM = "feeds/%s.atom.xml"

MARKDOWN = {
    "extension_configs": {
        "markdown.extensions.codehilite": {"css_class": "highlight"},
        "markdown.extensions.extra": {},
        "markdown.extensions.meta": {},
    },
    "output_format": "html5",
}

# Paths are relative to `content`
STATIC_PATHS = ["images", "favicon.ico", "404.html", "robots.txt", "CNAME"]

EXTRA_PATH_METADATA = {
    'robots.txt': {'path': 'robots.txt'},
    'favicon.ico': {'path': 'favicon.ico'}
}



# PLUGINS SETTINGS
PLUGIN_PATHS = ["plugins"]
PLUGINS = ["sitemap", "ipynb.liquid", "liquid_tags.youtube", "liquid_tags.b64img", "pelican-toc", "render_math"]
# PLUGINS = ["sitemap", "ipynb.markup", "ipynb.liquid", "liquid_tags.youtube", "liquid_tags.b64img"]

SITEMAP = {
    "format": "xml"
}

TOC = {
    'TOC_HEADERS'       : '^h[1-3]', # What headers should be included in
                                     # the generated toc
                                     # Expected format is a regular expression

    'TOC_RUN'           : 'true',    # Default value for toc generation,
                                     # if it does not evaluate
                                     # to 'true' no toc will be generated

    'TOC_INCLUDE_TITLE': 'true',     # If 'true' include title in toc
}

MATH_JAX = {'align': 'left', 'linebreak_automatic' : True, 'responsive':True, 'responsive_align' : True}

