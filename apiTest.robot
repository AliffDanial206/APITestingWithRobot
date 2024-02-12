*** Settings ***
Library    RequestsLibrary
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${base_url}    https://rahulshettyacademy.com
${book_id}     
${book_name}   RobotFramework

*** Test Cases ***
POST Method 
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=943213    aisle=32452    author=John foe
    ${response}=    POST    ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id}=    Get From Dictionary    ${response.json()}    ID    default
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200    ${response}

GET Method
    ${get_response}=    GET    ${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

DELETE Method
    &{delete_req}=    Create Dictionary    ID=${book_id}
    ${delete_resp}=    POST    ${base_url}/Library/DeleteBook.php    json=${delete_req}    expected_status=200
    Log    ${delete_resp.json()}[msg]
    Should Be Equal As Strings    book is successfully deleted    ${delete_resp.json()}[msg]