const socket = require("ws");
var clients = [];
const WebSocket = new socket.Server({port:2233})

console.log("\n[server] enabled on 2233\n")

WebSocket.on("connection", wsClient => {
    console.log("[server] client connected")
    clients.push(wsClient);
   

    wsClient.on("message", msdata => {
        console.log("[server] resseived message: "+msdata.toString());
        clients.forEach(function(client){
            client.send(msdata.toString());
        })
    })

    wsClient.on("close", () =>{
        console.log("[server] client disconected")
    });
});



