*** Settings ***
Suite Setup       Set Up CTS
Suite Teardown    Clean Up
Resource          common.robot

*** Test Cases ***
Device Shall Pass CtsPrintTestCases
    [Tags]    stress
    Run CTS Module    CtsPrintTestCases

*** Test Cases ***
Device Shall Pass CtsFileSystemTestCases
    [Tags]    stress
    Run CTS Module    CtsFileSystemTestCases

*** Test Cases ***
Device Shall Pass CtsSimpleCpuTestCases
    [Tags]    stress
    Run CTS Module    CtsSimpleCpuTestCases

*** Test Cases ***
Device Shall Pass CtsCarrierApiTestCases
    [Tags]    stress
    Run CTS Module    CtsCarrierApiTestCases

*** Test Cases ***
Device Shall Pass CtsAppWidgetTestCases
    [Tags]    stress
    Run CTS Module    CtsAppWidgetTestCases

*** Test Cases ***
Device Shall Pass CtsSignatureTestCases
    [Tags]    stress
    Run CTS Module    CtsSignatureTestCases

*** Test Cases ***
Device Shall Pass CtsBluetoothTestCases
    [Tags]    stress
    Run CTS Module    CtsBluetoothTestCases

*** Test Cases ***
Device Shall Pass CtsCompilationTestCases
    [Tags]    stress
    Run CTS Module    CtsCompilationTestCases

*** Test Cases ***
Device Shall Pass CtsDatabaseTestCases
    [Tags]    stress
    Run CTS Module    CtsDatabaseTestCases

*** Test Cases ***
Device Shall Pass CtsNetSecConfigAttributeTestCases
    [Tags]    stress
    Run CTS Module    CtsNetSecConfigAttributeTestCases

*** Test Cases ***
Device Shall Pass CtsDeviceAdminUninstallerTestCases
    [Tags]    stress
    Run CTS Module    CtsDeviceAdminUninstallerTestCases

*** Test Cases ***
Device Shall Pass CtsHostsideNumberBlockingTestCases
    [Tags]    stress
    Run CTS Module    CtsHostsideNumberBlockingTestCases

*** Test Cases ***
Device Shall Pass CtsSaxTestCases
    [Tags]    stress
    Run CTS Module    CtsSaxTestCases

*** Test Cases ***
Device Shall Pass CtsCppToolsTestCases
    [Tags]    stress
    Run CTS Module    CtsCppToolsTestCases

*** Test Cases ***
Device Shall Pass CtsBionicTestCases
    [Tags]    stress
    Run CTS Module    CtsBionicTestCases

*** Test Cases ***
Device Shall Pass vm-tests-tf
    [Tags]    stress
    Run CTS Module    vm-tests-tf

*** Test Cases ***
Device Shall Pass CtsDumpsysHostTestCases
    [Tags]    stress
    Run CTS Module    CtsDumpsysHostTestCases

*** Test Cases ***
Device Shall Pass CtsExternalServiceTestCases
    [Tags]    stress
    Run CTS Module    CtsExternalServiceTestCases

*** Test Cases ***
Device Shall Pass CtsLibcoreLegacy22TestCases
    [Tags]    stress
    Run CTS Module    CtsLibcoreLegacy22TestCases

*** Test Cases ***
Device Shall Pass CtsNdefTestCases
    [Tags]    stress
    Run CTS Module    CtsNdefTestCases

*** Test Cases ***
Device Shall Pass CtsNetSecConfigResourcesSrcTestCases
    [Tags]    stress
    Run CTS Module    CtsNetSecConfigResourcesSrcTestCases

*** Test Cases ***
Device Shall Pass CtsNetTestCasesLegacyPermission22
    [Tags]    stress
    Run CTS Module    CtsNetTestCasesLegacyPermission22

*** Test Cases ***
Device Shall Pass CtsJdwpSecurityHostTestCases
    [Tags]    stress
    Run CTS Module    CtsJdwpSecurityHostTestCases

*** Test Cases ***
Device Shall Pass CtsNetTestCasesLegacyApi22
    [Tags]    stress
    Run CTS Module    CtsNetTestCasesLegacyApi22

*** Test Cases ***
Device Shall Pass CtsJdwpTestCases
    [Tags]    stress
    Run CTS Module    CtsJdwpTestCases

*** Test Cases ***
Device Shall Pass CtsAslrMallocTestCases
    [Tags]    stress
    Run CTS Module    CtsAslrMallocTestCases

*** Test Cases ***
Device Shall Pass CtsVmTestCases
    [Tags]    stress
    Run CTS Module    CtsVmTestCases

*** Test Cases ***
Device Shall Pass CtsSilverCeTestCases
    [Tags]    stress
    Run CTS Module    CtsSilverCeTestCases

*** Test Cases ***
Device Shall Pass CtsLibcoreOjTestCases
    [Tags]    stress
    Run CTS Module    CtsLibcoreOjTestCases

*** Test Cases ***
Device Shall Pass CtsLibcoreOkHttpTestCases
    [Tags]    stress
    Run CTS Module    CtsLibcoreOkHttpTestCases
