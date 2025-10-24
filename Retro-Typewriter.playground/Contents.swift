// https://www.codingame.com/ide/puzzle/retro-typewriter-art

import Foundation

func debug(_ message: Any) {
    print(message)
}

var input = [
    "nl 1sp 2_ 1( 1sp 1) 1_ nl 1( 6sp 1( 1o 4_ nl 1sp 1| 10sp 1| nl 1sp 1| 6sp 1( 2_ 1/ nl 3sp 1bS 5sp 1/ 3sp 3_ nl 3sp 1/ 5sp 1bS 2sp 1bS 3_ 1/ nl 1sp 1/ 4sp 1^ 4sp 1/ 5sp 1bS nl 1| 3sp 1| 2sp 1| 2_ 1| 1_ 1H 1U 2N 1Y 1sp 1| nl 1| 4sp 1bS 6_ 1) 4_ 1/ nl 1sp 1bS 9sp 1/ nl 3sp 1bS 5sp 1/ 1_ nl 4sp 1| 2sp 1( 1sp 2_ 1) nl 4sp 1( 4_ 1)"
]


@MainActor
func readLine() -> String? {
    input.removeFirst()
}

// START
 
let T = readLine()!

// split nl does not work in codingame
var inputLines = T.split(separator: " ")
var outputLines: [String] = []
var output = ""
for line in inputLines {
    guard line != "nl" else {
        print(output)
        output = ""
        continue
    }
    
    let number: Int
    let repeatingChar: String
    
    if line.contains("sp") {
        number = Int(line.replacingOccurrences(of: "sp", with: ""))!
        repeatingChar = " "
    } else if line.contains("bS") {
        number = Int(line.replacingOccurrences(of: "bS", with: ""))!
        repeatingChar = "\\"
    } else if line.contains("sQ") {
        number = Int(line.replacingOccurrences(of: "sQ", with: ""))!
        repeatingChar = "'"
    } else {
        number = Int(line[line.startIndex..<line.index(before: line.endIndex)])!
        repeatingChar = String(line.last!)
    }

    output += String(repeating: repeatingChar, count: number)

}

// the last one
print(output)
