*** Settings ***
Library           Process
Library           String

*** Variables ***
${TMP_DIR}        ${OUTPUT_DIR}/tmp_robot
${OTA_LOC}        /update/ota
${ROBOT_LOG}      ${OUTPUT_DIR}/robot.log
${PACKAGE_LINK}   http://10.28.32.203:8080/job/SILVER-CE-4.1-BSP-ENG-TEAM/lastSuccessfulBuild/artifact/*zip*/archive.zip

*** Keywords ***
Execute Linux Command
    [Arguments]    ${command}    ${work_dir}=${CURDIR}/../..
    ${result} =    Run Process    ${command}    shell=true    cwd=${work_dir}    stdout=${ROBOT_LOG}    stderr=STDOUT
    Log To Console    ${result.stdout}
    Should Be Equal As Integers    ${result.rc}    0    msg=${result.stderr}
    [Return]    ${result.stdout}

Run Adb Shell Command
    [Arguments]    ${command}
    ${result} =    Execute Linux Command    adb shell ${command}
    ${result2} =    Execute Linux Command    echo $?
    Should Be Equal As Integers    ${result2}    0    msg=${result}
    [Return]    ${result}

Wait For Adb Device
    [Timeout]    10 minute
    Execute Linux Command    adb start-server
    Execute Linux Command    adb wait-for-device

Power Off Device
    Execute Linux Command    adb reboot -p

Reboot Adb Device
    Execute Linux Command    adb reboot

Reboot And Wait For Device
    Reboot Adb Device
    Wait For Adb Device

Print BSP Properties
    ${result} =    Run Adb Shell Command    getprop
    Log    BSP Properties = ${result}
    [Return]    ${result}

Set Up Software Update
    Execute Linux Command    echo "DEBUG"
    Execute Linux Command    mkdir -p ${TMP_DIR}
    Execute Linux Command    echo "TMP_DIR=${TMP_DIR}"
    Execute Linux Command    ls -al ${TMP_DIR}
    Execute Linux Command    mkdir -p archive     ${TMP_DIR}
    Execute Linux Command    wget --no-verbose ${PACKAGE_LINK}   ${TMP_DIR}/archive
    Execute Linux Command    ls -al archive      ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-1"
    Execute Linux Command    mkdir -p apk        ${TMP_DIR}/archive
    Execute Linux Command    ls -al    ${TMP_DIR}
    Execute Linux Command    unzip -o archive.zip    ${TMP_DIR}/archive
    Execute Linux Command    ls -al    ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-2"
    Execute Linux Command    chmod 755 generate_ota.sh    ${TMP_DIR}/archive
    Execute Linux Command    wget --no-verbose http://10.28.32.203:8080/job/CE-4.1-APK-TEAM/lastSuccessfulBuild/artifact/*zip*/archive.zip -O apk.zip    ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-3"
    Execute Linux Command    ls -al    ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-4"
    Execute Linux Command    ls -al archive    ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-5"
    Execute Linux Command    unzip -o apk.zip -d apk    ${TMP_DIR}
    Execute Linux Command    cp apk/services/CoreServices/build/outputs/apk/A/debug/CoreServices-*-debug.apk archive/apk    ${TMP_DIR}
    Execute Linux Command    cp apk/services/HDPClientServices/build/outputs/apk/A/debug/HDPClientServices-*-debug.apk archive/apk    ${TMP_DIR}
    Execute Linux Command    cp apk/services/NetworkingServices/build/outputs/apk/A/debug/NetworkingServices-*-debug.apk archive/apk    ${TMP_DIR}
    Execute Linux Command    cp apk/services/PlumProxyServices/build/outputs/apk/A/debug/PlumProxyServices-*-debug.apk archive/apk    ${TMP_DIR}
    Execute Linux Command    cp apk/services/WebServices/build/outputs/apk/A/debug/WebServices-*-debug.apk archive/apk    ${TMP_DIR}
    Execute Linux Command    ls -al apk    ${TMP_DIR}/archive
    Execute Linux Command    echo "DEBUG-6"
