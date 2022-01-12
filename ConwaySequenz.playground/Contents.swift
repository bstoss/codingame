//import Glibc
import Foundation

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

func debug(_ message: String) {
    print(message, to: &errStream)
}

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

let R = 1
let L = 11

// Write an action using print("message...")
// To debug: print("Debug messages...", to: &errStream)

var conSeq = "\(R)"

for i in 1...L {

    let nums = conSeq.characters.split{$0 == " "}.map{Int(String($0))!}
    debug("\(nums)")

    var currentNumber: Int?
    var countOfNumber = 0
    var output = ""

    for num in nums {

        guard let number = currentNumber else {
            currentNumber = num
            countOfNumber = 1
            continue
        }
        if number != num {
            if output.isEmpty {
                output.append("\(countOfNumber) \(number)")
            } else {
                output.append(" \(countOfNumber) \(number)")
            }
            currentNumber = num
            countOfNumber = 1
        } else {
            countOfNumber += 1
        }
    }

    if output.isEmpty {
        output.append("\(countOfNumber) \(currentNumber!)")
    } else {
        output.append(" \(countOfNumber) \(currentNumber!)")
    }

    conSeq = output
}

print(conSeq)
