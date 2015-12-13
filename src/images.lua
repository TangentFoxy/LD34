local lg = love.graphics
lg.setDefaultFilter("nearest", "nearest", 1)

local images = {
    {lg.newImage("img/shuttle-alpha.png"), 7, 7},         --1 shuttle (3)
    {lg.newImage("img/station-alpha.png"), 18, 18},       --2 ring station (4)
    {lg.newImage("img/star-template-alpha.png"), 16, 16}, --3 star (15)
    {lg.newImage("img/color-world-alpha.png"), 16, 16},   --4 planet (made for re-color) (10)
    {lg.newImage("img/world1-alpha.png"), 16, 16},        --5 world1 (9)
    {lg.newImage("img/world2-alpha.png"), 17, 17},        --6 world2 (with ring) (11)
    {lg.newImage("img/small/anon1.png"), 1.5, 1.5},       --7 anomaly1 (red target)
    {lg.newImage("img/small/anon2.png"), 5.5, 5.5},       --8 anomaly2 (green swirl)
    {lg.newImage("img/small/anon3.png"), 16, 16},         --9 anomaly3 (dark dots)
    {lg.newImage("img/small/ast1.png"), 1.5, 1.5},        --10 small asteroid
    {lg.newImage("img/small/ast2.png"), 0.5, 0.5},        --11 dot (darkest)
    {lg.newImage("img/small/ast3.png"), 0.5, 0.5},        --12 dot (middle)
    {lg.newImage("img/small/ast4.png"), 0.5, 0.5},        --13 dot (bright)
    {lg.newImage("img/small/ast5.png"), 2.5, 4},          --14 large asteroid
    {lg.newImage("img/small/ast6.png"), 2, 2},            --15 medium asteroid
    {lg.newImage("img/small/ast7.png"), 1, 1},            --16 small asteroid
    {lg.newImage("img/small/ast8.png"), 1.5, 2},          --17 medium asteroid
    {lg.newImage("img/small/missile.png"), 2, 4.5},       --18 missile (NOTE not centered on purpose!)
    {lg.newImage("img/small/deb1.png"), 3.5, 4},          --19 ? (yellow bit) debris
    {lg.newImage("img/small/deb2.png"), 2, 4},            --20 plate debris
    [25] = {lg.newImage("img/waypoint.png"), 2.5, 2.5},   --25 waypoint indicator
}

function images.draw(id, x, y, r, sx, sy)
    lg.draw(images[id][1], x, y, r, sx, sy, images[id][2], images[id][3])
end

return images
