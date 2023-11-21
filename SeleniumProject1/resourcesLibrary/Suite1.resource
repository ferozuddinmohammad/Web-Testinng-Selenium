*** Settings ***
Library        SeleniumLibrary
Library        String
Documentation     All these keywords are associated with test Suite1.
...               The variables section contains respective locators required for testSuite1 test cases.

*** Variables ***

${my_acc}          //*[@id="top-links"]/ul/li[2]/a
${registration}    //*[@id="top-links"]/ul/li[2]/ul/li[1]/a

## registration page details
${label}         ${EMPTY}

${firstname}      //*[@id="input-firstname"]
${lastname}       //*[@id="input-lastname"]
${email}          //*[@id="input-email"]
${mobile}         //*[@id="input-telephone"]
${password}       //*[@id="input-password"]
${password_confirm}          //*[@id="input-confirm"]
${subscription_required}     //*[@id="content"]/form/fieldset[3]/div/div/label[subscribe_value]/input
${Agree_Terms}               //*[@id="content"]/form/div/div/input[1]


*** Keywords ***

Open Demo Website
     [Documentation]     Opens the website in specified browser for a given URL.

     [Arguments]         ${url}
     ...                 ${browser_name}

       Open Browser      ${url}    ${browser_name}    options=add_experimental_option("detach", True)
       Set Selenium Speed    0.5 seconds
       Maximize browser window

Scroll to Page End
       Execute javascript      window.scrollTo(0,document.body.scrollHeight)

Valid Registration
     [Documentation]     Registers a new user with the given credentials in variables section.

     [Arguments]         ${firstname_value}
     ...                 ${lastname_value}
     ...                 ${email_value}
     ...                 ${mobile_value}
     ...                 ${password_value}
     ...                 ${subscription_required_value}
     ...                 ${Agree_Terms_value}

     Click Element   xpath=${my_acc}
     Click Element   xpath=${registration}

    Input Text     xpath=${firstname}        ${firstname_value}
    Input Text     xpath=${lastname}         ${lastname_value}
    Input Text     xpath=${mobile}           ${mobile_value}
    Input Text     xpath=${email}            ${email_value}

    #Scroll Element into view   xpath=${password}
    Scroll to Page End

    Input Password         xpath=${password}                        ${password_value}
    Input Password         xpath=${password_confirm}                ${password_value}
   
    ${subscribe} =  Convert to Lowercase   ${subscription_required_value}

          IF   "${subscribe}" == "yes"
              Set Test Variable    ${label}    1
              ${subscription_required}=    Replace string    ${subscription_required}     subscribe_value      ${label}
              Log    ${subscription_required}
          ELSE
              Set Test Variable    ${label}    2
              ${subscription_required}=    Replace string    ${subscription_required}     subscribe_value      ${label}
          END
    Click Button         xpath=${subscription_required}

    ${Agree_tnC} =  Convert to Lowercase   ${Agree_Terms_value}

          IF   "${Agree_tnC}" == "yes"

              Select Checkbox        xpath=${Agree_Terms}
          ELSE

          Log    Terms and conditions Not Selected
          Fail   checkbox not selected by user, modify argument to Yes.

          END

