var txtLCoord = [wd * .4, ht * .47]
var txtRCoord = [wd * .6, ht * .47]

function getFontSize() {
    window.innerWidth
    return window.innerHeight * .02 + "px 'Arial'"
}

var txtAdv = {
    l: {
        obj_type: 'text',
        startX: txtLCoord[0],
        startY: txtLCoord[1],
        content: jsPsych.timelineVariable('advL'),
        font: getFontSize(),
        text_color: 'black',
        text_space: window.innerHeight * .03,
    }
}
txtAdv.r = {
    ...txtAdv.l,
    startX: txtRCoord[0],
    startY: txtRCoord[1],
    content: jsPsych.timelineVariable('advR'),
}

var txtRsp = {
    l: {
        obj_type: 'text',
        startX: wd * .43,
        startY: ht * .8,
        content: 'Press 1 to\nbet on horse 1.',
        font: getFontSize(),
        text_color: 'black',
        text_space: window.innerHeight * .03,
    }
}
txtRsp.r = {
    ...txtRsp.l,
    startX: wd * .57,
    content: 'Press 2 to\nbet on horse 2.',
}

var txtRspBbl = {
    l: {
        obj_type: 'rect',
        startX: wd * .57,
        startY: ht * .8,
        width: wd * .1,
        height: ht * .1,
        line_width: 3,
        line_color: 'black',
        fill_color: 'white'
    }
}
txtRspBbl.r = {
    ...txtRspBbl.l,
    startX: wd * .43,
}
txtRspBbl.c = {
    ...txtRspBbl.l,
    startX: wd * .5,
    startY: ht * .65,
    width: wd * .1,
    height: ht * .05,
}

var txtBbl = {
    l: {
        obj_type: 'image',
        file: 'BblL.svg',
        scale: .2,
        origin_center: false,
        startX: txtLCoord[0],
        startY: ht * .49
    }
}
txtBbl.r = {
    ...txtBbl.l,
    file: 'BblR.svg',
    startX: txtRCoord[0],
}

var adv = {
    l: {
        obj_type: 'image',
        file: 'advL.png',
        scale: .2,
        origin_center: false,
        startX: wd * .3, // location in the canvas
        startY: ht * .6,
    }
}
adv.r = {
    ...adv.l,
    file: 'advR.png',
    startX: wd * .7, // location in the canvas
}

var advL = {
    obj_type: 'image',
    file: 'advL.png',
    scale: .2,
    origin_center: false,
    startX: wd * .3, // location in the canvas
    startY: ht * .6,
}
var advR = {
    ...advL,
    file: 'advR.png',
    startX: wd * .7, // location in the canvas
}

var raceStart = [
    txtBbl.l,
    txtBbl.r,
    adv.l,
    adv.r,
    txtAdv.l,
    txtAdv.r,
    txtRspBbl.r,
    txtRspBbl.l,
    txtRspBbl.c,
    txtRsp.l,
    txtRsp.r,
    track,
    line0,
    line1,
    line2,
    line3,
    line4,
    horse1,
    horse2,
]

var txtWin = {
    obj_type: 'text',
    startX: wd * .5,
    startY: ht * .65,
    content: 'You Win!',
    font: getFontSize(),
    text_space: 50,
    text_color: 'green',
}
var txtLose = { ...txtWin }
txtLose.content = 'You Lose'
txtLose.text_color = 'red'

txtAdv.lMotn = {
    ...txtAdv.l,
    content: '...',
    show_end_time: 1000
}
txtAdv.rMotn = {
    ...txtAdv.r,
    content: '...',
    show_end_time: 1000
}

txtAdv.rMotn1 = {
    ...txtAdv.r,
    content: jsPsych.timelineVariable('advRsltTxt'),
}

txtAdv.lMotn1 = {
    ...txtAdv.l,
    content: jsPsych.timelineVariable('advLsltTxt'),
}

///////////////////////////////////////
var base = [
    txtBbl.l,
    txtBbl.r,
    adv.l,
    adv.r,
    txtRspBbl.r,
    txtRspBbl.l,
    txtRspBbl.c,
    track,
    line0,
    line1,
    line2,
    line3,
    line4,
]

var h1 = base.concat([
    horse1win,  
    horse2lose, 
    txtAdv.lMotn,
    txtAdv.rMotn,
    txtAdv.lMotn1,
    txtAdv.rMotn1,
])

var h2 = base.concat([
    horse2win,  
    horse1lose, 
    txtAdv.lMotn,
    txtAdv.rMotn,
    txtAdv.lMotn1,
    txtAdv.rMotn1,
])

var rsltScreenWin = base.concat([
    txtAdv.rMotn1,
    txtAdv.lMotn1,
    horse1end,
    horse2end,
    txtWin
])

var rsltScreenLose = base.concat([
    txtAdv.rMotn1,
    txtAdv.lMotn1,
    horse1end,
    horse2end,
    txtLose
])

