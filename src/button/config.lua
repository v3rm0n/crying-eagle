local module = {}

module.SSID = {}  
module.SSID["RockFlagAndEagle"] = "CryingEagle"

module.ID = node.chipid()
module.SWITCH_PIN = 4
module.CONNECTION_PIN = 0

return module  
