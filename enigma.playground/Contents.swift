// https://www.codingame.com/ide/puzzle/encryptiondecryption-of-enigma-machine

import UIKit
import Darwin

// input from game
var inputEncode = ["ENCODE",
             "4",
             "BDFHJLCPRTXVZNYEIWGAKMUSQO",
             "AJDKSIRUXBLHWTMCQGZNPYFVOE",
             "EKMFLGDQVZNTOWYHXUSPAIBRCJ",
             "AAA"]
var expectedEncode = ["KQF"]

var inputDecode = ["DECODE",
                 "5",
                 "BDFHJLCPRTXVZNYEIWGAKMUSQO",
                 "AJDKSIRUXBLHWTMCQGZNPYFVOE",
                 "EKMFLGDQVZNTOWYHXUSPAIBRCJ",
                 "XPCXAUPHYQALKJMGKRWPGYHFTKRFFFNOUTZCABUAEHQLGXREZ"]

var expectedDecode = ["THEQUICKBROWNFOXJUMPSOVERALAZYSPHINXOFBLACKQUARTZ"]

func readLine() -> String? {
    return inputEncode.removeFirst()
}

func expected() -> String {
    return expectedEncode.removeFirst()
}

// Code starts here
let operationInput = readLine()!
let pseudoRandomNumber = Int(readLine()!)!
var rotors: [String] = []
for i in 0...2 {
    let rotor = readLine()!
    rotors.append(rotor)
}
let message = readLine()!

let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

func rotorMessage(withRotors rotors: [String], message: String, operation: Operation) -> String {
    
    var shiftedMessage = message
    for rotor in operation == .encode ? rotors : rotors.reversed() {
        var newShift = ""
        for char in shiftedMessage {
            if operation == .encode {
                guard let index = alphabet.firstIndex(of: char) else {
                    continue
                }
                newShift += rotor[index...index]
            } else {
                guard let index = rotor.firstIndex(of: char) else {
                    continue
                }
                newShift += alphabet[index...index]
            }
        }
        shiftedMessage = newShift
    }
    
    return shiftedMessage
}


func encode(_ message: String, rotors: [String], pseudoRandomNumber: Int) -> String {
    var shiftedMessage = ""
    var shift = pseudoRandomNumber
    
    shiftedMessage = message.map { char in
        let startIndex = alphabet.firstIndex(of: char)!
        let intIndex = startIndex.utf16Offset(in: alphabet)
        let targetIndex = Int(exactly: (intIndex+shift)%alphabet.count)!
        
        let index = alphabet.index(startIndex, offsetBy: targetIndex - intIndex)
        let newChar = alphabet[index]
        shift += 1
        
        return String(newChar)
    }.joined()

    return rotorMessage(withRotors: rotors, message: shiftedMessage, operation: .encode)
}

func decode(_ message: String, rotors: [String], pseudoRandomNumber: Int) -> String {
    let rotatedMessage = rotorMessage(withRotors: rotors, message: message, operation: .decode)
    var shiftedMessage = ""
    var shift = pseudoRandomNumber
    
    for char in rotatedMessage {

        let startIndex = alphabet.firstIndex(of: char)!
        let startInt = startIndex.utf16Offset(in: alphabet)
        var targetInt = startInt - shift
        while targetInt < 0{
            targetInt+=26
        }
        targetInt = targetInt - startInt
        let targetIndex = alphabet.index(startIndex, offsetBy: targetInt)
        
        let newChar = alphabet[targetIndex]
        shiftedMessage += String(newChar)

        shift += 1
    }
    
    return shiftedMessage
}

enum Operation: String {
    case encode = "ENCODE"
    case decode = "DECODE"
}

let operation = Operation(rawValue: operationInput)!

switch operation {
case .encode:
    let encodedMessage = encode(message, rotors: rotors, pseudoRandomNumber: pseudoRandomNumber)
    print(encodedMessage)
case .decode:
    let decodedMessage = decode(message, rotors: rotors, pseudoRandomNumber: pseudoRandomNumber)
    print(decodedMessage)
}

// code ends here
print(expected())
