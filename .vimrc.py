#!/usr/bin/env python
# -*- coding: utf-8 -*-
import argparse
import vim

def fzfFind(argsString):
    parser = argparse.ArgumentParser()
    parser.add_argument("-v", "--verbosity", action="store_true", help="increase output verbosity")
    parser.add_argument("search", help="search string")
    args = parser.parse_args([argsString])
    print('the search string is '+args.search)
    vim.command("call fzf#vim#grep('rg --column --line-number --no-heading --smart-case --follow --color \"always\" {0}', 1, 0)".format(args.search))
