local web = assert(http.websocket("ws://uni4on.asuscomm.com:2233"))
args = {...}
port = args[1]
packet = {["src"]=port, ["type"]="pong"}
spacket = textutils.serializeJSON(packet)
web.send(spacket)

while true do
	z = web.receive()
	x = textutils.unserializeJSON(z)
	if x.type == "ping" then 
		web.send(spacket)
		print("ping "..os.date())
	end
end