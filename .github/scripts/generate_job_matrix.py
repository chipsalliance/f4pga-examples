#!/usr/bin/env python3

from sys import argv as sys_argv

isFork = len(sys_argv)>1 and sys_argv[1] != 'SymbiFlow/symbiflow-examples'

runs_on = (
    'ubuntu-latest'
    if isFork else
    ['self-hosted', 'Linux', 'X64']
)

examples = [
    "counter",
    "picosoc",
    "litex",
    "litex_linux",
    "litex_sata",
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
    ("ubuntu", "focal"),
    ("centos", "8"),
    ("debian", "buster"),
    ("debian", "bullseye"),
    ("debian", "sid"),
    ("fedora", "35")
]

if not isFork:
    osvers += [
        ("ubuntu", "xenial"),
        ("ubuntu", "bionic"),
        ("centos", "7"),
    ]

for osver in osvers:
    jobs += [{
        'runs-on': runs_on,
        'fpga-fam': "xc7",
        'os': osver[0],
        'os-version': osver[1],
        'example': example
    } for example in examples]

jobs += [{
    'runs-on': runs_on,
    'fpga-fam': "eos-s3",
    'os': osver[0],
    'os-version': osver[1],
    'example': "counter"
} for osver in osvers]

print(f'::set-output name=matrix::{jobs!s}')

print(str(jobs))
