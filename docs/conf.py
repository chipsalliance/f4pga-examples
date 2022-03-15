#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2020-2022 F4PGA Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup -----------------------------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
from os import path as os_path, scandir as os_scandir
from sys import path as sys_path
from pathlib import Path

sys_path.insert(0, os_path.abspath('.'))

# -- Project information --------------------------------------------------------------------------

project = 'F4PGA examples'
authors = 'F4PGA Authors'
copyright = f'{authors}, 2020 - 2022'

# -- General configuration ------------------------------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.extlinks',
    'sphinx.ext.intersphinx',
    'sphinx_tabs.tabs',
    'sphinx_jinja',
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# -- Options for HTML output ----------------------------------------------------------------------

html_show_sourcelink = True

html_theme = 'sphinx_symbiflow_theme'

html_theme_options = {
    'repo_name': 'chipsalliance/f4pga-examples',
    'github_url' : 'https://github.com/chipsalliance/f4pga-examples',
    'globaltoc_collapse': True,
    'color_primary': 'indigo',
    'color_accent': 'blue',
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

html_logo = str(Path(html_static_path[0]) / 'logo.svg')
html_favicon = str(Path(html_static_path[0]) / 'favicon.svg')

# -- Collect READMEs from examples -----------------------------------------------------------------

from collect_readmes import families, fill_context

jinja_contexts = {}
top_dir = Path(__file__).resolve().parent.parent
for family in families:
    examples = os_scandir(str(top_dir / family))
    for example in examples:
        path = top_dir / family / example / 'README.rst'
        if example.is_dir() and path.is_file():
            with path.open('r') as frptr:
                jinja_contexts['_'.join((family, example.name))] = {'blocks': fill_context(frptr.read())}

# -- Sphinx.Ext.InterSphinx ------------------------------------------------------------------------

intersphinx_mapping = {
   'python':     ('https://docs.python.org/3.6/', None),
   'f4pga':      ('https://f4pga.readthedocs.io/en/latest/', None),
   'arch-defs':  ('https://f4pga.readthedocs.io/projects/arch-defs/en/latest/', None),
   'fasm':       ('https://fasm.readthedocs.io/en/latest/', None),
   'prjtrellis': ('https://prjtrellis.readthedocs.io/en/latest/', None),
   'prjxray':    ('https://f4pga.readthedocs.io/projects/prjxray/en/latest/', None),
   'vtr':        ('https://docs.verilogtorouting.org/en/latest/', None),
}

# -- Sphinx.Ext.ExtLinks ---------------------------------------------------------------------------

extlinks = {
   'wikipedia': ('https://en.wikipedia.org/wiki/%s', 'wikipedia:'),
   'gh':        ('https://github.com/%s', 'gh:'),
   'ghsharp':   ('https://github.com/chipsalliance/f4pga-examples/issues/%s', '#'),
   'ghissue':   ('https://github.com/chipsalliance/f4pga-examples/issues/%s', 'issue #'),
   'ghpull':    ('https://github.com/chipsalliance/f4pga-examples/pull/%s', 'pull request #'),
   'ghsrc':     ('https://github.com/chipsalliance/f4pga-examples/blob/master/%s', '')
}
