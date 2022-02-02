
#From https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-v2-cmdlets
#Goal Adjust the default lable of a spoecific group, by groupID, to adhere to corporate policy

install-module azuread
import-module azuread


get-module azuread

Connect-AzureAD

get-azureadgroup

get-azureadgroup -ObjectId 2e69c00d-f819-4e92-ae71-7fc285cbbd43 #Team2_SPTSAP


#You can search for a specific group using the -filter parameter. This parameter takes an ODATA filter clause and returns all groups that match the filter, as in the following example:
Get-AzureADGroup -Filter "DisplayName eq 'Team 2 Sample - SAP SPT Team'"

#DeletionTimeStamp            :
#ObjectId                     : 31f1ff6c-d48c-4f8a-b2e1-abca7fd399df
#ObjectType                   : Group
#Description                  : Intune Administrators
#DirSyncEnabled               :
#DisplayName                  : Intune Administrators
#LastDirSyncTime              :
#Mail                         :
#MailEnabled                  : False
#MailNickName                 : 4dd067a0-6515-4f23-968a-cc2ffc2eff5c
#OnPremisesSecurityIdentifier :
#ProvisioningErrors           : {}
#ProxyAddresses               : {}
#SecurityEnabled              : True


#Create groups
#To create a new group in your directory, use the New-AzureADGroup cmdlet. This cmdlet creates a new security group called “Marketing":
New-AzureADGroup -Description "Marketing" -DisplayName "Marketing" -MailEnabled $false -SecurityEnabled $true -MailNickName "Marketing"


#Update groups
#To update an existing group, use the Set-AzureADGroup cmdlet. In this example, we’re changing the DisplayName property of the group “Intune Administrators.” 
#First, we’re finding the group using the Get-AzureADGroup cmdlet and filter using the DisplayName attribute:

$grouptoupdate = Get-AzureADGroup -Filter "DisplayName eq 'Team 2 Sample - SAP SPT Team'"
Set-AzureADGroup -ObjectId $grouptoupdate.GroupID -Description "Team 2 Sample updated title - SAP SPT Team"



#Assign sensitivity labels to Microsoft 365 groups in Azure Active Directory
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

