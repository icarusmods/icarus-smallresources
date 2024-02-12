Config = {}
isr = {}
Config.bfdisable = true 
-- Disable blind-firing, removes blind firing behind cover

Config.spdisable = true
-- Disable spam punching, must be targeting player/ped to swing

Config.crdisable = true 
-- Disable combat roll

Config.ftdisable = true 
-- Disable flashlight turning off after un-aiming

Config.amdisable = true 
-- Disable "action mode" (the stance after shooting or swinging)

Config.FPShooting = true 
-- Forces first person while shooting from car

Config.bhdisable = true
-- Ragdoll while bunnyhopping?

Config.rdchance = 0.5
-- Chance of ragolling while jumping if Config.bhdisable is true (0.5 = 50%)

Config.pistolwhip = true
-- Removes pistol whipping

isr.Blips = {
    ['Test'] = {			-- put as "isr.blips = {}" if you dont want to use blips
        Coords = vector3(200,200,200),
        Sprite = 1,
        Color = 1,
        Size = 1.0,
        AlwaysShow = false,
    },
}