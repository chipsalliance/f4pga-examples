#!/usr/bin/env python3

examples = [
    "counter",
]

jobs = []

osvers = [
    ("centos", "7"),
]

for osver in osvers:
    jobs += [{
        'fpga-fam': "xc7",
        'os': osver[0],
        'os-version': osver[1],
        'example': example
    } for example in examples]

print('::set-output name=matrix::' + str(jobs))
