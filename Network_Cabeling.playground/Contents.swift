// https://www.codingame.com/ide/puzzle/network-cabling

import Foundation

func debug(_ message: Any) {
    print(message)
}

var input = [
    "4",
    "1 2",
    "0 0",
    "2 2",
    "1 3"
]

var output = [
    "5"
]

@MainActor
func readLine() -> String? {
    input.removeFirst()
}

// START

typealias Coord = (x: Int, y: Int)

let N = Int(readLine()!)!
var buildingCoords: [Coord] = (0..<N).map { _ in
    let inputs = readLine()!.split{$0 == " "}.map(String.init)
    let X = Int(inputs[0])!
    let Y = Int(inputs[1])!
    return Coord(x: X, y: Y)
}
debug(buildingCoords)

buildingCoords.sort { (lCoord, rCoord) -> Bool in
    return lCoord.x < rCoord.x
}
debug(buildingCoords)


var length = 0

for i in 0..<(N-1) {
    let lCoord = buildingCoords[i]
    let rCoord = buildingCoords[i+1]
    
    length += abs(lCoord.x - rCoord.x)
    length += abs(lCoord.y - rCoord.y)
}

// Write an action using print("message...")
// To debug: print("Debug messages...", to: &errStream)

print(length)
