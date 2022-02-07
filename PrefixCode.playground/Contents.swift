// https://www.codingame.com/ide/puzzle/prefix-code

import UIKit
import Darwin

var inputEasy = ["5",
                 "1 97",
                 "001 98",
                 "000 114",
                 "011 99",
                 "010 100",
                 "10010001011101010010001"]

var inputWithFailure = ["18",
                        "11 32",
                        "1001 97",
                        "000011 98",
                        "000010 99",
                        "0011 100",
                        "011 101",
                        "000001 102",
                        "00101 104",
                        "000000 73",
                        "00100 105",
                        "10111 108",
                        "1000 110",
                        "00011 111",
                        "10110 114",
                        "010 116",
                        "10101 118",
                        "00010 120",
                        "10100 58",
                        "0000001000101011001101110010000111110100110110001001010110100111000011001000101110010101101000101011110111000001111000110000011101000101011110111000000010000110011011001111010011000100101"]

var expectedEasy = ["abracadabra"]

var expectedWithFailure = ["DECODE FAIL AT INDEX 186"]

func readLine() -> String? {
    return inputWithFailure.removeFirst()
}

func expected() -> String {
    return expectedWithFailure.removeFirst()
}



// code begins here


func debug(_ message: String) {
//    print(message, to: &errStream)
    print(message)
    
}

var codec: [String: Int] = [:]

let n = Int(readLine()!)!
if n > 0 {
    for _ in 0...(n-1) {
        let inputs = (readLine()!).split(separator: " ").map(String.init)
        let b = inputs[0]
        let c = Int(inputs[1])!
        codec[b] = c
    }
}
var s = readLine()!
var output = ""
var currentPos = 0

while !s.isEmpty {
    var changed = false
    for (bi, ci) in codec {
        guard !s.isEmpty else {
            break
        }
        guard s.count >= bi.count else {
            continue
        }
        let endIndex = s.index(s.startIndex, offsetBy: bi.count-1)
        let string = s[s.startIndex...endIndex]
        if string == bi {
            currentPos += bi.count
            output += String(UnicodeScalar(ci)!)
            s.removeSubrange(s.startIndex...endIndex)
            changed = true
            
            debug(s)
            debug("\(currentPos)")
        }
    }
    
    if changed == false {
        output = "DECODE FAIL AT INDEX \(currentPos)"
        break
    } else {
        changed = false
    }
}

if output == "" {
    output = "DECODE FAIL AT INDEX 0"
}

// Write an answer using print("message...")
// To debug: print("Debug messages...", to: &errStream)

print(output)


// end code

print(expected())
