*** Settings ***
Suite Setup       Update Software
Suite Teardown    Clean Up
Resource          common.robot
Force Tags        comprehensive

*** Variables ***
${UPDATED}        False

*** Keywords ***
Update Software
    Clean Up
    Return From Keyword If    '${UPDATED}'=='True'
    Set Up Software Update
    Perform Software Update
    Set Global Variable    ${UPDATED}    True