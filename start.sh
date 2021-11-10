#!/bin/bash
indexer --config /etc/sphinxsearch/sphinx.conf --all
exec searchd --nodetach --config /etc/sphinxsearch/sphinx.conf
