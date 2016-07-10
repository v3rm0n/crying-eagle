local module = {}

local function debounce (func)
    local last = 0
    local delay = 200000

    return function (...)
        local now = tmr.now()
        if now - last < delay then return end

        last = now
        return func(...)
    end
end

local function onChange()
    if gpio.read(config.SWITCH_PIN) == 0 then
        print("PUSH")
        srv = net.createConnection(net.TCP, 30)
        srv:connect(80, "192.168.1.1")
        srv:on("connection", function(sck, c)
            sck:send("PUSH")
        end) 
        tmr.delay(500000)
    end
end

function module.start()
    print("Registering button")
    gpio.trig(config.SWITCH_PIN, "down", debounce(onChange))
    print("Button registered")
end

return module 
