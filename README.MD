Create Tag Batches
==================

![This script was last tested in Nuix 7.8](https://img.shields.io/badge/Script%20Tested%20in%20Nuix-7.8-green.svg)

View the GitHub project [here](https://github.com/Nuix/Create-Tag-Batches) or download the latest release [here](https://github.com/Nuix/Create-Tag-Batches/releases).

# Overview

**Written By:** Jason Wells

This script allows you to tag items in batches based on number of items or number of batches.

# Getting Started

## Setup

Begin by downloading the latest release of this code.  Extract the contents of the archive into your Nuix scripts directory.  In Windows the script directory is likely going to be either of the following:

- `%appdata%\Nuix\Scripts` - User level script directory
- `%programdata%\Nuix\Scripts` - System level script directory

## Usage

Before running this script you need to select the items which you would like included in tag batches.  It is important to note that this script will only include those selected items in the review jobs, so if you wish to include family items for example, <u>you need to make sure family members are part of your selection before running the script</u>.

Once you have selected some items and started the script, an input dialog will be displayed to collect the following information:

- **Tag Name Prefix:**  This script will creates the tags using this prefix and a sequential 4 fill zero padded number.  For example if you provide the prefix `Batch|` you will get batch names like:  
`Batch|0001`, `Batch|0002`, `Batch|0003`, etc.
- **Batch Size:** This setting determines batch size.  It is determined in the number of top level items per batch.  For example if you included family items, this would essentially be the number of families per batch, as determined by the top level items.
- **Batch Count:**  This setting determines number of batches.  It divides the items into batches with (roughly) the same number of top level items per batch.

The script will display a progress dialog while the tag batches are being applied.

## Cloning this Repository

This script relies on code from [Nx](https://github.com/Nuix/Nx) to present a settings dialog and progress dialog.  This JAR file is not included in the repository (although it is included in release downloads).  If you clone this repository, you will also want to obtain a copy of Nx.jar by either:
1. Building it from [the source](https://github.com/Nuix/Nx)
2. Downloading an already built JAR file from the [Nx releases](https://github.com/Nuix/Nx/releases)

Once you have a copy of Nx.jar, make sure to include it in the same directory as the script.

# License

```
Copyright 2019 Nuix

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```