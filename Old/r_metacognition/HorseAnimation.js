var wd = window.innerWidth * .95
var ht = window.innerHeight * .95

var lineHt = [ht * .1, ht * .30]
var lineWd = [wd * .3, wd * .4, wd * .5, wd * .6, wd * .7]
var horseHt = [ht * .15, ht * .25]
var endTime = 1000

var horse1win = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[0],
    endX: lineWd[4],
    endY: horseHt[0],
    motion_end_time: endTime,
}

var horse1lose = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[0],
    endX: lineWd[3],
    endY: horseHt[0],
    motion_end_time: endTime,
}

var horse2win = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[1],
    endX: lineWd[4],
    endY: horseHt[1],
    motion_end_time: endTime,

}

var horse2lose = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[1],
    endX: lineWd[3],
    endY: horseHt[1],
    motion_end_time: endTime,

}

var horse1 = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[0],

}

var horse2 = {
    obj_type: 'image',
    file: 'horse1.png',
    scale: .2,
    origin_center: false,
    startX: lineWd[0], // location in the canvas
    startY: horseHt[1],

}

var lineHt = [ht * .1, ht * .30]
var lineWd = [wd * .3, wd * .4, wd * .5, wd * .6, wd * .7]



var track = {
    obj_type: 'rect',        
    startX: 'center', // location of the rectangle's center in the canvas
    startY: ht*.2,
    width: wd*.7,
    height: ht*.3,
    line_color: 'black',
    fill_color: '#82E0AA'
}

var line0 = {
    obj_type: 'line',
    x1: lineWd[0],
    y1: lineHt[0],
    x2: lineWd[0],
    y2: lineHt[1],
}

var line1 = {
    obj_type: 'line',
    x1: lineWd[1],
    y1: lineHt[0],
    x2: lineWd[1],
    y2: lineHt[1],
}

var line2 = {
    obj_type: 'line',
    x1: lineWd[2],
    y1: lineHt[0],
    x2: lineWd[2],
    y2: lineHt[1],
}

var line3 = {
    obj_type: 'line',
    x1: lineWd[3],
    y1: lineHt[0],
    x2: lineWd[3],
    y2: lineHt[1],
}

var line4 = {
    obj_type: 'line',
    x1: lineWd[4],
    y1: lineHt[0],
    x2: lineWd[4],
    y2: lineHt[1],
}