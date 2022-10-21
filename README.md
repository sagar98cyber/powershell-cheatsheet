# powershell-scripting-cheatsheet
<!---
[Reference Lecture 1](https://youtu.be/I4SFymp1dcE?t=16)
--->

##  Basics of PowerShell Scripting
Beginning with the basics of the PowerShell
<br>

``` 
    $PSVersionTable
```
> The First command that we have is: [here](./Lecture_1/1_PowerShellVersion.png)<br>
> Displays details about the version of PowerShell that is running in the current session.

<br>

``` 
    Get-Process
```
> The Output for the same is [here](./Lecture_1/2_Get-Process.png)<br>
> Displays details about all the processes currently running on the system.
> This is a cmdlet

<br>

``` 
    Get-Service
```
> The Output for the same is [here](./Lecture_1/3_GET-SERVICE.png)<br>
> Displays details about all the services currently on the system and their state whether they are running or stopped.
> For Example: [Background Intelligent File Transfer Service](./Lecture_1/4_file_transfer.png) is used for file transfer<br>
> This is a cmdlet

<br>

``` 
    Get-Date
```
> The Output for the same is [here](./Lecture_1/5_getDate.png)<br>
> Displays the current Date and Time
> This is a cmdlet

<br>

``` 
    Get-ChildItem
```
> The Output for the same is [here](./Lecture_1/6_getChildItem.png)<br>
> Displays all the current files and directories of the current working directory, just like a *'cd'* or a *'ls'* command
> This is a cmdlet
<br>

#### If you have noticed carefully the *Get-ChildItem* cmdlet works exactly like the *'dir'*,*'ls'*.<br> So why we have all the three of them?🤔
>*Get-ChildItem* is a cmdlet, whereas *'dir'*,*'ls'* are its aliases. Aliases are nothing but the identifier to the cmdlets.<br>
>We create Aliases for our ease to remember any specific cmdlet with our identifiers.<br>
>We use  [*Get-Alias*](./Lecture_1/9_GetAllAliases.png) command to display all the aliases present on the current system.<br>
>*Get-Alias* is a cmdlet.
``` 
    Get-Alias
```
> The Output for the same is [here](./Lecture_1/7-dir-GetChildItem.png)<br>
> The output shows o/p of 2 commands the first one is cmdlet - *Get-ChildItem* and the second is alias - *dir*.<br>
> Another comman alias - *cd* is equivalent to *Set-Location*. [Example](./Lecture_1/8_cd-SetLocation.png)<br>

``` 
    Get-Alias < alias-name >
```
> Checks if the alias exists, if yes displays the [output](./Lecture_1/9.1_GetAliasforSpecificCommand.png)<br>
> This is a cmdlet but it gets the info about the alias
<br>

``` 
    help < alias-name >
```
> Checks if the alias exists, if yes displays the [details](./Lecture_1/10_Help-Aliases-MANPAGE.png) of the alias.<br>
> This is a cmdlet but it gets the info about the alias
<br>

``` 
    new-alias -name < alias-name > -value < corresponding-cmdlet >
```
> The above command is used in creating your own alias as per your needs. [Example](./Lecture_1/11_creating_aliases.png) of the alias.<br>
> This is a cmdlet but it is used to create the alias
<br>

``` 
    Remove-Item Alias:< alias-name >
```
> The above command is used in removing an alias. [Example](./Lecture_1/12_RemoveAliases.png).<br>
> This is a cmdlet but it is used to delete the alias
<br>


set execution policies
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```


Get Execution Policy
```
Get-ExecutionPolicy
```


```
$fName =$args[0]
$lName = $args[1]
write-Host "Hello Butch"
Write-Warning "$fName $lName"
```

```
write-host "First write"
write-host "This is your computer logged in from $env:COMPUTERNAME"
write-host "Mogambokhush hua"
Get-ExecutionPolicy
```

To get a full name or to get the full output we 
can use
```
Get-Service | Format-Table -Wrap
```

If in place of table we want the same thing as 
list, then
```
Get-Service | Format-List
```

```
$varname = get-service -name Bits | select name, status
write-host $varname
```


Get-Service | select -property name,starttype

(get-service|?{ $_.Status -eq "Stopped" -and $_.StartType -eq "Automatic"})|
select DisplayName, StartType, Status

Get-Service | Select-Object -Property Name,Status,StartType | where-object {$_.Name -eq "MpsSvc"} | Format-Table -auto


Get-Service BITS | Select StartType



Write-Host ($list | Where-Object {!($target -match $_)})

<br>

##  Arrays
### Create an Empty Array
An empty array can be created by using @()
<br>
Example:
```
$data = @()
$data.count
``` 

```
$data = @('Zero','One','Two','Three')
$data.count
```

### Accessing the items of the arrays
Example:<br>
```
$data[0]
$data[1]
$data[2]
```

#### Using a special index
Example: <br>
```
$data[0,2,3]
```

```
$data[1..3]
```
```
$data[-1]
```

```
$data.count
```

```
$date = Get-Date
$date.count
```

### Updating the items of the arrays
Example:<br>
```
$data[2] = 'dos'
```
```
$data[3] = 'tres'
```

### For more information on Arrays this [link](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.2) 
<br>

##  HashTables

### Creating a HashTable

A hashtable is a data structure, much like an array, except you store each value (object) using a key. It's a basic key/value store. First, we create an empty hashtable.
<br>

Example:
<br>
```
$ageList = @{}
```

Notice that braces, instead of parentheses, are used to define a hashtable. Then we add an item using a key like this: 
<br>

```
$key = 'Kevin'
$value = 36
$ageList.add( $key, $value )

$ageList.add( 'Alex', 9 )
```

### Accessing the Elements using the brackets

```
$ageList['Kevin']
$ageList['Alex']
```

### Creating Hashtables with values

```
$ageList = @{
    Kevin = 36
    Alex  = 9
}
```

The real value of this type of a hashtable is that you can use them as a lookup table.
<br>

### Multiselection

```
$environments = @{
    Prod = 'SrvProd05'
    QA   = 'SrvQA02'
    Dev  = 'SrvDev12'
}
```

### Iterating over our hashtables

#### GetEnumerator()

GetEnumerator() for iterating over our hashtable.
<br>
```
$ageList.GetEnumerator() | ForEach-Object{
    $message = '{0} is {1} years old!' -f $_.key, $_.value
    Write-Output $message
}
```

The enumerator gives you each key/value pair one after another. It was designed specifically for this use case. 

### For more information on the HashTables visit [URL](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.2)


## Strings

### Concatenation
```
$name = 'Kevin Marquette'
$message = 'Hello, ' + $name
```

### Variable Substitution
```
$message = "Hello, $first $last.
```

### Command substitution

```
$directory = Get-Item 'c:\windows'
$message = "Time: $directory.CreationTime"
```

You would be expecting to get the CreationTime off of the $directory, but instead you get this Time: c:\windows.CreationTime as your value. The reason is that this type of substitution only sees the base variable. It considers the period as part of the string so it stops resolving the value any deeper.<br>
It just so happens that this object gives a string as a default value when placed into a string. Some objects give you the type name instead like System.Collections.Hashtable. Just something to watch for.<br>
PowerShell allows you to do command execution inside the string with a special syntax. This allows us to get the properties of these objects and run any other command to get a value.

```
$directory = Get-Item 'C:\Windows'
$message = "$($directory.CreationTime)"
$message
```

### Command Execution

You can run commands inside a string. Even though I have this option, I don't like it. It gets cluttered quickly and hard to debug. I either run the command and save to a variable or use a format string.
```
$message = "Date: $(Get-Date)"
```

### Format String

```
$first = "first"
$last = "Answer"
```

```
$values = @(
    "Kevin"
    "Marquette"
)
'Hello, {0} {1}.' -f $values
```

### Joining Strings

```
$servers = @(
    'server1'
    'server2'
    'server3'
)

$servers  -join ','
```

### For more information on String visit this [Link](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-string-substitutions?view=powershell-7.2)


## For Output Forwarding and redirection use the following reference blogs by Microsoft: <br>
> [Blog 1](https://learn.microsoft.com/en-us/powershell/scripting/samples/redirecting-data-with-out---cmdlets?view=powershell-7.2) <br>
> [Blog 2](https://learn.microsoft.com/en-us/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7.2)


### JsonToCsv Script
> [Script](./scripts/jsonToCsv.ps1)

### Retrieve the Status Code of an API call
> [Script](./scripts/statusCode2.py)