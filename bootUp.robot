*** Settings ***
Suite Setup       Wait For Adb Device
Resource          common.robot

*** Test Cases ***
Device Shall Boot Apks
    [Tags]    smoke
    Verify Apk Boot

Device Shall Boot Apks Continuously In Loop
    [Tags]    stress
    Run Test In Loop    Verify Apk Boot    10
