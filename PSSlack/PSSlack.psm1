function Get-AuthorizationHeader {
    [CmdletBinding()]
    param (
        # Path to the file containing the token
        [string]
        $FilePath = 'c:\temp\really_important_token.txt'
    )

    # Return the header
    @{Authorization = "Bearer $(Get-Content $FilePath)"}
}

function Send-PSSlackMessage {
    [CmdletBinding()]
    param (
        # The channel id of the channel we want to send messages to
        [string]
        $ChannelId = 'C040270AQ9E',

        [Parameter(Mandatory,ValueFromPipeline, position=0)]
        [string]
        $Message
    )

    process {
        $params = @{
            Uri     = 'https://slack.com/api/chat.postMessage'
            Headers = (Get-AuthorizationHeader)
            Body = ((@{
                channel = $ChannelId
                text    = $Message
            }) | ConvertTo-Json)
            Method = 'POST'
            ContentType = 'application/json; charset=utf-8'
        }
        Invoke-RestMethod @params
    }
}