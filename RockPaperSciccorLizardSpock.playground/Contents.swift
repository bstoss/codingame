// https://www.codingame.com/ide/puzzle/rock-paper-scissors-lizard-spock

import UIKit

var inputEasy = ["8",
                 "4 R",
                 "1 P",
                 "8 P",
                 "3 R",
                 "7 C",
                 "5 S",
                 "6 L",
                 "2 L"]

var expectedEasy = ["2",
                    "6 5 1"]

func readLine() -> String? {
    return inputEasy.removeFirst()
}

func expected() -> String {
    return expectedEasy.removeFirst()
}

// code begins here

enum Sign: String {
    case rock = "R"
    case paper = "P"
    case scissors = "C"
    case lizard = "L"
    case spock = "S"
}

struct Player {
    let number: Int
    let sign: Sign
    
    var wonAgainst: [Player] = []
}

var players: [Player] = []

let N = Int(readLine()!)!
if N > 0 {
    for _ in 0...(N-1) {
        let inputs = (readLine()!).split(separator: " ").map(String.init)
        let NUMPLAYER = Int(inputs[0])!
        let SIGNPLAYER = inputs[1]
        players.append(Player(number: NUMPLAYER, sign: Sign(rawValue: SIGNPLAYER)!))
        
    }
}

func match(player1: Player, player2: Player) -> Player {
    
    var winner: Player
    let loser: Player
    
    //print("match: \(player1.number) \(player1.sign) vs \(player2.number) \(player2.sign)")
    
    let sign1 = player1.sign
    let sign2 = player2.sign
    
    switch sign1 {
        
    case .rock:
        switch sign2 {
        case .rock:
            winner = player1.number < player2.number ? player1: player2
            loser = player1.number > player2.number ? player1: player2
        case .paper, .spock:
            winner = player2
            loser = player1
        case .scissors, .lizard:
            winner = player1
            loser = player2
        }
    case .paper:
        switch sign2 {
        case .paper:
            winner = player1.number < player2.number ? player1: player2
            loser = player1.number > player2.number ? player1: player2
        case .scissors, .lizard:
            winner = player2
            loser = player1
        case .rock, .spock:
            winner = player1
            loser = player2
        }
    case .scissors:
        switch sign2 {
        case .scissors:
            winner = player1.number < player2.number ? player1: player2
            loser = player1.number > player2.number ? player1: player2
        case .rock, .spock:
            winner = player2
            loser = player1
        case .paper, .lizard:
            winner = player1
            loser = player2
        }
    case .lizard:
        switch sign2 {
        case .lizard:
            winner = player1.number < player2.number ? player1: player2
            loser = player1.number > player2.number ? player1: player2
        case .rock, .scissors:
            winner = player2
            loser = player1
        case .spock, .paper:
            winner = player1
            loser = player2
        }
    case .spock:
        switch sign2 {
        case .spock:
            winner = player1.number < player2.number ? player1: player2
            loser = player1.number > player2.number ? player1: player2
        case .paper, .lizard:
            winner = player2
            loser = player1
        case .scissors, .rock:
            winner = player1
            loser = player2
        }
    }
    
   // print("winner: \(winner.number) \(winner.sign)")
    winner.wonAgainst.append(loser)
    return winner
}

func playRound(_ players: [Player]) -> [Player] {
    
    var i = 0
    var j = 1
    var wonPlayers: [Player] = []
    while (j < players.count) {
        let player1 = players[i]
        let player2 = players[j]
        
        wonPlayers.append(match(player1: player1, player2: player2))
        i += 2
        j += 2
    }
    
    return wonPlayers
}

while players.count != 1 {
    players = playRound(players)
}

// Write an answer using print("message...")
// To debug: print("Debug messages...", to: &errStream)
print(players.first!.number)
print(players.first!.wonAgainst.map({ String($0.number) }).joined(separator: " "))


print(expected())
print(expected())
