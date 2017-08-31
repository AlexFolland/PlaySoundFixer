local oldPlaySound = PlaySound
PlaySound = function(sound, ...)
    if type(sound)=="number" then
        return oldPlaySound(sound, ...)
    end

    local soundstring = tostring(sound)
    local converted = ''
    for i = 1, #soundstring do
        local c = soundstring:sub(i,i)
        if converted ~= '' and c == c:upper() then
            converted = converted .. "_"
        end
        converted = converted .. c:upper()
    end

    local source = gsub(strtrim(debugstack(2,1,0),".\n"),"Interface\\AddOns\\","")
    print("PSF: broken PlaySound(\""..soundstring.."\") called from "..source..(SOUNDKIT[converted] and " and converted to ".."PlaySound(SOUNDKIT["..converted.."]) for playback" or ""))

    if SOUNDKIT[converted] then return oldPlaySound(SOUNDKIT[converted], ...) end
end