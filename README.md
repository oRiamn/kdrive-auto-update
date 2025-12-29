
# kDrive Auto Update

This script checks if a new version of the kDrive client is available on Debian, and automatically downloads and installs the update if necessary.

## Features

- Checks the installed version of the kDrive client.
- Compares the installed version with the latest available version.
- Downloads and installs the update automatically if a newer version is available.

## Prerequisites

-  Debian-based system (e.g., Debian, Ubuntu).    
-  `curl` or `wget` for downloading the updates.
    
## Installation

### Method 1: Run the installation command directly

You can install and run the script directly by executing the following command in your terminal:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/oRiamn/kdrive-auto-update/refs/heads/master/install.sh)
``` 

This command downloads and automatically runs the installation script.

### Method 2: Clone the repository and run the script manually

If you prefer to clone the repository and run the script manually, follow these steps:

1. Clone the repository and give execute permissions to the `launcher.sh` script
    

```bash
git clone https://github.com/oRiamn/kdrive-auto-update.git
cd kdrive-auto-update
```

2. Give execute permissions to the `launcher.sh` and run the script:
    
```bash
chmod +x launcher.sh
`./launcher.sh
``` 

## Usage

Once installed, the script automatically checks for updates to the kDrive client. 
If an update is found, it will be downloaded and installed.

## Customization

The script is configurable for various use cases. You can modify the update options or even schedule the script to run automatically at regular intervals (e.g., using `cron`).

### Example usage with `cron`:

To have the script check for updates every day at 2 AM, add the following entry to your `crontab`:

`crontab -e` 

Then, add this line:

`0 2 * * * /home/youruser/.local/bin/kdrive-auto-update` 

## Contribution

Contributions are welcome! If you'd like to improve this script, feel free to fork the project and submit a pull request.

