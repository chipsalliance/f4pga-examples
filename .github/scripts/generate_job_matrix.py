#!/usr/bin/env python3

examples = [
    "counter",
    "picosoc",
    "litex",
    "litex_linux",
    "button_controller",
    "pulse_width_led",
    "timer",
    "hello-a",
    "hello-b",
    "hello-c",
    "hello-d",
    "hello-e",
    "hello-f",
    "hello-g",
    "hello-h",
    "hello-i",
    "hello-j",
    "hello-k",
    "hello-l"
]

jobs = []

osvers = [
    ("ubuntu", "xenial"),
    ("ubuntu", "bionic"),
    ("ubuntu", "focal"),
    ("centos", "7"),
    ("centos", "8"),
    ("debian", "buster"),
    ("debian", "bullseye"),
    ("debian", "sid")
]

for osver in osvers:
    jobs += [{
        'fpga-fam': "xc7",
        'os': osver[0],
        'os-version': osver[1],
        'example': example
    } for example in examples]

jobs += [{
    'fpga-fam': "eos-s3",
    'os': osver[0],
    'os-version': osver[1],
    'example': "counter"
} for osver in osvers]

print('::set-output name=matrix::' + str(jobs))
