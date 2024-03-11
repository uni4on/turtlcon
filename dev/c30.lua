function init()
	port = 22
	src = "sputnik"
	idstable = {}
	web = assert(http.websocket("ws://uni4on.asuscomm.com:2233"))
end


function customcomma()
	term.clear()
	term.setCursorPos(1,1)
	io.write("custom command send ->")
	comma = io.read()
	return comma
end

function selectport()
	term.clear()
	term.setCursorPos(1,1)
	io.write("select turtle id ->")
	port = io.read()
end

function irecv()
	while true do
		x = web.receive()
		z = textutils.unserializeJSON(x)
		if z.type == "ping" then
			table.insert(idstable, z.src)
		end
	end	 
end

function isend()
	for i=1, 10 do
		print(i)
		x = {["src"]=src, ["type"]="idping"}
		z = textutils.serializeJSON(x)
		web.send(z)
		os.sleep(0.5)
		
	end
end

function get_ids()
	parallel.waitForAny(irecv, isend)
	print("list of ids is updated")
	for k,v in ipairs(idstable) do
		print(k,v)
	end
end

function monitor()
	while true do
		x = web.receive()
		print("!! "..x)
	end
end

function konsole()
	while true do
		event, ch = os.pullEvent("char")
		if ch == "p" then
			ch = customcomma()
			if ch == "port" then selectport()
			elseif ch == "getid" then get_ids()
			end
		end

		Xpacket = {["src"]=src, ["control_char"]=ch, ["port"]=port, ["type"]="char"}
		Cpacket = textutils.serializeJSON(Xpacket)
		web.send(Cpacket)
	end
end

init()

function main()
	selectport()
	get_ids()
	konsole()
end

parallel.waitForAny(main, monitor)
