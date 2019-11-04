# -*- coding: utf-8 -*-

from __future__ import absolute_import

import os
import subprocess

def convert_bytes(num):
    """
    this function will convert bytes to MB.... GB... etc
    """
    for x in ['bytes', 'KB', 'MB', 'GB', 'TB']:
        if num < 1024.0:
            return "%3.1f%s" % (num, x)
        num /= 1024.0

def space(pl):
	docker_dir = os.path.expanduser('~/Library/Containers/com.docker.docker/Data/')
	size = float(subprocess.getoutput('gdu -cbs %s' % docker_dir).split()[0])
	ret = []
	alert = 'status'

	if (size / 10737418240) > 40:
		alert = 'caution'

	if (size / 10737418240) > 55:
		alert = 'critical'


	ret.append({
		'contents': '%s' % convert_bytes(size),
		'highlight_groups': ['docker_space:%s' % alert],
		'divider_highlight_group': 'background:divider'
	})

	return ret



