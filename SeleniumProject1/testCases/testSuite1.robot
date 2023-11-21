*** Settings ***
Library        SeleniumLibrary   run_on_failure=None
Resource       ../resourcesLibrary/Suite1.resource
Suite Setup        Suite Setup
Suite Teardown     Suite Teardown

*** Variables ***



*** Keywords ***
Suite Setup
       Open Demo Website     https://awesomeqa.com/ui/   chrome

Suite Teardown
       Close Browser

*** Test Cases ***

Valid UserRegistration_1
          Valid Registration    Syed    Ali    syedali123@outlook.com
               ...     +919010543317
               ...     Test123
               ...     Yes
               ...     Yes

Valid UserRegistration_2
          Valid Registration    Syed    Ali    syedali123@outlook.com
               ...     +919010543317
               ...     Test123
               ...     No
               ...     Yes

Valid UserRegistration_3
          Valid Registration    Syed    Ali    syedali123@outlook.com
               ...     +919010543317
               ...     Test123
               ...     No
               ...     No