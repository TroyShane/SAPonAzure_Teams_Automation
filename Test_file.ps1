#Get-module -ListAvailable


#Install-Module -Name MicrosoftTeams
#Install-Module SharePointPnPPowerShellOnline
#Uninstall-Module -Name SharePointPnPPowerShellOnline -AllVersions -Force                                                                                                                                                                                                                       
#Install-Module -Name PnP.PowerShell 

Connect-MicrosoftTeams

$group = New-Team -MailNickname "CUSTOMER_SPTSAP" -displayname "CUSTOMER - SAP SPT" -Visibility "private"
    Add-TeamUser -GroupId $group.GroupId -User "trshane@microsoft.com"
    Add-TeamUser -GroupId $group.GroupId -User "peter.westenbroek@microsoft.com" -role Owner
    Add-TeamUser -GroupId $group.GroupId -User "amlal@microsoft.com"
    Add-TeamUser -GroupId $group.GroupId -User "sthirunethir@microsoft.com"
    New-TeamChannel -GroupId $group.GroupId -DisplayName "A - SAP SPT"


    Set-Team -GroupId $group.GroupId -DisplayName "CUSTOMER - SAP SPT" 
    -Description "Team to coordinate SAP SPT work with CUSTOMER" 
    -MailNickName" CUSTOMER_SPTSAP" 
    -AllowAddRemoveApps $TRUE 
    -AllowChannelMentions $TRUE 
    -AllowCreateUpdateChannels $TRUE 
    -AllowCreateUpdateRemoveConnectors $TRUE 
    -AllowCreateUpdateRemoveTabs $TRUE
    -AllowCustomMemes $TRUE
    -AllowDeleteChannels $TRUE
    -AllowGiphy $TRUE
    -AllowGuestCreateUpdateChannels $TRUE
    -AllowGuestDeleteChannels $TRUE 
    -AllowOwnerDeleteMessages $TRUE 
    -AllowStickersAndMemes $TRUE 
    -AllowTeamMentions $TRUE 
    -AllowUserDeleteMessages $TRUE 
    -AllowUserEditMessages $TRUE 
    -ShowInTeamsSearchAndSuggestions $TRUE


    Add-TeamChannelUser -GroupId $group.GroupId -DisplayName "SAP SPT" -User "peter.westenbroek@microsoft.com"
    Add-TeamChannelUser -GroupId $group.GroupId -DisplayName "SAP SPT" -User "amit.lal@microsoft.com"
    Add-TeamChannelUser -GroupId $group.GroupId -DisplayName "SAP SPT" -User "sthirunethir@microsoft.com"
    Add-TeamChannelUser -GroupId $group.GroupId -DisplayName "SAP SPT" -User trshane@microsoft.com -Role Owner




    ###########
    #Get team, get channel and manipulate the Files in that channel
    $team = Get-Team -MailNickname "CUSTOMER_SPTSAP"
    
    $GeneralChannel = Get-Team -GroupId $team.GroupId | Get-TeamChannel | Where-Object {$_.DisplayName -eq "General"}
    $url = "https://microsoft.sharepoint.com/teams/" + $team.MailNickName + "/Shared%20Documents/" + $GeneralChannel.DisplayName
    $url

################################################    



    #Config Variables
    $SiteURL = "https://microsoft.sharepoint.com/:f:/t/CUSTOMER_SPTSAP/EkI9aeuBwvFDlJA2MaO2tJ8BiKexQlKc-VSa5CKNRtu_mg?e=opE5Pb"
    $FolderName= "Test"
    $SiteRelativeURL= "/Shared%20Documents/General" #Site Relative URL of the Parent Folder
    
    #Get Credentials to connect
    $Cred = Get-Credential
    
    Try {
        #Connect to PnP Online
        Connect-PnPOnline -Url $SiteURL -CurrentCredentials
        
        #sharepoint online create folder powershell
        Add-PnPFolder -Name $FolderName -Folder $SiteRelativeURL -ErrorAction Stop
        Write-host -f Green "New Folder '$FolderName' Added!"
    }
    catch {
        write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
    }
