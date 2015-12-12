local lg = love.graphics
lg.setDefaultFilter("nearest", "nearest", 1)

local images = {
    { --shuttle
        lg.newImage("img/shuttle-alpha.png"),
        3, 3, 7, 7
    },
    { --ring station
        lg.newImage("img/station-alpha.png"),
        4, 4, 18, 18
    },
    { --star
        lg.newImage("img/star-template-alpha.png"),
        15, 15, 16, 16
    },
    { --planet (made for re-color)
        lg.newImage("img/color-world-alpha.png"),
        10, 10, 16, 16
    },
    { --world1
        lg.newImage("img/world1-alpha.png"),
        9, 9, 16, 16
    },
    { --world2 (with ring)
        lg.newImage("img/world2-alpha.png"),
        11, 11, 17, 17
    }
}

function images.draw(id, x, y, r)
    lg.draw(images[id][1], x, y, r, images[id][2], images[id][3], images[id][4], images[id][5])
end

return images
