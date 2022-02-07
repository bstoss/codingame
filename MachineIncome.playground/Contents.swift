// from clash of codes

import UIKit

var inputHard = ["43",
                 "7"]

var expectedHard = ["36299177"]


func readLine() -> String? {
    return inputHard.removeFirst()
}

func expected() -> String {
    return expectedHard.removeFirst()
}

let C = Int(readLine()!)!
let P = Int(readLine()!)!

var machines = 1
var gold = 0
var possibleGold = 100 * P
print("Init Poss: \(possibleGold)")
for i in 1...100 {
    gold += machines*P
    print("gold \(gold)")
    if gold >= C {
        let possMachinesToBuy = Int(exactly: floor(Double(gold)/Double(C)))!
        let newMachines = machines + possMachinesToBuy
        let newIncPerMachine = newMachines * P
        let newIncForRest = newIncPerMachine * (100-i)
        
        let newPossGold = newIncForRest + (gold-(possMachinesToBuy*C))
        print("Poss: \(newPossGold)")
        print("PossBuy: \(possMachinesToBuy)")
        if newPossGold > possibleGold {
            possibleGold = newPossGold
            machines += possMachinesToBuy
            gold -= possMachinesToBuy*C
        }
    }
   
}

print(gold)

print(expected())
