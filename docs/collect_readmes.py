import os
from docutils.core import publish_doctree


full_name_lut = {
    'a35t': 'Arty 35T',
    'a100t': 'Arty 100T',
    'basys3': 'Basys 3',
    'eos_s3': 'EOS S3',
    'zybo': 'Zybo Z7',
    'nexys_video': 'Nexys Video',
}
families = ('xc7', 'eos-s3')
inlines = ('literal', 'strong', 'reference')


def handle_default_with_inlines(block):
    """
     Extracts information from a block that contains inline blocks in
     its subtree. The text from the block is combined with the contents
     of the inline blocks. This is used, i.e., when the code is inserted
     in the text with `` marks.

    Args:
      block: A block with a inline block in the subtree

    Returns: A dictionary with the extracted information

    """
    text = ""
    for node in block.traverse(include_self=False, condition=lambda x:
                               x.parent.tagname.strip() not in inlines):
        tagname = node.tagname.strip()
        if tagname in ('paragraph',):
            continue

        if tagname == 'literal':
            text += f'``{node.astext()}``'
        elif tagname == 'strong':
            text += f'**{node.astext()}**'
        elif tagname == 'reference':
            text += f'`{node.astext()} <{node["refuri"]}>`_'
        else:
            text += node.astext()

    ret = {}
    ret['type'] = block.tagname.strip()
    ret['text'] = text

    return ret


def subtree_has_tag(block, tagname):
    """
    Check if the doctree node contains a particular tag in its subtree.

    Args:
      block: A block that has to be checked
      tagname: The searched tag

    Returns: True if the subtree contains a node with the tagname or False otherwise.

    """

    for node in block.traverse(include_self=False):
        if node.tagname.strip() == tagname:
            return True

    return False


def handle_title(block):
    """
    Extracts information from a title block (from a README doctree).

    Args:
      block: A title doctree block

    Returns: A dictionary with the extracted information

    """

    ret = {
        'type': 'title',
        'text': '\n'.join((block.astext(), '~' * 20)),
    }

    return ret


def handle_img(block):
    """
    Extracts information from an image block (from a README doctree).

    Args:
      block: An image doctree block

    Returns: A dictionary with the extracted information

    """

    ret = {}
    ret['type'] = 'image'
    ret['uri'] = os.path.join(*block['uri'].split('/')[3:])
    ret['align'] = block.get('align', 'center')
    ret['width'] = block.get('width', '100%')

    return ret


def handle_literal_block(block):
    """
    Extracts information from a literal block (from a README doctree).

    Args:
      block: A literal doctree block

    Returns: A dictionary with the extracted information

    """

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
    """
    Extracts information from a note block (from a README doctree).
    If the block contain inline block in its subtree, the data from that block
    will also be extracted.

    Args:
      block: A note doctree block

    Returns: A dictionary with the extracted information

    """
    ret = {}
    ret['type'] = block.tagname.strip()

    if sum(map(lambda x: subtree_has_tag(block, x), inlines)):
        for node in block.traverse(condition=lambda x:
                                   x.tagname.strip() == 'paragraph'):
            ret['text'] = handle_default_with_inlines(node)['text']
    else:
        ret['text'] = block.astext()

    ret['text'] = ret['text'].split('\n')

    return ret


def handle_default(block):
    """
    Extracts information from doctree blocks that need not be handled in
    a special way. Nevertheless, if the block contains a inline block,
    the informaton from that block will also be extracted.

    Args:
      block: A doctree block

    Returns: A dictionary with the extracted information

    """
    if sum(map(lambda x: subtree_has_tag(block, x), inlines)):
        return handle_default_with_inlines(block)

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
    """
    Get a traversed README doctree

    Args:
      text: Text of the example's README

    Returns: Returns an iterable containing the README document structure
             See `traverse` implementation in docutils/nodes.py for more details.

    """
    doctree = publish_doctree(text)

    return doctree.traverse(condition=lambda x: x.tagname.strip() != 'document'
                            and x.parent.tagname.strip() != 'note')


def fill_context(text):
    """
    Creates a jinja context dictionary for a SymbiFlow Toolchain usage example.
    The dictionary contains all the important information from the example's README.

    Args:
      text: Text of the example's README

    Returns: A context dictionary that should be added to the main jinja_contexts

    """
    ret = []

    start_group = False
    in_group = False
    for block in get_blocks(text):
        tagname = block.tagname.strip()

        # do not process those
        if tagname in ('#text', 'inline') + inlines:
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
