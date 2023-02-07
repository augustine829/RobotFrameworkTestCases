*** Settings ***
Suite Setup       Wait For Adb Device
Resource          common.robot

*** Test Cases ***
Device Shall Run MMC Test
    [Tags]    experimental
    Run MMC Test

Device Shall Run MMC Test Continuously In Loop
    [Tags]    experimental
    Run Test In Loop    Run MMC Test    100
