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
        "litex",
        "button_controller",
        "timer",
    ]

    # Skip tests that are currently unsupported
    if not usesSurelog:
        examples.extend([
            "picosoc",
            "litex_linux",
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
        examples.extend([
            "counter",
            "litex_sata"
        ])

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
            'name': "Surelog" if usesSurelog else "Default",
            'runs-on': runs_on,
            'fpga-fam': "xc7",
            'os': osver[0],
            'os-version': osver[1],
            'example': example,
            'surelog': "-parse -DSYNTHESIS" if usesSurelog else ""
        } for example in examples])

    jobs.extend([{
        'name': "Surelog" if usesSurelog else "Default",
        'runs-on': runs_on,
        'fpga-fam': "eos-s3",
        'os': osver[0],
        'os-version': osver[1],
        'example': "counter",
        'surelog': "-parse -DSYNTHESIS" if usesSurelog else ""
    } for osver in osvers])

    return jobs

for distribution in ['debian', 'ubuntu', 'fedora', 'centos']:
    jobs = get_jobs(distribution, False) + get_jobs(distribution, True)
    print(f'::set-output name={distribution}::{jobs!s}')
    print(f"{distribution}: {jobs!s}")
