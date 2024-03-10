local web = assert(http.websocket("ws://uni4on.asuscomm.com:2233"))


--mudules
port=22
local function SelectPort()
    io.write("Write the port of turtle ->")
    port = io.read()
end

--main function

local function runZ()
    term.setCursorPos(1,1)
    term.clear()
    io.write("Runner Custom commands v2.1 \n execute->") 
    char = io.read()
    if char == "chport" then SelectPort()
    end
    term.clear()
end


--execution -----------------------------------------------------------

print("turtle control module enabled!!!")
SelectPort()

--main
function main()
    while true do
        term.clear()
        term.setCursorPos(1,1)
        print("press any char to send on server...")
        print("curret send port -"..port)

        event, char = os.pullEvent("char")
            if char == "p" then runZ() end
        upack = {["control_char"]=char, ["ent"]=port}
        pack = textutils.serialiseJSON(upack)
        web.send(pack)
    end
end

main()