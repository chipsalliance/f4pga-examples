# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- Project information -----------------------------------------------------

project = u'SymbiFlow examples'
authors = u'SymbiFlow'
copyright = authors + u', 2020'

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx_tabs.tabs',
    'sphinxcontrib.jinja',
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#

html_show_sourcelink = True
html_sidebars = {
    "**": ["logo-text.html", "globaltoc.html", "localtoc.html", "searchbox.html"]
}

html_theme = 'sphinx_material'
html_theme_options = {
    'nav_title': project,
    'color_primary': 'deep-purple',
    'color_accent': 'purple',
    'repo_name': "antmicro/symbiflow-examples",
    'repo_url': 'https://github.com/antmicro/symbiflow-examples',
    'globaltoc_depth': 2,
    'globaltoc_collapse': True
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
# html_static_path = ['_static']

import os
from docutils.core import publish_doctree


full_name_lut = {
    'a35t': 'Arty 35T',
    'a100t': 'Arty 100T',
    'basys3': 'Basys 3',
    'eos_s3': 'EOS S3',
}
families = ('xc7', 'eos-s3')


def handle_default_with_literals(block):
    text = ""

    for node in block.traverse(include_self=False, condition=lambda x:
                               x.parent.tagname.strip() != 'literal'):
        tagname = node.tagname.strip()
        if tagname in ('paragraph',):
            continue

        if tagname == 'literal':
            text = text + '``' + node.astext() + '``'
        else:
            text = text + node.astext()

    ret = {}
    ret['type'] = block.tagname.strip()
    ret['text'] = text

    return ret


def subtree_has_tag(block, tagname):
    for node in block.traverse(include_self=False):
        if node.tagname.strip() == tagname:
            return True

    return False


def handle_title(block):
    ret = {
        'type': 'title',
        'text': '\n'.join((block.astext(), '~' * 20)),
    }

    return ret


def handle_img(block):
    ret = {}
    ret['type'] = 'image'
    ret['uri'] = os.path.join(*block['uri'].split('/')[3:])
    ret['align'] = block.get('align', 'center')
    ret['width'] = block.get('width', '100%')

    return ret


def handle_literal_block(block):
    ret = {}
    ret['type'] = 'literal_block'
    ret['text'] = block.astext().split('\n')
    ret['classes'] = block['classes']

    try:
        ret['name'] = full_name_lut[''.join(block['names']).split('-')[2]]
    except:
        ret['name'] = ''

    return ret


def handle_note(block):
    ret = {}
    ret['type'] = block.tagname.strip()

    if subtree_has_tag(block, 'literal'):
        for node in block.traverse(condition=lambda x:
                                   x.tagname.strip() == 'paragraph'):
            ret['text'] = handle_default_with_literals(node)['text']
    else:
        ret['text'] = block.astext()

    ret['text'] = ret['text'].split('\n')

    return ret


def handle_default(block):
    if subtree_has_tag(block, 'literal'):
        return handle_default_with_literals(block)

    ret = {}
    ret['type'] = block.tagname.strip()
    ret['text'] = block.astext()

    return ret


handle_block_funcs = {
    'title': handle_title,
    'image': handle_img,
    'literal_block': handle_literal_block,
    'note': handle_note,
    'default': handle_default,
}


def get_blocks(text):
    doctree = publish_doctree(text)

    return doctree.traverse(condition=lambda x: x.tagname.strip() != 'document'
                            and x.parent.tagname.strip() != 'note')


def fill_context(text):
    ret = []

    start_group = False
    in_group = False
    for block in get_blocks(text):
        tagname = block.tagname.strip()

        # do not process those
        if tagname in ('#text', 'inline', 'literal'):
            continue

        # try do get handler; if not found, use the default one
        if tagname not in handle_block_funcs.keys():
            handler = 'default'
        else:
            handler = tagname

        entry = handle_block_funcs[handler](block)

        # internal logic for grouping code blocks into tab groups
        if tagname == 'literal_block' and 'group' in ''.join(block['names']):
            if not in_group:
                start_group = True
                in_group = True
            else:
                start_group = False
                in_group = True
        else:
            in_group = False
            start_group = False

        entry['start_group'] = start_group
        entry['in_group'] = in_group

        ret.append(entry)

    return ret


# register examples
jinja_contexts = {}
top_dir = os.path.join(os.path.dirname(__file__), '..')
for family in families:
    examples = os.scandir(os.path.join(top_dir, family))
    for example in examples:
        if example.is_dir():

            # get README
            path = os.path.join(top_dir, family, example, 'README.rst')

            # skip if file does not exist
            if not os.path.isfile(path):
                continue

            with open(path) as f:
                text = f.read()

            key = '_'.join((family, example.name))
            jinja_contexts[key] = {'blocks': fill_context(text)}
