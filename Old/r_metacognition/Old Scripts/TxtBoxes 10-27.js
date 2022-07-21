var txtBoxCoord = [560, 740, 1360, 740] //gives x and y coordinates for text 1 and 2 [X1, Y1, X2, Y2]

var text1 = {
    obj_type: 'text',
    startX: txtBoxCoord[0],
    startY: txtBoxCoord[1],
    content: jsPsych.timelineVariable('person1'),
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

var text2 = {
    obj_type: 'text',
    startX: txtBoxCoord[2],
    startY: txtBoxCoord[3],
    content: jsPsych.timelineVariable('person2'),
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}
var racersTitle = {
    obj_type: 'text',
    startX: 250,
    startY: 100,
    content: 'Racers',
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

var racers1 = {
    obj_type: 'text',
    startX: 250,
    startY: 200,
    content: function () {
        return '#1 ' + jsPsych.timelineVariable('names1')
    },
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

var racers2 = {
    obj_type: 'text',
    startX: 250,
    startY: 300,
    content: function () {
        return '#2 ' + jsPsych.timelineVariable('names2')
    },
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

var raceStart = [
    text1,
    text2,
    line0,
    line1,
    line2,
    line3,
    line4,
    horse1,
    horse2,
    racers1,
    racers2,
    racersTitle,
]

var textWin = {
    obj_type: 'text',
    startX: 960,
    startY: 540,
    content: 'You Win!',
    show_start_time: 1000,
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

var textLose = {
    obj_type: 'text',
    startX: 960,
    startY: 540,
    content: 'You Lose',
    show_start_time: 1000,
    font: "30px 'Arial'",
    text_space: 50,
    text_color: 'black',
}

///////////////////////////////////////
var h1cor = [
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
    racers1,
    racers2,
    racersTitle,
]
var h1wrg = [
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
    racers1,
    racers2,
    racersTitle,
]
var h2cor = [
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
    racers1,
    racers2,
    racersTitle,
]
var h2wrg = [
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
    racers1,
    racers2,
    racersTitle,
]