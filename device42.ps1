  <#
    .SYNOPSIS 
      This script makes HTTP POST request to device42 API via powershell
    .EXAMPLE
     ./scriptName.ps1 -User userName -Password pass -ParamString 'name=name1&serial_no=1234567890'
     This will post a device with the specified name and serial number. Any amount of POST parameters can be used. 
     If parameters have special symbols it should be escaped according to PowerShell conventions.
  #>
[CmdletBinding()]
Param(
  [string]$apiUrl = 'https://demo.device42.com/api/1.0/device/',
  [Parameter(Mandatory=$true)]
  [string]$User,
  [Parameter(Mandatory=$true)]
  [string]$Password,
  [Parameter(Mandatory=$true)]
  [string]$ParamString 
)


[System.Net.ServicePointManager]::ServerCertificateValidationCallback = $null
$base64Credentials = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$User`:$Password"))
$client = new-object System.Net.WebClient
$client.Headers.Add("Content-Type", "application/x-www-form-urlencoded")
$client.Headers.Add("Authorization", "Basic $base64Credentials")
$client.Encoding = [System.Text.Encoding]::UTF8
$response = $client.UploadString($apiUrl, $ParamString)
$response 