// https://www.codingame.com/ide/puzzle/telephone-numbers

import Foundation

func debug(_ message: Any) {
    print(message)
}

var input = [
    "2",
    "0123456789",
    "1123456789"
]

var output = [
    "20"
]

@MainActor
func readLine() -> String? {
    input.removeFirst()
}

// START

let N = Int(readLine()!)!
var nodes: Set<String> = []

if N > 0 {
    var elements: Int = 0
    for i in 0...(N-1) {
        let telephone = readLine()!
        
        
        for i in 1...telephone.count {
            let pref = telephone.prefix(i)
            nodes.insert(String(pref))
        }
        
    }
}

print(nodes.count)
