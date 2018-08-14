# This file is only used if you use `make publish`

from __future__ import unicode_literals
import os
import sys
sys.path.append(os.curdir)
from pelicanconf import *

SITEURL = '/'
RELATIVE_URLS = True

LOAD_CONTENT_CACHE = False
DELETE_OUTPUT_DIRECTORY = False

# Following items are often useful when publishing
# GOOGLE_ANALYTICS_CODE = 'UA-35523657-2'
# GOOGLE_ANALYTICS_DOMAIN = 'danielfrg.com'
