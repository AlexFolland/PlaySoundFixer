local function subrange(t, first, last)
    local sub = { }
    for i = first, last do
        sub[#sub + 1] = t[i]
    end
    return sub
end

local oldPlaySound = PlaySound

PlaySound = function(sound, ...)

    if (type(sound) == "number") then
        return oldPlaySound(sound, ...)
    end

    local soundstring = tostring(sound)
    
    local words  = { }
    local word = ''
    local count = 1
    for i = 1, #soundstring do
        local c = soundstring:sub(i, i)
        if word ~= '' and c == c:upper() then
            table.insert(words, word)
            count = count + 1
            word = ''
        end
        word = word .. c:upper()
    end
    
    table.insert(words, word)
    converted = table.concat(words, '_')
    
    if (SOUNDKIT[converted] == nil) then
        for i = 2, count - 1 do
            local first = subrange(words, 0, i)
            local last = subrange(words, i + 1, count)
            local test = table.concat(first, '_') .. table.concat(last, '_')
            if (SOUNDKIT[test] ~= nil) then
                converted = test
            end
        end
    end

    local patterns = {"\n", "^.-AddOns%\\", ": in function.*$"}
    local source = debugstack(2, 1, 0)
    for i = 1, #patterns do source = gsub(source, patterns[i], "") end
    print("PSF: broken PlaySound(\""..soundstring.."\") called from "..source..(SOUNDKIT[converted] and " and converted to ".."PlaySound(SOUNDKIT["..converted.."]) for playback" or ""))

    if (SOUNDKIT[converted]) then return oldPlaySound(SOUNDKIT[converted], ...) end
end