#!/usr/bin/env python3
#
# Copyright (C) 2021-2022 F4PGA Authors
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

from os import environ
from sys import argv as sys_argv

registry = 'ghcr.io/chipsalliance/f4pga/dev/conda'

isFork = len(sys_argv)>1 and sys_argv[1] != 'chipsalliance/f4pga-examples'

runs_on = (
    'ubuntu-latest'
    if isFork else
    ['self-hosted', 'Linux', 'X64']
)


def get_jobs(
    distribution: str = 'debian',
    usesSurelog: bool = False
):
    examples = [
        "pulse_width_led",
        "hello",
    ]

    # Skip tests that are currently unsupported
    if not usesSurelog:
        examples.extend([
            "litex",
            "picosoc",
            "litex_linux",
            "button_controller",
            "timer",
            "hello-k",
        ])

    jobs = []
    osvers = []

    if distribution == "debian":
        osvers.extend([
            ("debian", "buster"),
            ("debian", "bullseye"),
            ("debian", "sid")
        ])
    elif distribution == "ubuntu":
        osvers.extend([
            ("ubuntu", "focal")
        ])
    elif distribution == "fedora":
        osvers.extend([
            ("fedora", "35"),
            ("fedora", "36")
        ])

    if not isFork:
        examples.extend(["counter"])

        # Skip tests that are currently unsupported
        if not usesSurelog:
            examples.extend(["litex_sata"])

        if distribution == "ubuntu":
            osvers.extend([
                ("ubuntu", "xenial"),
                ("ubuntu", "bionic"),
            ])
        elif distribution == "centos":
            osvers.extend([
                ("centos", "7")
            ])

    for osver in osvers:
        jobs.extend([{
            'name': ("Surelog" if usesSurelog else "Default") + f' | xc7 | {osver[0]}/{osver[1]} | {example}',
            'runs-on': runs_on,
            'fpga-fam': "xc7",
            'image': f'{registry}/{osver[0]}/{osver[1]}/xc7',
            'example': example,
            'surelog': "-parse -DSYNTHESIS" if usesSurelog else ""
        } for example in examples])

    jobs.extend([{
        'name': ("Surelog" if usesSurelog else "Default") + f' | eos-s3 | {osver[0]}/{osver[1]} | counter',
        'runs-on': runs_on,
        'fpga-fam': "eos-s3",
        'image': f'{registry}/{osver[0]}/{osver[1]}/eos-s3',
        'example': "counter",
        'surelog': "-parse -DSYNTHESIS" if usesSurelog else ""
    } for osver in osvers])

    return jobs

for distribution in ['debian', 'ubuntu', 'fedora', 'centos']:
    jobs = get_jobs(distribution, False) + get_jobs(distribution, True)
    print(f'::set-output name={distribution}::{jobs!s}')
    print(f"{distribution}: {jobs!s}")

utils = {
    'ubuntu': 'apt -qqy update && apt -qqy install wget locales patch && locale-gen $LANG',
    'debian': 'apt -qqy update && apt -qqy install wget locales patch && locale-gen $LANG',
    'centos': 'yum -y install wget patch',
    'fedora': 'dnf install -y wget patch'
}

images = [
    {
        'registry': f'{registry}',
        'image': f'{osver[0]}/{osver[1]}/{fam}',
        'from': f'{osver[0]}:{osver[1]}',
        'utils': utils[osver[0]],
        'args': f'{fam} {osver[0]}'
    } for osver in [
        ("debian", "buster"),
        ("debian", "bullseye"),
        ("debian", "sid"),
        ("fedora", "35"),
        ("fedora", "36"),
        ("ubuntu", "xenial"),
        ("ubuntu", "bionic"),
        ("ubuntu", "focal"),
        ("centos", "7")
    ] for fam in ['xc7', 'eos-s3']
]

print(f'::set-output name=images::{images!s}')
print(f"images: {images!s}")
