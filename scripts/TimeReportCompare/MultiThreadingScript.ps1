# Example workload
#$processor = Get-ComputerInfo -Property CsProcessors
#$Number = $processor.CsProcessors.NumberOfCores
$Number = 10
$dataset = @()

foreach ($i in 1..$Number){
    $dataset.Add(@{
        Id   = $i
        Wait = 3..7 | PowerShell.exe -command "jsonToCsv.ps1" -ArgumentList $i -Wait -NoNewWindow
    })
}



<#
$dataset = @(
    @{
        Id   = 1
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
    @{
        Id   = 2
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
    @{
        Id   = 3
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
    @{
        Id   = 4
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
    @{
        Id   = 5
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
     @{
        Id   = 6
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
     @{
        Id   = 7
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
     @{
        Id   = 8
        Wait = 3..10 | PowerShell.exe -command "C:\Users\SAGARTUSHARS\Desktop\TASK.ps1" -ArgumentList $i -Wait -NoNewWindow
    }
)
#>

#echo "$dataset[1].Id"

# Create a hashtable for process.
# Keys should be ID's of the processes
$origin = @{}
$dataset | Foreach-Object {$origin.($_.id) = @{}}

# Create synced hashtable
$sync = [System.Collections.Hashtable]::Synchronized($origin)

$job = $dataset | Foreach-Object -ThrottleLimit 8 -AsJob -Parallel {
    $syncCopy = $using:sync
    $process = $syncCopy.$($PSItem.Id)

    $process.Id = $PSItem.Id
    $process.Activity = "Id $($PSItem.Id) starting"
    $process.Status = "Processing"

    # Fake workload start up that takes x amount of time to complete
    start-sleep -Milliseconds ($PSItem.wait*5)

    # Process. update activity
    $process.Activity = "Id $($PSItem.id) processing"
    foreach ($percent in 1..100)
    {
        # Update process on status
        $process.Status = "Handling $percent/100"
        $process.PercentComplete = (($percent / 100) * 100)

        # Fake workload that takes x amount of time to complete
        Start-Sleep -Milliseconds $PSItem.Wait
    }

    # Mark process as completed
    $process.Completed = $true
}

while($job.State -eq 'Running')
{
    $sync.Keys | Foreach-Object {
        # If key is not defined, ignore
        if(![string]::IsNullOrEmpty($sync.$_.keys))
        {
            # Create parameter hashtable to splat
            $param = $sync.$_

            # Execute Write-Progressff
            Write-Progress @param
        }
    }

    # Wait to refresh to not overload gui
    Start-Sleep -Seconds 0.1
}

