param(
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$InstallPath,
    
    [Parameter(Mandatory = $true)]
    [ValidateScript( { Test-Path $_ -PathType 'Container' })]
    [string]$DataPath,

    [Parameter(Mandatory = $true)]
    [string]$SolrPort
)

function Wait-ForZooKeeperInstance
{
    param(
        [string]$zkHost,
        [int]$zkPort
    )

    Write-Host "Waiting for ZooKeeper at $($zkHost):$zkPort"

    $sawError = $false
    $isUp = $false
    while($isUp -ne $true)
    {
        try
        {
			$client = New-Object System.Net.Sockets.TcpClient
            $client.Connect($zkHost, $zkPort)
            $ns = [System.Net.Sockets.NetworkStream]$client.GetStream()
        		
            $sendBytes = [System.Text.Encoding]::ASCII.GetBytes("ruok")
            $ns.Write($sendBytes, 0, $sendBytes.Length)

            $buffer = New-Object 'byte[]' 10
            $bytesRead = $ns.Read($buffer, 0, 10)

            $receivedBytes = New-Object 'byte[]' $bytesRead
            [System.Array]::Copy($buffer, $receivedBytes, $bytesRead)

            $result = [System.Text.Encoding]::ASCII.GetString($receivedBytes)
          			
            if( $result -eq "imok" )
            {
                $isUp = $true
                if( $sawError -eq $true )
                {
                    Write-Host
                }
            }

            $ns.Dispose()
			$client.Dispose()
        }
        catch
        {		
            $sawError = $true
            Write-Host "." -NoNewline
        }
    }

    $client.Dispose()

    Write-Host "ZooKeeper is up"
}

$dataPathToTest = Join-Path $DataPath solr.xml
if (Test-Path $dataPathToTest) {
    Write-Host "INFO: Existing Solr configuration found in '$DataPath'..."
}
else {
    Write-Host "INFO: Solr configuration not found in '$DataPath', copying clean configuration..."
    Copy-Item $InstallPath\** $DataPath -Recurse -Force -ErrorAction SilentlyContinue
}

Start-Process -FilePath "c:\zk\bin\zkServer.cmd" -NoNewWindow

Wait-ForZooKeeperInstance "localhost" 2181

& "c:\solr\bin\solr.cmd" start -port $SolrPort -f -z localhost:2181