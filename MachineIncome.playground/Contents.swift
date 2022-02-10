// from clash of codes

import UIKit

/*
 /*
     private void spawnTile() {
         ArrayList<Integer> freeCells = new ArrayList<>();
         for (int x = 0; x < SIZE; x++) {
             for (int y = 0; y < SIZE; y++) {
                 if (grid[x][y] == 0) freeCells.add(x + y * SIZE);
             }
         }

         int spawnIndex = freeCells.get((int) seed % freeCells.size());
         int value = (seed & 0x10) == 0 ? 2 : 4;

         grid[spawnIndex % SIZE][spawnIndex / SIZE] = value;
         if (!noView) boardModule.addSpawn(spawnIndex, value);

         seed = seed * seed % 50515093L;
     }

     */
 */

let seed = 15552512
let index = seed % 13
print(index)

let row = index % 4
print(row)

let col = index/4
print(col)

let value = (seed & 0x10) == 0 ? 2 : 4
print(value)

let newSeed = seed * seed % 50515093
print(newSeed)



//var inputHard = ["43",
//                 "7"]
//
//var expectedHard = ["36299177"]
//
//
//func readLine() -> String? {
//    return inputHard.removeFirst()
//}
//
//func expected() -> String {
//    return expectedHard.removeFirst()
//}
//
//let C = Int(readLine()!)!
//let P = Int(readLine()!)!
//
//var machines = 1
//var gold = 0
//var possibleGold = 100 * P
//print("Init Poss: \(possibleGold)")
//for i in 1...100 {
//    gold += machines*P
//    print("gold \(gold)")
//    if gold >= C {
//        let possMachinesToBuy = Int(exactly: floor(Double(gold)/Double(C)))!
//        let newMachines = machines + possMachinesToBuy
//        let newIncPerMachine = newMachines * P
//        let newIncForRest = newIncPerMachine * (100-i)
//
//        let newPossGold = newIncForRest + (gold-(possMachinesToBuy*C))
//        print("Poss: \(newPossGold)")
//        print("PossBuy: \(possMachinesToBuy)")
//        if newPossGold > possibleGold {
//            possibleGold = newPossGold
//            machines += possMachinesToBuy
//            gold -= possMachinesToBuy*C
//        }
//    }
//
//}
//
//print(gold)
//
//print(expected())
