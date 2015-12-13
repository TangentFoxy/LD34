local lg = love.graphics
lg.setDefaultFilter("nearest", "nearest", 1)

local images = {
    {lg.newImage("img/shuttle-alpha.png"), 7, 7},         --shuttle (3)
    {lg.newImage("img/station-alpha.png"), 18, 18},       --ring station (4)
    {lg.newImage("img/star-template-alpha.png"), 16, 16}, --star (15)
    {lg.newImage("img/color-world-alpha.png"), 16, 16},   --planet (made for re-color) (10)
    {lg.newImage("img/world1-alpha.png"), 16, 16},        --world1 (9)
    {lg.newImage("img/world2-alpha.png"), 17, 17}         --world2 (with ring) (11)
}

function images.draw(id, x, y, r, sx, sy)
    lg.draw(images[id][1], x, y, r, sx, sy, images[id][2], images[id][3])
end

return images
