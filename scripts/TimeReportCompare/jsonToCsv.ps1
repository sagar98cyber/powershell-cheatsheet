#URL of the API#
$url = ""
$Token = "APIToken " #| ConvertTo-SecureString -AsPlainText -Force

#
#Api token#
$api_key = $Token
#
#creating api header#
$headers = @{}
$headers.add("Content-Type","application/x-www-form-urlencoded")
$headers.add("Authorization",$api_key) #adding api key into the header#

#Making the API request#
try{
    #Parameters
    $Output = "actions","siteIds",'description',"id", 'includeChildren','includeParents','mode','notRecommended','osType','pathExclusionType','scopeName' , 'scopePath','source', 'type' ,'updatedAt' ,'userId','userName','value',"tenant"
    $OutFile = "count.csv"
    $resp = Invoke-restmethod -URI $url -headers $headers 
    $Properties = ""
    foreach($prop in $Output){
        $Properties+= "$prop, " 
    }
    $Properties >> $OutFile
    #$endREs = ""
    <#$valueD = $resp.data
    $valueD = $valueD[0].actions
    Write-Host "Before"
    $valueD
    Write-Host "After"#>
    foreach($val in $resp.data ){
        if($null -eq $val.actions  -OR $val.actions -eq ""){
            $val.actions = "empty"
        }
    }
    foreach($val in $resp.data ){
     #   if($null -eq $val.actions  -OR $val.actions -eq ""){
            $val#.actions = "empty"
     #   }
    }
   foreach($val in $resp.data){
    foreach($actions in $val.actions){
        foreach($siteIds in $val.scope){
            $sIdsRes = $siteIds.siteIds
            $vIdRes = $val.id
            $uIdRes = $val.userId
               if($val.scope.tenant -eq $true){
                    $temp = $actions+","+"'"+$sIdsRes+"'" +","+$val.description+","+"'"+$vIdRes+"'"+","+$val.includeChildren+","+$val.includeParents+","+$val.mode+","+$val.notRecommended+","+$val.osType+","+$val.pathExclusionType+","+$val.scopeName+","+$val.scopePath+","+$val.source+","+$val.type+","+$val.updatedAt+","+"'"+$uIdRes+"'"+","+$val.userName+","+$val.value+","+$val.scope.tenant
                    $temp >> $OutFile
                }
                else{
                    $temp = $actions+","+"'"+ $sIdsRes+"'"+","+$val.description+","+"'"+$vIdRes+"'"+","+$val.includeChildren+","+$val.includeParents+","+$val.mode+","+$val.notRecommended+","+$val.osType+","+$val.pathExclusionType+","+$val.scopeName+","+$val.scopePath+","+$val.source+","+$val.type+","+$val.updatedAt+","+"'"+$uIdRes+"'"+","+$val.userName+","+$val.value+","+"false"
                    $temp >> $OutFile
                }
            }
        }
    }
}
catch{
    $err_code = $_.Exception.Response.StatusCode.value_
    $err_msg = $_.Exception.Response.StatusDescription
}