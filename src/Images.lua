local lg = love.graphics
lg.setDefaultFilter("nearest", "nearest", 1)

local images = {
    {
        lg.newImage("img/shuttle-alpha.png"),
        3, 3, 7, 7
    },
    {
        lg.newImage("img/station-alpha.png"),
        4, 4, 18, 18
    }
}

function images.draw(id, x, y, r)
    lg.draw(images[id][1], x, y, r, images[id][2], images[id][3], images[id][4], images[id][5])
end

return images
