local oldPlaySound = PlaySound
PlaySound = function(sound, ...)
    if type(sound)=="number" then
        return oldPlaySound(sound, ...)
    else
        local soundstring = tostring(sound)
        local source = gsub(strtrim(debugstack(2,1,0),".\n"),"Interface\\AddOns\\","")
        print("PSF: broken PlaySound(\""..soundstring.."\") called from "..source)
    end
end