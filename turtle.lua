local web = assert(http.websocket("ws://uni4on.asuscomm.com:2233"))
turtle_port = ""
turtle.refuel(64)
print(turtle.getFuelLevel())


--execute line
function exec(ch)
    if ch == "w" then turtle.forward()
    elseif ch == "a" then turtle.turnLeft()
    elseif ch == "s" then turtle.back()
    elseif ch == "d" then turtle.turnRight()
    elseif ch == "r" then turtle.up()
    elseif ch == "f" then turtle.down()
    elseif ch == "t" then turtle.digUp()
    elseif ch == "g" then turtle.dig()
    elseif ch == "v" then turtle.digDown()
    elseif ch == "y" then turtle.placeUp()
    elseif ch == "h" then turtle.place()
    elseif ch == "b" then turtle.placeDown()
    elseif ch == "q" then drop()
    end
end

--custom functions
function drop()
    for i=1,16 do
    turtle.select(i)
    turtle.drop(64)
    end
    turtle.select(1)
end

-- main
function main()
    while true do
        x = web.receive()
        c = textutils.unserialiseJSON(x)
        if c.ent == turtle_port then
            exec(c.control_char)
        end
    end
end

--run
main()


