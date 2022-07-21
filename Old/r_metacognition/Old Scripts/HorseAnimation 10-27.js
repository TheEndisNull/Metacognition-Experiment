var horse1win = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 200,
    change_attr: function (stim, times, frames) { // called by the requestAnimationFrame
        if (times < 1000) { stim.startX = 460 + times }
    }
}

var horse1lose = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 200,
    change_attr: function (stim, times, frames) { // called by the requestAnimationFrame
        if (times < 1000) { stim.startX = 460 + (times * .9) }
    }
}

var horse2win = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 300,
    change_attr: function (stim, times, frames) { // called by the requestAnimationFrame
        if (times < 1000) { stim.startX = 460 + times }
    }
}

var horse2lose = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 300,
    change_attr: function (stim, times, frames) { // called by the requestAnimationFrame
        if (times < 1000) { stim.startX = 460 + (times * .9) }
    }
}

var horse1 = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 200,

}

var horse2 = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: 460, // location in the canvas
    startY: 300,

}

var line0 = {
    obj_type: 'line',
    x1: 460,
    y1: 100,
    x2: 460,
    y2: 500,
}

var line1 = {
    obj_type: 'line',
    x1: 710,
    y1: 100,
    x2: 710,
    y2: 500,
}

var line2 = {
    obj_type: 'line',
    x1: 960,
    y1: 100,
    x2: 960,
    y2: 500,
}

var line3 = {
    obj_type: 'line',
    x1: 1210,
    y1: 100,
    x2: 1210,
    y2: 500,
}

var line4 = {
    obj_type: 'line',
    x1: 1460,
    y1: 100,
    x2: 1460,
    y2: 500,
}