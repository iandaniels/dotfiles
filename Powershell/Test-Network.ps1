# (new-object Net.Sockets.TcpClient).Connect("hostname", 1433)

$port = 1433
Write-Host "Listening on port $port"
$Listener = [System.Net.Sockets.TcpListener]$port
$Listener.Start()

#wait, try connect from another PC etc.
#put this code in between Start and Stop calls.
while($true) 
{
    $client = $Listener.AcceptTcpClient()
    Write-Host "Connected!"
    $client.Close()
    break
}


$Listener.Stop()
