--@name Auto Respawn
--@author PrikolMen:-b
--@includedir starfall_plib
--@server

--[[-----------------
    Configuration
-----------------]]--

-- Respawn Delay in Seconds
local RESPAWN_DELAY = 3

--[[-----------------
         Code
-----------------]]--
dofile( 'starfall_plib/init.lua' )
local RunConsoleCommand = RunConsoleCommand
local timer_Simple = timer.Simple
local chipName = 'PLib - Auto Respawn'
local IsValid = IsValid
local plib = plib

hook.add('PlayerDeath', chipName, function( ply )
    if plib.IsOwner( ply ) then
        timer_Simple(RESPAWN_DELAY, function()
            if !IsValid( ply ) then return end
            RunConsoleCommand( '+jump' )
            timer_Simple(0, function()
                if !IsValid( ply ) then return end
                RunConsoleCommand( '-jump' )

                timer_Simple(0.5, function()
                    if IsValid( ply ) and ply:isAlive() then
                        plib.Log( chipName, 'User has successfully resurrected!' )
                    else
                        plib.Log( chipName, 'User revival was a failure...' )
                    end
                end)
            end)
        end)
    end
end)