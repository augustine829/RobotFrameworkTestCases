*** Settings ***
Suite Setup       Wait For Adb Device
Resource          common.robot

*** Test Cases ***
Adb Device Shall Be Available
    [Tags]    smoke
    ${result} =    Execute Linux Command    adb devices
    ${result} =    Get Line Count    ${result}
    Should Be Equal As Integers    ${result}    2

Adb Device Shall Reboot
    [Tags]    smoke
    Reboot Adb Device
    Wait For Adb Device
