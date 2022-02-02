Connect-MicrosoftTeams

$group2 = New-Team -MailNickname "Team2_SPTSAP" -displayname "Team 2 Sample - SAP SPT Team" -Visibility "private" 
    Add-TeamUser -GroupId $group.GroupId -User "trshane@microsoft.com"
    Add-TeamUser -GroupId $group.GroupId -User "joe.derkos@microsoft.com" -role Owner
    Add-TeamUser -GroupId $group.GroupId -User "matthew.hacker@microsoft.com"
    Add-TeamUser -GroupId $group.GroupId -User "laurelhale@microsoft.com"

$group.GroupId

$group2.Classification




Install-Module AzureADPreview
Import-Module AzureADPreview
Connect-AzureAD

$grpUnifiedSetting = (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ)
$template = Get-AzureADDirectorySettingTemplate -Id 62375ab9-6b52-47ed-826b-58e47e0e304b
$setting = $template.CreateDirectorySetting()

$Setting.Values

$Setting["EnableMIPLabels"] = "True"

$Setting.Values

Set-AzureADDirectorySetting -Id $grpUnifiedSetting.Id -DirectorySetting $setting