*** Settings ***
Suite Setup       Set Up Software Update
Suite Teardown    Clean Up
Resource          common.robot

*** Test Cases ***
Device Shall Update Software
    [Tags]    smoke
    Perform Software Update

*** Test Cases ***
Device Shall Update Software in Loop
    [Tags]    stress    testing
    Run Test In Loop    Perform Software Update    100
