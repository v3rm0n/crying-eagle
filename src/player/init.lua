 print("Ready to start soft ap")

 cfg={}
 cfg.ssid="RockFlagAndEagle";
 cfg.pwd="CryingEagle"
 wifi.ap.config(cfg)

 cfg={}
 cfg.ip="192.168.1.1";
 cfg.netmask="255.255.255.0";
 cfg.gateway="192.168.1.1";
 wifi.ap.setip(cfg);
 wifi.setmode(wifi.SOFTAP)

 gpio.mode(4, gpio.OUTPUT)
 gpio.write(4, gpio.LOW)

 server = net.createServer(net.TCP, 30)

 server:listen(80, function(c)
  c:on("receive", function(c, pl)
    print(pl)
    if pl == 'PUSH' then
        print("SWITCHING")
        gpio.write(4, gpio.HIGH)
        tmr.register(0, 1000, tmr.ALARM_SINGLE, function() gpio.write(4, gpio.LOW) end)
        tmr.start(0)
    end
  end)
end)
