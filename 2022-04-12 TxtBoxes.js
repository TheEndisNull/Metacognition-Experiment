var txtLCoord = [wd * .4, ht * .47]
var txtRCoord = [wd * .6, ht * .47]
var keys = ['z', 'm']



var strtTime = 700

/*
shp = shape
pic = picture
txt = text
.l and .r designate left and right advisor
*/
//text for the left and right advisor is dynamically generated in the timelineVariable
var txtAdv = {
    l: {
        obj_type: 'text',
        startX: txtLCoord[0],
        startY: txtLCoord[1],
        content: jsPsych.timelineVariable('advL'),
        font: getFontSize(),
        text_color: 'black',
        text_space: window.innerHeight * .03,
        show_start_time: strtTime
    }
}
txtAdv.r = {
    ...txtAdv.l,
    startX: txtRCoord[0],
    startY: txtRCoord[1],
    content: jsPsych.timelineVariable('advR'),
}

var txtRsp = {  //text response
    l: {
        obj_type: 'text',
        startX: wd * .43,
        startY: ht * .8,
        content: 'Press ' + keys[0] + ' to\nbet on horse 1.',
        font: getFontSize(),
        text_color: 'black',
        text_space: window.innerHeight * .03,
        show_start_time: strtTime
    }
}
txtRsp.r = {
    ...txtRsp.l,
    startX: wd * .57,
    content: 'Press ' + keys[1] + ' to\nbet on horse 2.',
}

var shpRspBbl = {   //response bubble
    l: {
        obj_type: 'rect',
        startX: wd * .43,
        startY: ht * .8,
        width: wd * .13,
        height: ht * .1,
        line_width: 3,
        line_color: 'black',
        fill_color: 'white'
    }
}
shpRspBbl.r = {
    ...shpRspBbl.l,
    startX: wd * .57,
}
shpRspBbl.c = {
    ...shpRspBbl.l,
    startX: wd * .5,
    startY: ht * .65,
    width: wd * .1,
    height: ht * .1,
}

var shpAdvBbl = {   //advisor text bubble
    l: {
        obj_type: 'image',
        file: 'Support Files/BblL.svg',
        scale: wd*.0001,
        origin_center: false,
        startX: txtLCoord[0],
        startY: ht * .49
    }
}
shpAdvBbl.r = {
    ...shpAdvBbl.l,
    file: 'Support Files/BblR.svg',
    startX: txtRCoord[0],
}

function getPicScale(scale) {
    return window.innerHeight * scale / 1000
}

var picAdv = {
    l: {
        obj_type: 'image',
        file: 'Support Files/advL.png',
        scale: wd*.00055,
        origin_center: false,
        startX: wd * .285, // location in the canvas
        startY: ht * .6,
    }
}
picAdv.r = {
    ...picAdv.l,
    file: 'Support Files/advR.png',
    startX: wd * .715, // location in the canvas
}

//stimuli used called by main trial
var raceStart = [
    shpAdvBbl.l,
    shpAdvBbl.r,
    picAdv.l,
    picAdv.r,
    txtAdv.l,
    txtAdv.r,
    shpRspBbl.r,
    shpRspBbl.l,
    shpRspBbl.c,
    txtRsp.l,
    txtRsp.r,
    track.field,
    track.board,
    track.line0,
    track.line1,
    track.line2,
    track.line3,
    track.line4,
    track.line5,
    track.name1,
    track.name2,
    picHorse1,
    picHorse2,
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

txtAdv.Waitl = {
    ...txtAdv.l,
    content: '...',
    show_start_time: 0,
    show_end_time: 1000
    
}
txtAdv.Waitr = {
    ...txtAdv.r,
    content: '...',
    show_start_time: 0,
    show_end_time: 1000
}

txtAdv.Rsltr = {
    ...txtAdv.r,
    show_start_time: 0,
    content: jsPsych.timelineVariable('advRsltTxt'),
}

txtAdv.Rsltl = {
    ...txtAdv.l,
    show_start_time: 0,
    content: jsPsych.timelineVariable('advLsltTxt'),
}

var base = [
    shpAdvBbl.l,
    shpAdvBbl.r,
    picAdv.l,
    picAdv.r,
    shpRspBbl.r,
    shpRspBbl.l,
    shpRspBbl.c,
    track.field,
    track.board,
    track.line0,
    track.line1,
    track.line2,
    track.line3,
    track.line4,
    track.line5,
    track.name1,
    track.name2,
]

//used for outcome playback in main trial
var h1 = base.concat([
    txtAdv.Waitl,
    txtAdv.Waitr,
    txtAdv.Rsltl,
    txtAdv.Rsltr,
])
var h2 = h1.concat([
    horse2win,
    horse1lose,
])
h1 = h1.concat([
    horse1win,
    horse2lose,
])

var rsltScreenWin = base.concat([
    txtAdv.Rsltr,
    txtAdv.Rsltl,
    horse1end,
    horse2end,
])
var rsltScreenLose = rsltScreenWin.concat([
    txtLose
])
rsltScreenWin = rsltScreenWin.concat([
    txtWin
])