Perform Software Update
    ${time} =    get Time    epoch
    ${time_string} =    Convert To String    ${time}
    Execute Linux Command    pwd
    Execute Linux Command    echo "DEBUG-7"
    Execute Linux Command    ls -al
    Execute Linux Command    echo ${TMP_DIR}
    Execute Linux Command    echo "DEBUG-8"
    Execute Linux Command    ls -al    ${TMP_DIR}/apk
    Execute Linux Command    ${TMP_DIR}/archive/generate_ota.sh -h
    Execute Linux Command    echo "DEBUG-9"
    Execute Linux Command    ${TMP_DIR}/archive/generate_ota.sh --type ${time_string}    ${TMP_DIR}/archive
    Execute Linux Command    echo "DEBUG-10"
    Run Adb Shell Command    update_ab -c
    Run Adb Shell Command    update_ab -r
    Print BSP Properties
    Push File Over ADB    ${TMP_DIR}/archive/myota-${time_string}-imx7d-p2.zip    ${OTA_LOC}
    Run Adb Shell Command    update_ab -l ${OTA_LOC}/myota-${time_string}-imx7d-p2.zip -f 1
    Execute Linux Command    adb reboot
    Wait For Adb Device
    sleep    120s    Waiting for device to boot up
    Execute Linux Command    rm -rf ${TMP_DIR}/archive/myota-${time_string}-imx7d-p2.zip
    Run Adb Shell Command    rm -f ${OTA_LOC}/*
    ${result} =    Run Adb Shell Command    update_ab -s
    Should Contain    ${result}    Last Update State: SUCCESS
    ${result} =    Print BSP Properties
    Should Contain    ${result}    ${time_string}

Push File Over Adb
    [Arguments]    ${file}    ${loc}
    Execute Linux Command    adb push ${file} ${loc}

Set Up CTS
    Wait For Adb Device
    Execute Linux Command    mkdir -p ${TMP_DIR}
    Execute Linux Command    wget --no-verbose http://git.icumed.com:8080/jenkins/view/SILVER/job/SILVER-CE-CTS/lastSuccessfulBuild/artifact/out/artifacts/android-cts.zip   ${TMP_DIR}
    Execute Linux Command    unzip -o android-cts.zip    ${TMP_DIR}

Clean Up
    Execute Linux Command    rm -rf ${TMP_DIR}
    Run Adb Shell Command    rm -f ${OTA_LOC}/*
    Execute Linux Command    adb kill-server

Run CTS Module
    [Arguments]    ${module}
    ${result} =    Execute Linux Command    ./cts-tradefed run cts-dev -m ${module}    ${TMP_DIR}/android-cts/tools
    Should Contain    ${result}    FAILED: 0, NOT EXECUTED: 0

Verify Apk Boot
    Reboot Adb Device
    Wait For Adb Device
    sleep    90s    Waiting for device to boot up
    ${result} =    Execute Linux Command    adb logcat -d -s BoundServiceContainersLifecycle
    Should Contain    ${result}    All Containers Successfully Registered, System Bootup completed

Run MMC Test
    Wait For Adb Device
    Power Off Device
    Reset Power Supply
    Wait For Adb Device
    sleep    40s    Waiting for device to boot up
    ${result} =    Run Adb Shell Command    console.sh --disable
    Should Contain    ${result}    Console disabled
    ${result} =    Run Adb Shell Command    console.sh --enable
    Should Contain    ${result}    Console enabled
    ${result} =    Run Adb Shell Command    ping -c 4 169.254.1.100
    Should Contain    ${result}    0% packet loss
    ${result} =    Run Adb Shell Command    ping -c 4 169.254.2.100
    Should Contain    ${result}    0% packet loss

Reset Power Supply
    ${result} =    Execute Linux Command    python3 ${CURDIR}/../TP3005P.py /dev/ttyUSB0 17 3
    Should Contain    ${result}    Output On

Run Test In Loop
    [Arguments]    ${test}    ${count}
    FOR    ${index}    IN RANGE    ${count}
        ${result}=    Run Keyword and Return Status    ${test}
        Run Keyword If    ${result} is ${FALSE}    Exit For Loop
        Log To Console    Loop number ${index+1} successful
    END
    Should Be Equal As Integers    ${index+1}    ${count}
