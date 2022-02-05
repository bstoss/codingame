import UIKit
import Darwin


func shiftMessage(withRotors rotors: [String], message: String, operation: String) -> String {
    
    var shiftedMessage = message
    for rotor in operation == "ENCODE" ? rotors : rotors.reversed() {
        var newShift = ""
        for char in shiftedMessage {
            if operation == "ENCODE" {
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



let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

let operation = "ENCODE"
let startingShift = 7
let rotors = ["BDFHJLCPRTXVZNYEIWGAKMUSQO",
              "AJDKSIRUXBLHWTMCQGZNPYFVOE",
              "EKMFLGDQVZNTOWYHXUSPAIBRCJ"]
//let message = "PQSACVVTOISXFXCIAMQEM"
let message = "WEATHERREPORTWINDYTODAY"
//let result = "EVERYONEISWELCOMEHERE"
let result = "ALWAURKQEQQWLRAWZHUYKVN"

if operation == "ENCODE" {
    var shiftedMessage = ""
    var shift = startingShift
    for char in message {
        
        guard let startIndex = alphabet.firstIndex(of: char) else {
            continue
        }
        let intIndex = startIndex.utf16Offset(in: alphabet)
        if (intIndex + shift) >= 26 {
            let sum = intIndex + shift
            let minus = sum - (26*(Int(exactly: sum/26)!))
            let offset = minus - intIndex
            let index = alphabet.index(startIndex, offsetBy: offset)
            shiftedMessage += alphabet[index...index]
        } else {
            let index = alphabet.index(startIndex, offsetBy: shift)
            shiftedMessage += alphabet[index...index]
        }
 
        shift += 1
    }

    let rotatedMessage = shiftMessage(withRotors: rotors, message: shiftedMessage, operation: operation)
    
    print(rotatedMessage)
} else {
    let rotatedMessage = shiftMessage(withRotors: rotors, message: result, operation: operation)
    var shiftedMessage = ""
    var shift = startingShift
    
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
        print(newChar)
        shiftedMessage += String(newChar)

        shift += 1
    }
    
    print(shiftedMessage)
}
