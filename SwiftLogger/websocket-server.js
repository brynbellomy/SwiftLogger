#!/usr/bin/env node

var chalk = require('chalk')

var WebSocketServer = require('ws').Server
var server = new WebSocketServer({ port: 8080 })




server.on('connection', function connection(websocket) {
    websocket.on('message', function incoming(messageJson) {

        var message = JSON.parse(messageJson)
        var formattedMessage = formatMessage(message)
        process.stdout.write(formattedMessage + "\n")
    })

    // websocket.send('something')
})



var previous = {
    file: null,
    line: null,
    func: null,
}

function formatMessage(message)
{
    var level = formatLevel(message)
    var line  = formatLine(message, message)
    var file  = formatFile(message)
    var func  = formatFunction(message)
    var text  = message.message

    function bracket(text) {
        return chalk.white.bold(text)
    }

    var formattedMessage = bracket('[') + file + ':' + line + bracket(']') + ' ' + func + ' ' + '[' + level + '] ' + text
    return formattedMessage
}


function formatLevel(message)
{
    var level = message.level
    switch (level) {
        case 'error'   : level = chalk.red(level)
        case 'warning' : level = chalk.yellow(level)
        case 'info'    : level = chalk.blue(level)
        case 'debug'   : level = chalk.magenta(level)
        case 'verbose' : level = chalk.cyan(level)
        case 'success' : level = chalk.green(level)
    }
    return level
}


function formatLine(message)
{
    var line = message.line
    if (previous.file == message.file && previous.line == line) {
        return Array(line.length + 1).join(' ')
    }
    previous.line = line

    line = chalk.cyan(line)
    return line
}


function formatFile (message)
{
    var file = message.file
    if (previous.file == file) {
        return Array(file.length + 1).join(' ')
    }
    previous.file = file

    file = chalk.blue.underline(file)
    return file
}


function formatFunction (message)
{
    var func = message['function']
    if (previous.func == func) {
        return Array(func.length + 1).join(' ')
    }
    previous.func = func

    func = chalk.yellow(func)
    return func
}





