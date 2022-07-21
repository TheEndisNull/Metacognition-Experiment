const jsPsych = initJsPsych({
    on_finish: function () {
        jsPsych.data.displayData();
    }
})
//dynamcally scales font size according to minotor height
function getFontSize() {
    return wd * .012 + "px 'Arial'"
}
//sets reusable variables for screen width and height that avoids scrollbals
var wd = window.innerWidth * .95
var ht = wd*(9/16)

var lineHt = [ht * .1, ht * .30]
var lineWd = [wd * .3, wd * .4, wd * .5, wd * .6, wd * .7]
var horseHt = [ht * .15, ht * .25]

//starting horse position
var picHorse1 = {
    obj_type: 'image',
    file: 'Support Files/horse1.png',
    scale: wd*.0001,
    origin_center: false,
    startX: lineWd[0],
    startY: horseHt[0],
}
//The ... notation reuses object parameters
var picHorse2 = {
    ...picHorse1,
    startY: horseHt[1],
}

var endTime = 1000

//Winning horse traverses X axis in less time than losing horse with endTime-250
var horse1win = {
    obj_type: 'image',
    file: 'Support Files/horse1.png',
    scale: wd*.0001,
    origin_center: false,
    startX: lineWd[0],
    startY: horseHt[0],
    endX: lineWd[4],
    endY: horseHt[0],
    motion_end_time: endTime - 250,
}
var horse1lose = {
    ...horse1win,
    motion_end_time: endTime,
}

var horse2win = {
    obj_type: 'image',
    file: 'Support Files/horse1.png',
    scale: wd*.0001,
    origin_center: false,
    startX: lineWd[0],
    startY: horseHt[1],
    endX: lineWd[4],
    endY: horseHt[1],
    motion_end_time: endTime - 250,
}

var horse2lose = {
    ...horse2win,
    motion_end_time: endTime,
}

//ending horse position
var horse1end = {
    obj_type: 'image',
    file: 'Support Files/horse1.png',
    scale: wd*.0001,
    origin_center: false,
    startX: lineWd[4],
    startY: horseHt[0],
}
var horse2end = {
    ...horse1end,
    startY: horseHt[1],
}

//drawing of track and field lines
var track = {
    field: {
        obj_type: 'rect',
        startX: wd * .5,
        startY: ht * .2,
        width: wd * .6,
        height: ht * .3,
        //line_color: 'black',
        fill_color: '#608038'
    }
}
track.board = {
    ...track.field,
    startX: wd * .2,
    width: wd * .1,
    line_color: 'black',
    line_width: 3,
    fill_color: '#FFFFFF'
}
track.line0 = {
    obj_type: 'line',
    x1: lineWd[0],
    x2: lineWd[0],
    y1: lineHt[0],
    y2: lineHt[1],
}

track.line1 = {
    ...track.line0,
    x1: lineWd[1],
    x2: lineWd[1]
}
track.line2 = {
    ...track.line0,
    x1: lineWd[2],
    x2: lineWd[2]
}

track.line3 = {
    ...track.line0,
    x1: lineWd[3],
    x2: lineWd[3]
}
track.line4 = {
    ...track.board,
    startX: lineWd[4],
    width: wd * .018,
    height: ht * .215,
    line_color: 'black',
    line_width: 3,
    fill_color: '#FFFFFF'
}
track.line5 = {
    obj_type: 'image',
    file: 'Support Files/Picture2.png',
    scale: wd*.000035,
    origin_center: false,
    startX: lineWd[4],
    startY: ht*.2
}
track.name1 = {
        obj_type: 'text',
        startX: wd * .2,
        startY: ht * .15,
        content: 'HORSE 1',
        font: getFontSize(),
        text_space: 50,
}
track.name2 = {
    ...track.name1,
    startX: wd * .2,
    startY: ht * .25,
    content: 'HORSE 2',
}


/*

y1: lineHt[0],
y2: lineHt[1],

track.line4 = {
    ...track.line0,
    x1: lineWd[4],
    x2: lineWd[4]
}
*/

