/// https://www.codingame.com/ide/puzzle/summer-challenge-2024-olymbits

import UIKit

var inital = [
    "0",
    "1"
]

var input = [
    "0 0 0 0",
    "0 0 0 0",
    "0 0 0 0",
    "....#....#...#....#....#...... 3 3 3 0 0 0"
]

var firstWin = [
    "3 1 0 0",
    "1 0 1 0",
    "1 0 1 0",
    "GAME_OVER 29 17 17 0 2 2 0"
]


// MARK: - Setup for Test

@MainActor
func readPrint() -> String {
    guard inital.isEmpty else {
        return inital.removeFirst()
    }
    return input.removeFirst()
}

func debug(_ message: String, doPrint: Bool = true) {
    if doPrint {
        print(message)
    }
}

var loop = false

// START

enum Output: String {
    case LEFT
    case UP
    case RIGHT
    case DOWN
}

struct PlayerScore {
    let playerId: Int
    let toalScore: Int
    let gold: Int
    let silver: Int
    let bronze: Int
    
    init(playerId: Int, scoreLine: String) {
        self.playerId = playerId
        
        let numbers = scoreLine.split(separator: " ").map(String.init)
        self.toalScore = Int(numbers[0])!
        self.gold = Int(numbers[1])!
        self.silver = Int(numbers[2])!
        self.bronze = Int(numbers[3])!
    }
}

struct Hurdles {
    enum Field: String {
        case empty = "."
        case hurdle = "#"
    }
    let track: [Field]
    var playersPositions: [Int] = Array(repeating: 0, count: 3)
    
    init?(register: String) {
        let inputs = register.split(separator: " ").map(String.init)
        let gpu = inputs[0]
        guard gpu != "GAME_OVER" else {
            return nil
        }
        
        track = gpu.map { Field(rawValue: String($0))! }
        
        playersPositions[0] = Int(inputs[1])!
        playersPositions[1] = Int(inputs[2])!
        playersPositions[2] = Int(inputs[3])!
        
        // stun - not needed
//        let reg3 = Int(inputs[4])!
//        let reg4 = Int(inputs[5])!
//        let reg5 = Int(inputs[6])!
        
        // unused
//        let reg6 = Int(inputs[7])!
    }
    
    
    
    func bestMove(forPlayer player: Int) -> Output {
        
        /*
         
         P...#....#...#....#....#...... 0 0 0 0 0 0 -> RIGHT (3)
         ...P#....#...#....#....#...... 3 3 3 0 0 0 -> UP (JUMP)
         */
        
        let pos = playersPositions[player] + 1
        
        if let hurdleIndex = track[pos...].firstIndex(where: { $0 == .hurdle }) {
            if hurdleIndex - pos >= 3 {
                return .RIGHT
            } else if hurdleIndex - pos == 2 {
                return .DOWN
            } else if hurdleIndex - pos == 1 {
                return .LEFT
            } else {
                return .UP
            }
                
        }
        
        return .RIGHT
    }
    
    
}

let myPlayerId = Int(readPrint())!
let numberOfGames = Int(readPrint())!

// game loop
repeat {
    for i in 0...2 {
        let scoreInfo = readPrint()
        /*
        scores.append(
            PlayerScore(playerId: i, scoreLine: scoreInfo)
        )*/
    }
    
    var output: Output = .LEFT
    if numberOfGames > 0 {
        for i in 0..<numberOfGames {
            if let hurdlesGame = Hurdles(register: readPrint()) {
                output = hurdlesGame.bestMove(forPlayer: myPlayerId)
            }
        }
    }
    
    print(output)

} while (loop)
