# Android-Full-Partition-Backup

This project consists of two batch scripts designed to facilitate the backup of specified partitions from an Android device using the Android Debug Bridge (ADB). The scripts automate the process of obtaining a list of partitions and selectively backing them up.

## Prerequisites

- ADB installed on your system and added to the system's PATH.
- Connected Android device with USB debugging enabled and root or Custom Recovery (TWRP, OrangeFOX, etc...)

## Scripts

### 1. get-partition-names.bat

#### Overview

This script simplifies the process of obtaining a list of partitions from an Android device. It runs an ADB command to list the partitions under `/dev/block/bootdevice/by-name/` and saves the result in a text file named `partitions.txt`.

#### Usage

1. Ensure your Android device is connected to your computer.
2. Run `get-partition-names.bat` from the command line.


### 2. device-backup.bat

#### Overview

This script automates the backup of specified partitions from an Android device. It reads a list of partitions from a text file (`partitions.txt` by default), skips specified partitions, and creates a backup folder with a name based on the device's codename and serial number.

#### Usage

1. Ensure your Android device is connected to your computer.
2. Edit the `partitions.txt` file to include the partitions you want to backup, each on a new line.
3. Run `device-backup.bat` from the command line.

#### Important Notes

- Review and customize the `skipme` variable to exclude any partitions you don't want to backup.
- The script creates a folder named `CODENAME-SERIALNO` (e.g., `device-12345678`) and saves individual partition backups inside it.


#### Important Note

- This script only retrieves the list of partitions and does not perform any actions on the device.

## Additional Information

- Make sure to have the necessary permissions to access the device via ADB.
- For any issues or inquiries, feel free to reach out.
