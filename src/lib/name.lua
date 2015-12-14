love.math.setRandomSeed(os.time())
local floor = math.floor
local random = math.random
local randomNormal = love.math.randomNormal

local name = {}

function name.generate(min, max)
    local mean = floor(min + (max - min)/2)
    local stddev = (max - min)/2
    local length = randomNormal(stddev, mean)
    if length <= 0 then length = 1 end

    local result = ""
    while #result < length do
        local letter = random(0, 106)
        if letter < 9 then
            result = result .. "a"
        elseif letter < 11 then
            result = result .. "b"
        elseif letter < 14 then
            result = result .. "c"
        elseif letter < 18 then
            result = result .. "d"
        elseif letter < 31 then
            result = result .. "e"
        elseif letter < 33 then
            result = result .. "f"
        elseif letter < 35 then
            result = result .. "g"
        elseif letter < 41 then
            result = result .. "h"
        elseif letter < 49 then
            result = result .. "i"
        elseif letter < 50 then
            result = result .. "j"
        elseif letter < 51 then
            result = result .. "k"
        elseif letter < 55 then
            result = result .. "l"
        elseif letter < 57 then
            result = result .. "m"
        elseif letter < 64 then
            result = result .. "n"
        elseif letter < 72 then
            result = result .. "o"
        elseif letter < 74 then
            result = result .. "p"
        elseif letter < 75 then
            result = result .. "q"
        elseif letter < 81 then
            result = result .. "r"
        elseif letter < 87 then
            result = result .. "s"
        elseif letter < 96 then
            result = result .. "t"
        elseif letter < 99 then
            result = result .. "u"
        elseif letter < 100 then
            result = result .. "v"
        elseif letter < 102 then
            result = result .. "w"
        elseif letter < 103 then
            result = result .. "x"
        elseif letter < 105 then
            result = result .. "y"
        else
            result = result .. "z"
        end
        --[[ modified from Wikipedia's list of English letter frequencies
            a	8
            b	2
            c	3
            d	4
            e	13
            f	2
            g	2
            h	6
            i	7
            j	1
            k	1
            l	4
            m	2
            n	7
            o	8
            p	2
            q	1
            r	6
            s	6
            t	9
            u	3
            v	1
            w	2
            x	1
            y	2
            z	1
        ]]
    end

    return result
end

return name
