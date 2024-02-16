@echo off

rem Open the txt file given as a parameter.
set txt_file=partitions.txt

rem Set the specified partitions to be skipped as a list.
set skipme=userdata system super

REM Get the ro.product.device value of the device using the ADB command.
for /f "delims=" %%i in ('adb shell getprop ro.product.device') do set CODENAME=%%i

REM Get the serial number of the device using the ADB command.
for /f "delims=" %%i in ('adb get-serialno') do set SERIALNO=%%i

REM If CODENAME or SERIALNO variables are empty, print an error message.
if not defined CODENAME (
    echo Error: Device information could not be obtained.
    exit /b 1
)

if not defined SERIALNO (
    echo Error: Serial number could not be obtained.
    exit /b 1
)

REM Create a folder with the name CODENAME-SERIALNO.
set FOLDER_NAME=%CODENAME%-%SERIALNO%
mkdir %FOLDER_NAME%

rem Process each line using a for loop.
for /f "delims=" %%i in (%txt_file%) do (
    set "skip_partition="
    for %%x in (%skipme%) do (
        if /i "%%i"=="%%x" set skip_partition=true
    )

    rem Check the specified partitions and perform the relevant actions.
    if defined skip_partition (
        echo Skipping %%i as specified in the condition.
    ) else (
        rem In other cases, execute the specified commands.
        adb shell dd if=/dev/block/bootdevice/by-name/%%i of=/tmp/%%i.img
        adb pull /tmp/%%i.img %FOLDER_NAME%/%%i.img
        adb shell rm /tmp/%%i.img

        rem Notify that the operation has been completed.
        echo %%i successfully pulled
    )
)
pause
