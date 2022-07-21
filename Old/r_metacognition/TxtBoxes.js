var txtBoxCoord = [wd*.4, ht*6, wd*.6, ht*6,] //gives x and y coordinates for text 1 and 2 [X1, Y1, X2, Y2]
var textbox1Coord = [wd * .4, ht * .5]
var textbox2Coord = [wd * .6, ht * .5]
var textboxSize = [wd * .15, wd * .05]

function getFontSize() {
    window.innerWidth
    return window.innerHeight * .03 + "px 'Arial'"
}

function getBet(confidence, horse) {
    if (confidence == 1) {
        return 'I\'m sure horse \n' + horse + ' will win'
    } else {
        return 'I think horse \n' + horse + ' will win'

    }
}

var text1 = {
    obj_type: 'text',
    startX: textbox1Coord[0],
    startY: textbox1Coord[1],
    content: jsPsych.timelineVariable('person1'),
    font: getFontSize(),
    text_color: 'black',
    text_space: window.innerHeight*.03,
}

var text2 = {
    obj_type: 'text',
    startX: textbox2Coord[0],
    startY: textbox2Coord[1],
    content: jsPsych.timelineVariable('person2'),
    font: getFontSize(),
    text_color: 'black',
    text_space: window.innerHeight*.03,
}

var text3 = {
    obj_type: 'text',
    startX: wd*.5,
    startY: ht*.75,
    content: 'Press 1 to bet on horse 1 \n or press 2 to bet on horse 2.',
    font: getFontSize(),
    text_color: 'black',
    text_space: window.innerHeight*.03,
}

var person1 = {
    obj_type: 'image',
    file: 'person1.png',
    scale: .2,
    origin_center: false,
    startX: wd*.3, // location in the canvas
    startY: ht*.6,
}

var person2 = {
    obj_type: 'image',
    file: 'person2.png',
    scale: .2,
    origin_center: false,
    startX: wd*.7, // location in the canvas
    startY: ht*.6,
}

var raceStart = [
    track,
    person1,
    person2,
    text1,
    text2,
    text3,
    line0,
    line1,
    line2,
    line3,
    line4,
    horse1,
    horse2,
]

var textWin = {
    obj_type: 'text',
    startX: wd*.5,
    startY: ht*.65,
    content: 'You Win!',
    show_start_time: 1000,
    font: getFontSize(),
    text_space: 50,
    text_color: 'black',
}

var textLose = {
    obj_type: 'text',
    startX: wd*.5,
    startY: ht*.65,
    content: 'You Lose',
    show_start_time: 1000,
    font: getFontSize(),
    text_space: 50,
    text_color: 'black',
}

///////////////////////////////////////
var h1cor = [
    track,
    person1,
    person2,
    text1,
    text2,

    line0,
    line1,
    line2,
    line3,
    line4,
    horse1win,
    horse2lose,
    textWin,
]
var h1wrg = [
    track,
    person1,
    person2,
    text1,
    text2,

    line0,
    line1,
    line2,
    line3,
    line4,
    horse1win,
    horse2lose,
    textLose,
]
var h2cor = [
    track,
    person1,
    person2,
    text1,
    text2,
    line0,
    line1,
    line2,
    line3,
    line4,
    horse1lose,
    horse2win,
    textWin,
]
var h2wrg = [
    track,
    person1,
    person2,
    text1,
    text2,
    line0,
    line1,
    line2,
    line3,
    line4,
    horse1lose,
    horse2win,
    textLose,
]