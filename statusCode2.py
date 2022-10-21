import requests 

def statusCodeHandlerFunction(resCode):
    pass
    if resCode < 300:
        print(f"The response code is: {resCode}")
    elif resCode == 403:
        print(f"Forbidden Final Response: {resCode}")
    elif resCode == 404:
        print(f"Not Found Final Response: {resCode}")
    elif resCode == 400:
        print(f"Response is Bad Request: {resCode}")
    else:
        print("No MAtches final catch condition")
        print("Something went wrong!")
   

def requestAPICall():
    r = requests.head("https://www.miniclip.com/games/en/")
    r = requests.head("https://stackoverflow.com")
    r = requests.head("https://usea1-muso01.sentinelone.net/web/api/v2.1/accounts")
   # print(f"This is the new line \n\n {type(r)}")
    return r


try:
    responseAPIFUnc = requestAPICall().status_code
    print(f"First {responseAPIFUnc}")
    retry = 0
    while responseAPIFUnc >300 and retry <4:
        retry+=1
        print(f"Retrying {retry}")
        responseAPIFUnc = requestAPICall().status_code
        print(f"Retrying {responseAPIFUnc}")    
    if responseAPIFUnc <300:
        print("Success")
    else:
        print("Failure")
        statusCodeHandlerFunction(responseAPIFUnc)


except requests.ConnectionError:
    pass
