// https://www.codingame.com/ide/puzzle/1d-spreadsheet

import Foundation

func debug(_ message: Any) {
    print(message)
}

var input = [
    "2",
    "ADD $1 20",
    "VALUE 32 _"
]

var output = [
    "52",
    "32"
]

@MainActor
func readLine() -> String? {
    input.removeFirst()
}

// START

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/
 enum Operation: String {
     case value = "VALUE"
     case add = "ADD"
     case sub = "SUB"
     case mult = "MULT"
 }

let N = Int(readLine()!)!
var storedInputs: [Int: [String]] = [:]
var cells: [Int] = Array(repeating: 0, count: N)
if N > 0 {
    for i in 0..<N {
        let inputs = (readLine()!).split(separator: " ").map(String.init)
        let arg1 = inputs[1]
        let arg2 = inputs[2]
        storedInputs[i] = [inputs[0], arg1, arg2]
    }
    
    repeat {
        for i in 0..<N {
            
            guard let inputs = storedInputs[i] else {
                continue
            }
            debug(i)
            debug(inputs)
            let operation = Operation(rawValue: inputs[0])!
            let arg1 = inputs[1]
            let arg2 = inputs[2]
            
            var firstNumber: Int = 0
            var secondNumber: Int = 0
            
            if arg1.contains("$") {
                
                let index = Int(arg1.split(separator: "$").first!)!
                
                guard storedInputs[index] == nil else {
                    continue
                }
                firstNumber = cells[index]
            } else {
                firstNumber = Int(arg1)!
            }
            
            if arg2.contains("$") {
                let index = Int(arg2.split(separator: "$").first!)!
                guard storedInputs[index] == nil else {
                    continue
                }
                
                secondNumber = cells[index]
                
            } else if arg2 != "_" {
                secondNumber = Int(arg2)!
            }
            
            storedInputs[i] = nil
            
            switch operation {
            case .value:
                cells[i] = firstNumber
            case .add:
                cells[i] = firstNumber + secondNumber
            case .sub:
                cells[i] = firstNumber - secondNumber
            case .mult:
                cells[i] = firstNumber * secondNumber
            }
            
            debug(cells)
        }
    } while !storedInputs.isEmpty
}
if N > 0 {
    for i in 0..<N {

        // Write an answer using print("message...")
        // To debug: print("Debug messages...", to: &errStream)

        print("\(cells[i])")
    }
}
