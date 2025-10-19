/// https://www.codingame.com/ide/puzzle/nonogram-inversor

import UIKit

var inputTutorial = [
    "4 4",
    "1 1",
    "2",
    "3",
    "4",
    "4",
    "3",
    "2",
    "1 1"
]

var inputDog = [
    "5 5",
    "1",
    "3",
    "2",
    "5",
    "1",
    "1",
    "1 3",
    "3",
    "1 1",
    "1 1"

]

var inputMusic = [
    "10 10",
    "2",
    "4",
    "4",
    "8",
    "1 1",
    "1 1",
    "1 1 2",
    "1 1 4",
    "1 1 4",
    "8",
    "4",
    "3 1",
    "1 3",
    "4 1",
    "1 1",
    "1 3",
    "3 4",
    "4 4",
    "4 2",
    "2"
]

var inputAfrica = [
    "15 15",
    "3",
    "4",
    "1 4 3",
    "1 4",
    "7 5",
    "2 4",
    "4 4",
    "2 6",
    "4",
    "1 4 3",
    "1 4",
    "7 2",
    "2 4 1",
    "4 3 1",
    "2 7",
    "1 1 1 1",
    "1 3 1 3",
    "5 5",
    "1 2 1 2",
    "1 1",
    "2 2",
    "2 2",
    "2 2",
    "2 2 1",
    "3 4 3",
    "3 6 4",
    "2 5 4",
    "2 6 1 1",
    "1 2 1 1 1",
    "1 1 1 1 3"
]

var inputCat = [
    "15 20",
    "2 6 3",
    "4 6 1",
    "7 1",
    "6 9 1",
    "6 12",
    "2 12 2",
    "14 1 1",
    "4 7 2 2",
    "3 8 3",
    "7 6 4",
    "3 2 4 1 2",
    "2 3 3 1 1",
    "1 2 3 2 2 2",
    "1 8 1 1 3",
    "1 2 2 2 2",
    "1 1 1 1",
    "2 2 1 1",
    "7 2 1",
    "8 3",
    "2 2 2 1",
    "1 8 1",
    "2 3 2 3",
    "1 4 4",
    "1 10",
    "2 9 1",
    "1 8 1",
    "1 9",
    "11 3",
    "8 4 1",
    "7 2 1",
    "7 2 1",
    "5 4 3",
    "2 2 1 2 1 1",
    "1 1 2 4 2",
    "2 5 4"
]

var inputDolphin = [
    "20 20",
    "1 1",
    "1 2 1",
    "3 2",
    "1 1 1 6",
    "3 4",
    "3 2",
    "3 1 2 2",
    "1 2 1 2 3",
    "2 3 3 4",
    "4 2 9",
    "7 9",
    "4 2 9",
    "3 1 9",
    "3 2 8",
    "4 5 3",
    "10 1",
    "10",
    "10",
    "9",
    "3",
    "1 6",
    "1 8",
    "1 10",
    "3 3",
    "3 1 1 1 3",
    "15",
    "8 5",
    "7",
    "1 9",
    "12",
    "6 4",
    "8 3",
    "2 7 3",
    "2 1 6 3",
    "4 6 2",
    "3 6",
    "9",
    "7",
    "3",
    "4"
]

var expectedTutorialOutput = [
    "2",
    "2",
    "1",
    "0",
    "0",
    "1",
    "2",
    "2"
]

var expectedOutputDog = [
    "1 3",
    "2",
    "1 2",
    "0",
    "1 3",
    "3 1",
    "1",
    "1 1",
    "1 1 1",
    "1 1 1"
]

var expectedOutputMusic = [
    "7 1",
    "6",
    "6",
    "1 1",
    "1 1 6",
    "1 1 6",
    "2 2 2",
    "1 2 1",
    "1 2 1",
    "2",
    "6",
    "3 3",
    "3 3",
    "3 2",
    "3 5",
    "3 3",
    "1 2",
    "2",
    "3 1",
    "1 7"
]

var expectedOutputAfrica = [
    "9 3",
    "9 2",
    "1 5 1",
    "2 2 6",
    "3",
    "1 7 1",
    "5 2",
    "2 5",
    "9 2",
    "1 5 1",
    "2 2 6",
    "3 3",
    "1 6 1",
    "5 2",
    "2 4",
    "4 1 4 1 1",
    "2 1 2 1 1",
    "3 2",
    "4 1 3 1",
    "4 6 3",
    "3 5 3",
    "3 5 3",
    "2 5 4",
    "2 5 3",
    "3 2",
    "1 1",
    "2 2",
    "1 1 2 1",
    "2 1 1 1 4",
    "2 1 2 1 2"
]

var expectedOutputCat = [
    "5 2 2",
    "6 2 1",
    "10 1 1",
    "3 1",
    "1 1",
    "2 1 1",
    "2 1 1",
    "2 1 1 1",
    "1 1 3 1",
    "1 2",
    "3 2 1 1 1",
    "1 4 3 1 1",
    "1 2 3 1 1",
    "1 1 1 1 1 1",
    "1 2 4 1 3",
    "3 5 2 1",
    "3 3 1 1 1",
    "3 1 1",
    "3 1",
    "3 1 1 2 1",
    "2 2 1",
    "2 1 2",
    "1 3 2",
    "1 2 1",
    "1 1 1",
    "1 3 1",
    "1 4",
    "1",
    "1 1",
    "3 1 1",
    "1 3 1",
    "1 1 1",
    "1 1 1 1 1 1",
    "1 1 1 1 1",
    "1 1 2"
]

var expectedOutputDolphin = [
    "14 4",
    "1 11 4",
    "13 2",
    "1 2 8",
    "4 8 1",
    "4 9 2",
    "4 1 3 2 2",
    "2 2 2 1 2 2",
    "1 1 2 2 2",
    "1 2 2",
    "1 3",
    "1 1 3",
    "2 1 4",
    "1 1 5",
    "1 1 6",
    "1 1 7",
    "2 8",
    "4 6",
    "6 5",
    "12 5",
    "3 5 5",
    "1 6 4",
    "3 3 3",
    "9 2 3",
    "4 1 1 2 1 2",
    "3 2",
    "4 2 1",
    "12 1",
    "6 3 1",
    "7 1",
    "8 1 1",
    "7 1 1",
    "6 1 1",
    "1 3 2 2",
    "4 4",
    "2 2 7",
    "3 8",
    "3 10",
    "2 15",
    "16"
]

// MARK: - Setup for Test

//var input = inputTutorial
//var exepcted = expectedTutorialOutput

var input = inputDog
var exepcted = expectedOutputDog

//var input = inputMusic
//var exepcted = expectedOutputMusic

//var input = inputAfrica
//var exepcted = expectedOutputAfrica
////
//var input = inputCat
//var exepcted = expectedOutputCat
////
//var input = inputDolphin
//var exepcted = expectedOutputDolphin

@MainActor
func readLine() -> String? {
    input.removeFirst()
}

/*
 
 Looks like:
 ──────────
     1
     1 2 3 4
    ┌─┬─┬─┬─┐
   4│■│■│■│■│
    ├─┼─┼─┼─┤
   3│ │■│■│■│
    ├─┼─┼─┼─┤
   2│ │ │■│■│
    ├─┼─┼─┼─┤
 1 1│■│ │ │■│
    └─┴─┴─┴─┘

 Inversor:
 ────────
     2 2 1 0
    ┌─┬─┬─┬─┐
   0│ │ │ │ │
    ├─┼─┼─┼─┤
   1│■│ │ │ │
    ├─┼─┼─┼─┤
   2│■│■│ │ │
    ├─┼─┼─┼─┤
   2│ │■│■│ │
    └─┴─┴─┴─┘

    |   |   |   |   |   |   | 1 | 1 | 1 |   |
    |   |   |   |   | 1 | 1 | 1 | 1 | 1 |   |
    | 2 | 4 | 4 | 8 | 1 | 1 | 2 | 4 | 4 | 8 |
  4 | · | · | · | · | · | · | ■ | ■ | ■ | ■ |
3 1 | · | · | · | ■ | ■ | ■ | · | · | · | ■ |
1 3 | · | · | · | ■ | · | · | · | ■ | ■ | ■ |
4 1 | · | · | · | ■ | ■ | ■ | ■ | · | · | ■ |
1 1 | · | · | · | ■ | · | · | · | · | · | ■ |
1 3 | · | · | · | ■ | · | · | · | ■ | ■ | ■ |
3 4 | · | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ |
4 4 | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ |
4 2 | ■ | ■ | ■ | ■ | · | · | · | ■ | ■ | · |
  2 | · | ■ | ■ | · | · | · | · | · | · | · |
 
 
 */
        
            /*
             |   |   | 1 |   |   |   |   |   |   | 1 |   |   | 2 | 4 |   |
             |   |   | 4 | 1 | 7 | 2 | 4 | 2 |   | 4 | 1 | 7 | 4 | 3 | 2 |
             | 3 | 4 | 3 | 4 | 5 | 4 | 4 | 6 | 4 | 3 | 4 | 2 | 1 | 1 | 7 |
     1 1 1 1 | · | · | · | · | ■ | · | ■ | · | · | · | · | ■ | · | ■ | · |
     1 3 1 3 | · | · | ■ | · | ■ | ■ | ■ | · | · | ■ | · | ■ | ■ | ■ | · |
         5 5 | · | · | · | ■ | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ | ■ |
     1 2 1 2 | · | · | · | · | ■ | · | ■ | ■ | · | · | · | ■ | · | ■ | ■ |
         1 1 | · | · | · | · | ■ | · | · | · | · | · | · | ■ | · | · | · |
         2 2 | · | · | · | ■ | ■ | · | · | · | · | · | ■ | ■ | · | · | · |
         2 2 | · | · | · | ■ | ■ | · | · | · | · | · | ■ | ■ | · | · | · |
         2 2 | · | · | ■ | ■ | · | · | · | · | · | ■ | ■ | · | · | · | · |
       2 2 1 | · | · | ■ | ■ | · | · | · | · | · | ■ | ■ | · | · | · | ■ |
       3 4 3 | ■ | ■ | ■ | · | · | · | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ |
       3 6 4 | ■ | ■ | ■ | · | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ | ■ |
       2 5 4 | ■ | ■ | · | · | ■ | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ |
     2 6 1 1 | · | ■ | ■ | · | ■ | ■ | ■ | ■ | ■ | ■ | · | · | ■ | · | ■ |
   1 2 1 1 1 | · | · | ■ | · | ■ | ■ | · | ■ | · | ■ | · | · | · | · | ■ |
   1 1 1 1 3 | · | · | ■ | · | ■ | · | · | ■ | · | ■ | · | · | ■ | ■ | ■ |
             
             
             
             |   |   |   |   |   |   |   | 4 |   |   | 2 | 3 | 3 | 8 | 2 |
             | 2 | 4 |   | 6 |   | 2 | 14| 7 | 3 | 7 | 4 | 3 | 2 | 1 | 2 |
             | 6 | 6 | 7 | 9 | 6 | 12| 1 | 2 | 8 | 6 | 1 | 1 | 2 | 1 | 2 |
             | 3 | 1 | 1 | 1 | 12| 2 | 1 | 2 | 3 | 4 | 2 | 1 | 2 | 3 | 2 |
     1 1 1 1 | · | · | · |   |   | · | · | · | · | ■ | · |   |   |   |   |
     2 2 1 1 | · | · | · | ■ | ■ | · | · | · | ■ | ■ | · |   |   |   |   |
       7 2 1 | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |   |   |   |   |
         8 3 | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ |
     2 2 2 1 | · | · | · | ■ | ■ | · | ■ | ■ | · | ■ | ■ | · | · | ■ | · |
       1 8 1 |   |   |   | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |   |   | ■ |   |
     2 3 2 3 |   |   |   |   |   | ■ | ■ | · | ■ | ■ | · |   | ■ | ■ |   |
       1 4 4 |   |   |   |   |   | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ |
         1 10|   |   |   |   | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |   |
       2 9 1 | ■ | ■ | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | · |
       1 8 1 |   |   |   | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |   |   |   |   |
         1 9 |   |   |   | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |   |   |   |   |
         113 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ |
       8 4 1 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ | ■ | · | ■ |
       7 2 1 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | ■ | ■ |   |   |   |
       7 2 1 | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |   | · | · |   |   |   |
       5 4 3 | · | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ |
 2 2 1 2 1 1 |   | ■ |   |   | ■ | · | ■ | · | ■ | ■ | · |   | · | ■ |   |
   1 1 2 4 2 |   |   |   |   | ■ | ■ | · | ■ | ■ | ■ | ■ | · | ■ | ■ |   |
       2 5 4 |   |   |   |   |   | ■ | ■ | ■ | · |   | ■ | ■ | ■ |   |   |
             
             |   |   |   |   |   |   |   |   |   |   |   |   | 1 |   |   |
             |   |   |   |   |   |   |   |   |   |   | 3 | 2 | 2 | 1 | 1 |
             |   |   |   |   |   |   |   | 4 |   |   | 2 | 3 | 3 | 8 | 2 |
             | 2 | 4 |   | 6 |   | 2 | 14| 7 | 3 | 7 | 4 | 3 | 2 | 1 | 2 |
             | 6 | 6 | 7 | 9 | 6 | 12| 1 | 2 | 8 | 6 | 1 | 1 | 2 | 1 | 2 |
             | 3 | 1 | 1 | 1 | 12| 2 | 1 | 2 | 3 | 4 | 2 | 1 | 2 | 3 | 2 |
     1 1 1 1 | . | . | . | ■ | . | . | . | . | . | ■ | . | . | ■ | . | ■ |
     2 2 1 1 | . | . | . | ■ | ■ | . | . | . | ■ | ■ | . | ■ | . | ■ | . |
       7 2 1 | . | . | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | . | ■ |
         8 3 | . | . | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ |
     2 2 2 1 | . | . | . | ■ | ■ | . | ■ | ■ | . | ■ | ■ | . | . | ■ | . |
       1 8 1 | ■ | . | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | . | ■ | . |
     2 3 2 3 | ■ | ■ | . | . | ■ | ■ | ■ | . | ■ | ■ | . | . | ■ | ■ | ■ |
       1 4 4 | . | ■ | . | . | . | ■ | ■ | ■ | ■ | . | . | ■ | ■ | ■ | ■ |
         1 10| . | ■ | . | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . |
       2 9 1 | ■ | ■ | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | ■ | . |
       1 8 1 | ■ | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | . | . | ■ | . |
         1 9 | ■ | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | . | . | . |
         113 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ |
       8 4 1 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ | ■ | . | ■ |
       7 2 1 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | . | . | ■ | ■ | . | ■ | . |
       7 2 1 | . | ■ | ■ | ■ | ■ | ■ | ■ | ■ | . | . | . | ■ | ■ | . | ■ |
       5 4 3 | . | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ |
 2 2 1 2 1 1 | ■ | ■ | . | ■ | ■ | . | ■ | . | ■ | ■ | . | ■ | . | ■ | . |
   1 1 2 4 2 | ■ | . | ■ | . | ■ | ■ | . | ■ | ■ | ■ | ■ | . | ■ | ■ | . |
       2 5 4 | ■ | ■ | . | ■ | ■ | ■ | ■ | ■ | . | ■ | ■ | ■ | ■ | . | . |
             
             |   |   |   |   |   |   |   | 1 |   |   |   |   |   |   |   |   |   |   |   |   |
             |   |   |   | 1 |   |   | 3 | 2 | 2 |   |   |   |   |   |   |   |   |   |   |   |
             |   | 1 |   | 1 |   |   | 1 | 1 | 3 | 4 |   | 4 | 3 | 3 | 4 |   |   |   |   |   |
             | 1 | 2 | 3 | 1 | 3 | 3 | 2 | 2 | 3 | 2 | 7 | 2 | 1 | 2 |^5 | 10|   |   |   |   |
             | 1 | 1 | 2 | 6 | 4 | 2 | 2 | 3 | 4 | 9 | 9 | 9 |^9 | 8 | 3 | 1 | 10| 10| 9 | 3 |
             | · | · | · | ■ | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · | · |
             | · | ■ | · | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · |
             | · | · | · | ■ | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · |
             | · | · | · | · | · | · | · | · | · | ■ | ■ | ■ | · | · | ■ | ■ | ■ | · | · | · |
             | · | · | · | · | ■ | ■ | ■ | · | ■ | · | ■ | · | · | ■ | · | ■ | ■ | ■ | · | · |
             | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · |
             | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | · | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | ■ | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ | · |
             | · | · | · | · | · | · | ■ | ■ | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | ■ | ■ | ■ |
             | · | ■ | ■ | · | · | · | ■ | · | · | ■ | ■ | ■ | ■ | ■ | ■ | · | · | ■ | ■ | ■ |
             | ■ | ■ | ■ | ■ | · | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · | ■ | ■ |
             | · | · | ■ | ■ | ■ | · | · | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · | · | · | · |
             | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · | · | · | · | · |
             | · | · | · | ■ | ■ | ■ | ■ | ■ | ■ | ■ | · | · | · | · | · | · | · | · | · | · |
             | · | · | ■ | ■ | ■ | · | · | · | · | · | · | · | · | · | · | · | · | · | · | · |
             | ■ | ■ | ■ | ■ | · | · | · | · | · | · | · | · | · | · | · | · | · | · | · | · |
             
             
            */

func debug(_ message: String, doPrint: Bool = false) {
    if doPrint {
        print(message)
    }
}


/// START

let inputs = (readLine()!).split(separator: " ").map(String.init)
let width = Int(inputs[0])!
let height = Int(inputs[1])!

// row and column
// multiple numbers
// numbers that are fullfilled
// fields set

typealias Pos = (x: Int, y: Int)

class Number {
    let value: Int
    var fullfilled: Bool = false
    var fullfills: [Int] = []
    
    init(value: Int) {
        self.value = value
    }
}

class Config {
    let pos: Pos
    let numbers: [Number]
    var fullfilled: Bool {
        !numbers.contains(where: { !$0.fullfilled })
    }
    
    lazy var numbersSizeWithGaps: Int = {
        var num = numbers.count-1
        numbers.forEach { num += $0.value }
        return num
    }()
    
    lazy var numbersSize: Int = {
        var num = 0
        numbers.forEach { num += $0.value }
        return num
    }()
    
    init(pos: Pos, numbers: [Int]) {
        self.pos = pos
        self.numbers = numbers.map { Number(value: $0) }
    }

    var description: String {
        "\(pos) - \(numbers.map{ "\($0.value)\($0.fullfilled ? "^":"")" }.joined(separator: " "))"
    }
    
    
}

enum BoxState {
    case filled, empty, unknown
}

class Box {
    let pos: Pos
    var state: BoxState = .unknown
    
    init(pos: Pos) {
        self.pos = pos
    }
    
    var printedState: String {
        switch state {
        case .filled:
            return "■"
        case .empty:
            return "·"
        case .unknown:
            return " "
        }
    }
}


class Grid {
    let width: Int
    let height: Int
    
    var configs: [Config] = []
    var boxes: [Box] = []
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        for i in 1...width {
            for j in 1...height {
                boxes.append(Box(pos: (x: i, y: j)))
            }
        }

    }
    
    func addConfig(at pos: Pos, numbers: String) {
        let nums = numbers.split(separator: " ")
        configs.append(Config(pos: pos, numbers: nums.map { Int($0)! }))
    }
    
    // MARK: - Grid Methods
    
    func printBoard() {
        let confYAllNumbers = configs.filter { $0.pos.y == 0 }
        var topLine: String = ""
        
        var sortedForYMax = confYAllNumbers.sorted { $0.numbers.count > $1.numbers.count }
        var maxYCount = sortedForYMax.first!.numbers.count
        
        let confXAllNumbers = configs.filter { $0.pos.x == 0 }
        let sortedForXMax = confXAllNumbers.sorted { $0.numbers.count > $1.numbers.count }
        var maxXCount = sortedForXMax.first!.numbers.count
        
        for k in 0..<maxYCount {
            topLine += (0..<maxXCount).map({ _ in "  " }).joined(separator: " ") + " |"
            for config in confYAllNumbers {
                
                let count = config.numbers.count
                if count < maxYCount - k {
                    topLine += "   |"
                } else {
                    let number = config.numbers[count-(maxYCount-k)]
                    let value = number.value
                    
                    topLine += "\(number.fullfilled ? "^":" ")\(value)\(value > 9 ? "":" ")|"
                }
            }
            debug(topLine, doPrint: true)
            topLine = ""
        }
        
        for i in 1...height {
            
            var row = ""
            for j in 0...width {
                
                if j == 0 {
                    let config = configs.first(where: { $0.pos == (x: j, y: i) })!
                    for k in 0..<maxXCount {
                        let count = config.numbers.count
                        if count < maxXCount - k {
                            row += "   "
                        } else {
                            let number = config.numbers[count-(maxXCount-k)]
                            row += "\(number.fullfilled ? "^":" ")\(number.value)\(number.value > 9 ? "" : " ")"
                        }
                    }
                    row += "|"
                } else {
                    row += " \(boxes.first(where: { $0.pos == (x: j, y: i) })!.printedState) |"
                }
            }
            
            debug(row, doPrint: true)
            
        }
    }
    
    func printWhites() -> [String] {
        
        var output = [String]()
        
        for config in configs {
//            debug("Conf: \(config.description)")
            if config.pos.y == 0 {
                
                var tempOutput = ""
                var currentValue = 0
                for box in boxes.filter({ $0.pos.x == config.pos.x }) {
//                    debug("\(box.pos), \(box.state)")
                    if box.state == .empty {
                        currentValue += 1
                    }
                    
                    if box.state == .filled && currentValue > 0 {
                        if !tempOutput.isEmpty {
                            tempOutput += " "
                        }
                        tempOutput += "\(currentValue)"
                        currentValue = 0
                    }
                    
                }
                if currentValue > 0 {
                    if !tempOutput.isEmpty {
                        tempOutput += " "
                    }
                    tempOutput += "\(currentValue)"
                }
                
//                debug(tempOutput)
                output.append(tempOutput.isEmpty ? "0" : tempOutput)
                continue
            }
            
            if config.pos.x == 0 {
                
                var tempOutput = ""
                var currentValue = 0
                for box in boxes.filter({ $0.pos.y == config.pos.y }) {
//                    debug("\(box.pos), \(box.state)")
                    if box.state == .empty {
                        currentValue += 1
                    }
                    
                    if box.state == .filled && currentValue > 0 {
                        if !tempOutput.isEmpty {
                            tempOutput += " "
                        }
                        tempOutput += "\(currentValue)"
                        currentValue = 0
                    }
                }
                
                if currentValue > 0 {
                    if !tempOutput.isEmpty {
                        tempOutput += " "
                    }
                    tempOutput += "\(currentValue)"
                }
                
//                debug(tempOutput)
                output.append(tempOutput.isEmpty ? "0" : tempOutput)
                continue
                
            }
            
            output.append("x")
            
        }
        
        return output
    }
    
    // MARK: - Rules
    
    // config number covers full size
    private func ruleFillAll(config: Config, size: Int, boxes: [Box]) -> Bool {
        
        debug("ruleFillAll")
        guard var number = config.numbers.first(where: { $0.value == size }) else {
            debug("ruleFillAll - no match")
            return false
        }
        
        debug("ruleFillAll - match -> fill all")
        for box in boxes {
            box.state = .filled
        }
        
        number.fullfilled = true
        return true
    }
    
    private func ruleMultipleNumbersFillAll(config: Config, size: Int, boxes: [Box]) -> Bool {
        
        debug("ruleMultipleNumbersFillAll")
        guard config.numbersSizeWithGaps == size else {
            debug("ruleMultipleNumbersFillAll - no match")
            return false
        }
        
        debug("ruleMultipleNumbersFillAll - match -> fill all")
       
        var boxIndex = 0
        
        for number in config.numbers {
            for j in 0..<number.value {
                boxes[boxIndex].state = .filled
                boxIndex += 1
            }
            if boxIndex < boxes.count {
                boxes[boxIndex].state = .empty
                boxIndex += 1
            }
            number.fullfilled = true
        }
            
        return true
    }
    
    // one number, fill possible space, maybe function for bigger ones
    private func ruleOneNumber(config: Config, size: Int, boxes: [Box]) -> Bool {
        
        debug("ruleOneNumber")
        guard var number = config.numbers.first, config.numbers.count == 1 else {
            debug("ruleOneNumber - no match")
            return false
        }
        
        debug("ruleOneNumber - match -> next rules")
        var changed = false
        var from = 1
        var to = size
        
        // TODO: check for possible space.
        // check if already contains a filled one
        // Only fill middle in possible space
        // mark impossible space as empty
        
        debug("ruleOneNumber - handle already filled")
        var filledBoxes = boxes.filter { $0.state == .filled }
        var fbCount = filledBoxes.count
        if fbCount > 0 && fbCount < number.value {
            debug("ruleOneNumber - found already filled. align on them")
            // check what can be set as empty
            
            var firstIndex = boxes.firstIndex(where: { $0.state == .filled })!
            var lastIndex = boxes.lastIndex(where: { $0.state == .filled })!
            
            debug("\(firstIndex)")
            debug("\(lastIndex)")
            
            let safeRange = (number.value-fbCount)
            debug("\(safeRange)")
            let first = (firstIndex-safeRange)
            let last = (lastIndex+safeRange)
            
            debug("\(first)")
            debug("\(last)")
            
            var boxesToChange: [Box] = []
            
            if first > 0 {
                boxesToChange += boxes[..<first]
            }
            
            if last < (boxes.count-1) {
                boxesToChange += boxes[(last+1)...]
            }
            
            
            for box in boxesToChange.filter({ $0.state == .unknown }) {
                debug("ruleOneNumber - set box empty \(box.pos)")
                box.state = .empty
                changed = true
            }
            
            if changed {
                return true
            }
            
        } else {
            debug("ruleOneNumber - no filled boxes")
        }
        
        debug("ruleOneNumber - set empty where not fit")
        if boxes.contains(where: { $0.state == .empty }) {
            for index in boxes.indices {
                guard boxes[index].state == .unknown else { continue }
                
                let minIndex = max(0, index-(number.value-1))
                let maxIndex = min(size-1, index+(number.value-1))
                debug("ruleOneNumber - index: \(index) minIndex: \(minIndex) maxIndex: \(maxIndex)")
                var filtered = boxes[minIndex...maxIndex].filter({ $0.state == .unknown || $0.state == .filled })
                
                filtered.forEach { box in
                    debug("box pos: \(box.pos) state: \(box.state)")
                }
                
                if filtered.count < number.value {
                    debug("ruleOneNumber - change box \(boxes[index].pos)")
                    boxes[index].state = .empty
                    changed = true
                }
            }
        } else {
            debug("ruleOneNumber - no empty fields")
        }
        
        if changed {
            return true
        }
        
        debug("ruleOneNumber - set middle range")
        var firstEmptyIndex = boxes.firstIndex(where: { $0.state == .unknown })!
        var lastEmptyIndex = boxes.lastIndex(where: { $0.state == .unknown })!
            
        debug("ruleOneNumber firstEmptyIndex: \(firstEmptyIndex)")
        debug("ruleOneNumber lastEmptyIndex: \(lastEmptyIndex)")
        
        from = max(firstEmptyIndex+1, 1)
        to = min(lastEmptyIndex+1, size)
        
        debug("ruleOneNumber - from: \(from)")
        debug("ruleOneNumber - to: \(to)")
                
        debug("one number. fill middle")

        changed = ruleFillMiddles(
            number: number,
            from: from,
            to: to,
            boxes: boxes
        )
        
        
        return changed

    }
    
    private func ruleFillMiddles(number: Number, from: Int, to: Int, boxes: [Box], doPrint: Bool = false) -> Bool {
        
        debug("ruleFillMiddles from: \(from) to: \(to)", doPrint: doPrint)
        
        var changed = false
        
        var outers = to - (from-1) - number.value
        debug("ruleFillMiddles outer: \(outers)", doPrint: doPrint)
        
        var lower = from + outers
        var upper = to - outers
        
        guard lower <= upper else {
            debug("ruleFillMiddles - no match", doPrint: doPrint)
            return false
        }
        
        debug("ruleFillMiddles - match -> fillMiddles lower \(lower) to \(upper)", doPrint: doPrint)
        for j in lower...upper {
            // use j - 1
            if j > 0 && (j-1) < boxes.count {
                var box = boxes[j-1]
                debug("box state : \(box.state)", doPrint: doPrint)
                if box.state == .unknown {
                    debug("box \(box.pos)", doPrint: doPrint)
                    box.state = .filled
                    changed = true
                }
                
            }
        }
        
        if outers == 0 {
            number.fullfilled = true
            number.fullfills = ((lower-1)..<upper).map { Int($0) }
        }
                
        return changed
    }
    
    private func ruleMultipleNumbers(config: Config, size: Int, boxes: [Box]) -> Bool {
        var changed = false
        
        var print = false // config.pos == (x: 7, y: 0) // check for hier war ich
        
        if print {
            printBoard()
        }
        
        debug("ruleMultipleNumbers - config \(config.description)", doPrint: print)
        
        let countOfNumbers = config.numbers.count
        
        guard countOfNumbers > 1 else {
            debug("ruleMultipleNumbers - no multiple numbers", doPrint: print)
            return false
        }
            
        debug("ruleMultipleNumbers - numbers - \(countOfNumbers)", doPrint: print)

        // MARK: -- middles for all numbers
        let didChange = ruleFillMiddles(
            forMultipleNumbers: config.numbers,
            initialFrom: 0,
            initialTo: size-1,
            boxes: boxes,
            doPrint: print
        )
        if didChange {
            changed = true
        }
        
//
//        for ii in 0..<countOfNumbers {
//            // search for middles?
//            var number = config.numbers[ii]
//            
//            guard !number.fullfilled else {
//                continue
//            }
//            
//            debug("ruleMultipleNumbers - check middle for index: \(ii) - value: \(number.value)", doPrint: print)
//            
//            var from = 1
//            if ii > 0 {
//                // add unfree space from numbers befor index
//                for j in 0..<ii {
//                    from += 1
//                    from += config.numbers[j].value
//                }
//            }
//            
//            var to = size
//            if ii+1 < countOfNumbers {
//                // add unfree space from numbers after index
//                for j in ii+1..<countOfNumbers {
//                    to -= 1
//                    to -= config.numbers[j].value
//                }
//            }
//            
//            debug("ruleMultipleNumbers - from: \(from), to: \(to)", doPrint: print)
//            
//            let didChange = ruleFillMiddles(
//                number: number,
//                from: from,
//                to: to,
//                boxes: boxes
//            )
//            
//            if didChange {
//                changed = true
//            }
//        }
        
        // MARK: -- checks when emptys there
        debug("ruleMultipleNumbers - fill middles when empty found", doPrint: print)
        if boxes.contains(where: { $0.state == .empty }) {
            
            // check first number
            let firstIndex = boxes.firstIndex(where: { $0.state == .empty })!
            let firstNumber = config.numbers.first!
            
            let lastIndex = boxes.lastIndex(where: { $0.state == .empty })!
            let lastNumber = config.numbers.last!
            
            // MARK: --- | unknown ... empty does not fit first number
            /*
             2 1 |   | · |   |   |   |   |   |   |   |
             -
             2 1 | · | · |   |   |   |   |   |   |   |
             */
            debug("ruleMultipleNumbers - check first fits with first number", doPrint: print)
            if firstIndex+1 <= firstNumber.value {
                debug("ruleMultipleNumbers - fill boxes empty till first \(firstIndex+1)", doPrint: print)
                boxes[..<firstIndex].forEach { box in
                    if box.state == .unknown {
                        box.state = .empty
                        changed = true
                    }
                    
                }
            } else {
                debug("ruleMultipleNumbers - check first nothing to fill", doPrint: print)
            }
            
            // MARK: ---  empty ... unknown | does not fit last number
            /*
             1 2 |   |   |   |   |   |   |   | · |   |
             -
             1 2 |   |   |   |   |   |   |   | · | · |
             */
            debug("ruleMultipleNumbers - check last fits with last number", doPrint: print)
            if size-(lastIndex+1) < lastNumber.value {
                debug("ruleMultipleNumbers - fill boxes empty \(lastIndex+1) till end", doPrint: print)
                boxes[lastIndex...].forEach { box in
                    if box.state == .unknown {
                        debug("box: \(box.pos)", doPrint: print)
                        box.state = .empty
                        changed = true
                    }
                }
            } else {
                debug("ruleMultipleNumbers - check last nothing to fill", doPrint: print)
            }
                
            // MARK: --- | unknown ... firstEmpty can only fit from first number
            /*
             5 2 |   |   |   |   |   |   | · |   |   |
             -
             5 2 |   | ■ | ■ | ■ | ■ |   | · |   |   |
             */
            debug("ruleMultipleNumbers - firstEmpty can only fit first number", doPrint: print)
            if size - (firstIndex+1) < firstNumber.value {
                debug("ruleMultipleNumbers - fill middles when empty found - match", doPrint: print)
                debug("FirstIndexPos: \(firstIndex+1), number: \(firstNumber.value)", doPrint: print)
                let didChange = ruleFillMiddles(
                    number: firstNumber,
                    from: 1,
                    to: firstIndex + 1,
                    boxes: boxes
                )
                
                if didChange {
                    changed = true
                }
                
            }
            
            // MARK: --- lastEmpty ... unknown | can only fit from last number
            /*
             2 5 |   |   | · |   |   |   |   |   |   |
             -
             2 5 |   |   | · |   | ■ | ■ | ■ | ■ |   |
             */
            if lastIndex+1 < lastNumber.value {
                debug("ruleMultipleNumbers - fill middles when empty found - match", doPrint: print)
                debug("LastIndexPos: \(lastIndex+1), number: \(lastNumber.value)", doPrint: print)
                let didChange = ruleFillMiddles(
                    number: lastNumber,
                    from: lastIndex + 1,
                    to: size,
                    boxes: boxes
                )
                
                if didChange {
                    changed = true
                }
                
            }
            
        } else {
            debug("ruleMultipleNumbers - no empty fields", doPrint: print)
        }
        
        debug("ruleMultipleNumbers - check border fields", doPrint: print)
        // MARK: -- checks when filled there
        if boxes.contains(where: { $0.state == .filled }) {
            
            // MARK: --- only number is 1 ... place empty on every filled
            /*
             1 1 |   | ■ | · |   |   |   | ■ |   |   |
             -
             1 1 | · | ■ | · |   |   | · | ■ | · |   |
             */
            debug("ruleMultipleNumbers - check for only 1 and set emptys")
            if !config.numbers.contains(where: { $0.value != 1 }) {
                debug("ruleMultipleNumbers - only 1 ... check if need to set emptys")
                for i in 0..<boxes.count {
                    if boxes[i].state == .filled {
                        if i > 0 {
                            if boxes[i-1].state == .unknown {
                                boxes[i-1].state = .empty
                                changed = true
                            }
                        }
                        if i < size-1 {
                            if boxes[i+1].state == .unknown {
                                boxes[i+1].state = .empty
                                changed = true
                            }
                        }
                    }
                }
            }
            
            let firstIndex = boxes.firstIndex(where: { $0.state == .filled })!
            let lastIndex = boxes.lastIndex(where: { $0.state == .filled })!
            debug("ruleMultipleNumbers - firstIndexPos: \(firstIndex+1) lastIndexPos: \(lastIndex+1)", doPrint: print)
            
            var firstNumber = config.numbers.first!
            var lastNumber = config.numbers.last!
            debug("ruleMultipleNumbers - firstNumber: \(firstNumber.value) lastNumber: \(lastNumber.value)", doPrint: print)
            
            
            // MARK: --- filled hits first box -> fill rest
            /*
             4 1 | ■ |   |   |   |   |   |   |   |   |
             -
             4 1 | ■ | ■ | ■ | ■ | · |   |   |   |   |
             */
            if firstIndex == 0 && !firstNumber.fullfilled {
                debug("ruleMultipleNumbers - hit first border - fill rest", doPrint: print)
                boxes[0..<firstNumber.value].forEach({ box in
                    debug("box: \(box.pos) filled")
                    box.state = .filled
                })
                
                boxes[firstNumber.value].state = .empty
                debug("box: \(boxes[firstNumber.value].pos) empty", doPrint: print)
                firstNumber.fullfilled = true
                firstNumber.fullfills = (0..<firstNumber.value).map { Int($0) }
                changed = true
            }
            
            // MARK: --- filled hits end of only empties -> fill rest
            /*
             4 1 | · | · | ■ |   |   |   |   |   |   |
             -
             4 1 | · | · | ■ | ■ | ■ | ■ | · |   |   |
             */
            if !boxes[0..<firstIndex].contains(where: { $0.state == .unknown }) && !firstNumber.fullfilled {
                debug("ruleMultipleNumbers - hit first border - fill rest - borde was an empty", doPrint: print)
                boxes[firstIndex..<(firstNumber.value+firstIndex-1)].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                boxes[firstIndex+firstNumber.value].state = .empty
                debug("box: \(boxes[firstIndex+firstNumber.value].pos) empty", doPrint: print)
                firstNumber.fullfilled = true
                firstNumber.fullfills = (firstIndex..<(firstNumber.value+firstIndex-1)).map { Int($0) }
                changed = true
            }
            
            // MARK: --- filled hits last box -> fill rest before
            /*
             1 4 |   |   |   |   |   |   |   |   | ■ |
             -
             1 4 |   |   |   |   | · | ■ | ■ | ■ | ■ |
             */
            if lastIndex == size-1 && !lastNumber.fullfilled {
                // ruleMultipleNumbers - firstIndexPos: 4 lastIndexPos: 10
                debug("ruleMultipleNumbers - hit last border - fill rest", doPrint: print)
                boxes[(size-lastNumber.value)...].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                boxes[size-lastNumber.value-1].state = .empty
                debug("box: \(boxes[size-lastNumber.value-1].pos) empty", doPrint: print)
                lastNumber.fullfilled = true
                lastNumber.fullfills = (size-lastNumber.value...size-1).map { Int($0) }
                changed = true
            }
            
            // MARK: --- filled hits end of only empties -> fill rest before
            /*
             1 4 |   |   |   |   |   |   | ■ | · | · |
             -
             1 4 |   |   | · | ■ | ■ | ■ | ■ | · | · |
             */
            if !boxes[lastIndex...].contains(where: { $0.state == .unknown }) && !lastNumber.fullfilled {
                debug("ruleMultipleNumbers - hit last border - fill rest - borde was an empty", doPrint: print)
                boxes[lastIndex-(lastNumber.value-1)..<lastIndex].forEach({
                    debug("box: \($0.pos) filled", doPrint: print)
                    $0.state = .filled
                })
                boxes[lastIndex-lastNumber.value].state = .empty
                debug("box: \(boxes[lastIndex-lastNumber.value].pos) empty", doPrint: print)
                lastNumber.fullfilled = true
                lastNumber.fullfills = (lastIndex-(lastNumber.value-1)..<lastIndex).map { Int($0) }
                changed = true
            }
            
            
            debug("ruleMultipleNumbers - check first filled if can be raised", doPrint: print)
            
            
            let lastEmptyBoxFromFirstIndexOrNull = boxes[0..<firstIndex].lastIndex(where: { $0.state == .empty })
            let lastEmptyBoxFromFirstIndex = lastEmptyBoxFromFirstIndexOrNull ?? 0
            debug("ruleMultipleNumbers - LastEmptyFromFirstPos: \((lastEmptyBoxFromFirstIndexOrNull ?? -1) + 1)", doPrint: print)
            
            let firstEmptyBoyAfterLastEmptyBox = boxes[(lastEmptyBoxFromFirstIndex+1)...].firstIndex(where: { $0.state == .empty }) ?? size-1
            debug("ruleMultipleNumbers - firstEmptyBoyAfterLastEmptyBox: \(firstEmptyBoyAfterLastEmptyBox+1)", doPrint: print)
            
            // MARK: --- fills Middle from first empty to next if its sure that before is not enough space
            /*
             4 1 |   | · |   | ■ |   |   |   | · |   |
             -
             4 1 |   | · |   | ■ | ■ | ■ |   | · |   |  -> first cannot be happen here, because already check with rule above
             4 1 | · | · |   | ■ | ■ | ■ |   | · |   |
             */
            if boxes[0..<lastEmptyBoxFromFirstIndex].filter({ $0.state == .unknown }).count < firstNumber.value &&
                (lastEmptyBoxFromFirstIndex > 0 || firstEmptyBoyAfterLastEmptyBox < size-1) {
                debug("ruleMultipleNumbers - fill middles for first number in range", doPrint: print)
                let didChange = ruleFillMiddles(
                    number: firstNumber,
                    from: lastEmptyBoxFromFirstIndexOrNull == nil ? 1 : lastEmptyBoxFromFirstIndex+2,
                    to: firstEmptyBoyAfterLastEmptyBox,
                    boxes: boxes,
                    doPrint: print
                )
                
                if didChange {
                    changed = true
                }
                
                
            }
            
            // MARK: --- fills next if not on board but counts
            /*
             4 1 | · | · |   | ■ |   |   |   |   |   |
             -
             4 1 | · | · |   | ■ | ■ | ■ |   |   |   |
             */
            debug("ruleMultipleNumbers - fill rest if diff to border allows from first", doPrint: print)
            let maxIndexToFill = lastEmptyBoxFromFirstIndex + firstNumber.value - 1
            if maxIndexToFill > firstIndex {
                debug("ruleMultipleNumbers - fill rest if diff to border allows - fromPos \(firstIndex+1) toPos \(maxIndexToFill+1)", doPrint: print)
                boxes[firstIndex..<maxIndexToFill].forEach { box in
                    if box.state == .unknown {
                        box.state = .filled
                        changed = true
                        debug("box \(box.pos) filled", doPrint: print)
                    }
                }
            }
            
            // MARK: --- fills Middle from empty before last empty to next if its sure that after is not enough space
            /*
             1 4 |   | · |   |   |   | ■ |   | · |   |
             -
             1 4 |   | · |   | ■ | ■ | ■ |   | · |   |  -> first cannot be happen here, because already check with rule above
             1 4 |   | · |   | ■ | ■ | ■ |   | · | · |
             */
            if lastIndex > firstIndex {
                
                let firstEmptyBoxFromLastIndex = boxes[lastIndex...].firstIndex(where: { $0.state == .empty }) ?? size-1
                debug("ruleMultipleNumbers - firstEmptyBoxFromLastIndex: \(firstEmptyBoxFromLastIndex+1)", doPrint: print)
                
                let firstEmptyBoxBefore = boxes[0..<firstEmptyBoxFromLastIndex].lastIndex(where: { $0.state == .empty }) ?? 0
                debug("ruleMultipleNumbers - firstEmptyBoxBefore: \(firstEmptyBoxBefore+1)", doPrint: print)
                
                if firstEmptyBoxFromLastIndex < size-1 || firstEmptyBoxBefore > 0 {
                    debug("ruleMultipleNumbers - fill middles for last number in range", doPrint: print)
                    let didChange = ruleFillMiddles(
                        number: lastNumber,
                        from: firstEmptyBoxBefore+2,
                        to: firstEmptyBoxFromLastIndex+1,
                        boxes: boxes,
                        doPrint: print
                    )
                    if didChange {
                        changed = true
                    }
                    
                }
                
                // MARK: --- fills next if not on board but counts
                /*
                 1 4 |   |   |   |   |   | ■ |   | · | · |
                 -
                 1 4 |   |   |   | ■ | ■ | ■ |   | · | · |
                 */
                debug("ruleMultipleNumbers - fill rest if diff to border allows from last", doPrint: print)
                let maxIndexToFill = firstEmptyBoxFromLastIndex - lastNumber.value + 1
                if maxIndexToFill < lastIndex {
                    debug("ruleMultipleNumbers - fill rest if diff to border allows - fromPos \(maxIndexToFill+1) toPos \(lastIndex+1)", doPrint: print)
                    boxes[maxIndexToFill..<lastIndex].forEach { box in
                        if box.state == .unknown {
                            box.state = .filled
                            changed = true
                            debug("box \(box.pos) filled", doPrint: print)
                        }
                    }
                }
                
                
            }
            
            // MARK: --- Box Groups filled
            
            debug("ruleMultipleNumbers - check if numbers done and set emptys on edge", doPrint: print)
            
            if print {
                printBoard()
            }
            var boxGroups = [[Int]]()
            var i = 0
            boxes.indices.forEach { index in
                //debug("\(index) \(i)", doPrint: print)
                if boxes[index].state == .filled {
                    if boxGroups.count == i {
                        boxGroups.append([index])
                    } else {
                        boxGroups[i].append(index)
                    }
                } else {
                    if boxGroups.count > i {
                        i += 1
                    }
                }
            }
            
            debug("ruleMultipleNumbers - boxGroups: \(boxGroups), config: \(config.description)", doPrint: print)
            
            if boxGroups.count == config.numbers.count {
                debug("ruleMultipleNumbers - boxGroups equals numbers", doPrint: print)
                for i in 0..<boxGroups.count {
                    let boxIndexes = boxGroups[i]
                    var number = config.numbers[i]
                    
                    if boxIndexes.count == number.value {
                        debug("ruleMultipleNumbers - boxGroups \(i) same amount of numbers", doPrint: print)
                        if let firstIndex = boxIndexes.first, firstIndex-1 >= 0 {
                            boxes[firstIndex-1].state = .empty
                        }
                        
                        if let lastIndex = boxIndexes.last, lastIndex+1 < size {
                            boxes[lastIndex+1].state = .empty
                        }
                        
                        if i == 0 {
                            debug("ruleMultipleNumbers - fill all unknown before first", doPrint: print)
                            boxes[0..<boxIndexes.first!].forEach { box in
                                if box.state == .unknown {
                                    box.state = .empty
                                    changed = true
                                }
                            }
                        }
                        
                        if i == config.numbers.count-1 {
                            debug("ruleMultipleNumbers - fill all unknown after last", doPrint: print)
                            boxes[boxIndexes.last!...].forEach { box in
                                if box.state == .unknown {
                                    box.state = .empty
                                    changed = true
                                }
                            }
                        }
                        
                        if !number.fullfilled {
                            number.fullfilled = true
                            number.fullfills = boxIndexes
                            changed = true
                        }
                        
                        continue
                    }
                    debug("ruleMultipleNumbers - boxGroups \(i) not same amount \(boxIndexes.count) as number \(number.value)", doPrint: print)
                    
                    if i == 0 {
                        debug("ruleMultipleNumbers - check for unkowns in the beginning", doPrint: print)
                        
                        let outers = number.value - boxIndexes.count
                        let checkTillIndex = boxIndexes.first!-outers
                        let lastIndex = boxIndexes.last!
                        let nextBoxesIndexes = boxGroups[i+1]
                        let stillPossibleMergeGroupCount = boxIndexes.count + nextBoxesIndexes.count + (lastIndex - nextBoxesIndexes.first!)
                        
                        if checkTillIndex > 0  && stillPossibleMergeGroupCount > number.value {
                            boxes[0..<checkTillIndex].forEach { box in
                                if box.state == .unknown {
                                    debug("ruleMultipleNumbers - set box \(box.pos) empty", doPrint: print)
                                    box.state = .empty
                                    changed = true
                                }
                            }
                        }
                        
                        debug("ruleMultipleNumbers - check validity to next indexes", doPrint: print)
                        
                        /*
                         2 4 |   | ■ |   | ■ | ■ | ■ |   |   |   |
                         */
                        
                        
                        if lastIndex+outers+1 == nextBoxesIndexes.first!, boxes[lastIndex+outers].state == .unknown, stillPossibleMergeGroupCount < number.value {
                            debug("ruleMultipleNumbers - check validity to next indexes - box set to empty", doPrint: print)
                            boxes[lastIndex+outers].state = .empty
                            changed = true
                        }
                        
                    }
                    if i == config.numbers.count-1 {
                        debug("ruleMultipleNumbers - check for unknowns in the end", doPrint: print)
                        
                        let outers = number.value - boxIndexes.count
                        let checkFromIndex = boxIndexes.last!+outers+1
                        let earlierBoxesIndexes = boxGroups[i-1]
                        
                        let stillPossibleMergeGroupCount = boxIndexes.count + earlierBoxesIndexes.count + (earlierBoxesIndexes.last! - boxIndexes.first!)
                        
                        if checkFromIndex < size-1, stillPossibleMergeGroupCount < number.value {
                            boxes[checkFromIndex...].forEach { box in
                                if box.state == .unknown {
                                    debug("ruleMultipleNumbers - set box \(box.pos) empty", doPrint: print)
                                    box.state = .empty
                                    changed = true
                                }
                            }
                        }
                    }
                    
                    
                    
                    
                    debug("ruleMultipleNumbers - boxGroups \(i) not same amount of numbers - check for emptys", doPrint: print)
                    
                    if i > 0 {
                        
                        
                        let lastIndex = boxGroups[i-1].last!
                        debug("ruleMultipleNumbers - lastIndex from group before: \(lastIndex), i from current: \(i)", doPrint: print)
                        debug("ruleMultipleNumbers - check possible", doPrint: print)
                        if let nextEmptyIndex = boxes[(lastIndex+1)...].firstIndex(where: { $0.state == .empty } ) {
                            debug("ruleMultipleNumbers - boxGroup next empty pos \(nextEmptyIndex+1). check diff to next", doPrint: print)
                            
                            let neededEmptys = number.value - boxIndexes.count
                            let currentFirstIndex = boxIndexes.first!
                            let from = nextEmptyIndex+1
                            let to = currentFirstIndex-neededEmptys
                            debug("ruleMultipleNumbers - check \(from) to \(to)", doPrint: print)
                            if from <= to {
                                boxes[from..<to].forEach { box in
                                    if box.state == .unknown {
                                        debug("box :\(box.pos) - set empty", doPrint: print)
                                        box.state = .empty
                                        changed = true
                                    }
                                    
                                }
                            } else {
                                debug("ruleMultipleNumbers - skip", doPrint: print)
                            }
                        }
                    }
                    
                    let firstFilled = boxIndexes.first!
                    let lastFilled = boxIndexes.last!
                    
                    // check borders
                    if boxes[firstFilled-1].state == .empty {
                        debug("ruleMultipleNumbers - number hits left border", doPrint: print)
                        boxes[firstFilled..<(firstFilled+number.value)].forEach { box in
                            if box.state == .unknown {
                                box.state = .filled
                                changed = true
                            }
                        }
                        
                        if !number.fullfilled {
                            number.fullfilled = true
                            number.fullfills = (firstFilled..<(firstFilled+number.value)).map { Int($0) }
                            changed = true
                        }
                    } else if boxes[lastFilled+1].state == .empty {
                        debug("ruleMultipleNumbers - number hits right border", doPrint: print)
                        boxes[(lastFilled-(number.value-1))..<lastFilled].forEach { box in
                            if box.state == .unknown {
                                box.state = .filled
                                changed = true
                            }
                        }
                        
                        if !number.fullfilled {
                            number.fullfilled = true
                            number.fullfills = ((lastFilled-(number.value-1))..<lastFilled).map { Int($0) }
                            changed = true
                        }
                    } else {
                        
                        // check middles
                        debug("ruleMultipleNumbers - check middles", doPrint: print)
                        
                        
                        let from = boxes[0...firstFilled].lastIndex(where: { $0.state == .empty }) ?? 0
                        let to = boxes[lastFilled...].firstIndex(where: { $0.state == .empty }) ?? size
                        
                        let didChange = ruleFillMiddles(
                            number: config.numbers[i],
                            from: from == 0 ? from+1: from+2,
                            to: to,
                            boxes: boxes,
                            doPrint: print
                        )
                        
                        if didChange {
                            changed = true
                        }
                    }
                }
            }
//            else {
                let highestNumber = config.numbers.sorted(by: { $0.value > $1.value }).first!.value
                debug("Highest Number: \(highestNumber)", doPrint: print)

                if boxGroups.contains(where: { $0.count == highestNumber }) {
                    debug("Groups contains highest number", doPrint: print)
                    for boxGroup in boxGroups.filter({ $0.count == highestNumber }) {
                        debug("boxGroup equals highest number: \(boxGroup)", doPrint: print)
                        var tmpIndex = -1
                        var valid = true
                        for index in boxGroup {
                            debug("index: \(index) - tmpIndex: \(tmpIndex)", doPrint: print)
                            if tmpIndex == -1 {
                                tmpIndex = index
                            } else if tmpIndex + 1 != index {
                                valid = false
                                break
                            } else {
                                tmpIndex += 1
                            }
                            
                        }
                        guard valid else {
                            debug("Not valid", doPrint: print)
                            continue
                        }
                        debug("ruleMultipleNumbers - boxGroups with same amount of numbers \(boxGroup)", doPrint: print)
                        if let firstIndex = boxGroup.first, firstIndex-1 >= 0 {
                            boxes[firstIndex-1].state = .empty
                        }
                        
                        if let lastIndex = boxGroup.last, lastIndex+1 < size {
                            boxes[lastIndex+1].state = .empty
                        }
                        
                        let nums = config.numbers.filter({ $0.value == highestNumber })
                        var number = nums.first!
                        if nums.count == 1, !number.fullfilled {
                            number.fullfilled = true
                            number.fullfills = boxGroup
                            changed = true
                            debug("number fullfilled: \(number.fullfills)", doPrint: print)
                        }
                        
                    }
                    
                }
                
//            }
            
//            debug("ruleMultipleNumbers - check all gaps and fill them logical if possible", doPrint: print)
//            
//            var gapGroup = [[Int]]()
//            var j = 0
//            boxes.indices.forEach { index in
//                if boxes[index].state != .empty {
//                    if gapGroup.count == j {
//                        gapGroup.append([index])
//                    } else {
//                        gapGroup[j].append(index)
//                    }
//                } else if gapGroup.count > j {
//                    j += 1
//                }
//            }
//            
//            debug("ruleMultipleNumbers - gapGroups \(gapGroup)",  doPrint: print)
            
            // check for same amount of gapGroups than numbers
            // -> check non fullfilled number with gapGroup
            // -> fill if possible, border check, etc ... again? Just fillMiddle?
//            if gapGroup.count == config.numbers.count {
//                debug("ruleMultipleNumbers - gapGroups same amount as numbers",  doPrint: print)
//                
//                for j in 0..<gapGroup.count {
//                    
//                    let boxIndexes = gapGroup[j]
//                    let number = config.numbers[j]
//                    
//                    if number.fullfilled {
//                        debug("ruleMultipleNumbers - number fullfiled, for sake set all if needed", doPrint: print)
//                        boxes[boxIndexes.first!...boxIndexes.last!].filter({$0.state == .unknown}).forEach { box in
//                            box.state = .empty
//                            changed = true
//                        }
//                        
//                    } else {
//                        
//                        let firstBox = boxIndexes.first!
//                        let lastBox = boxIndexes.last!
//                        // check border
//                        if boxes[firstBox].state == .filled {
//                            debug("ruleMultipleNumbers - filled hits first border, fill rest. fromPos \(firstIndex+1) toPos \(firstBox+1+(number.value-1))", doPrint: print)
//                            boxes[firstBox..<(firstBox+(number.value-1))].forEach { box in
//                                if box.state == .unknown {
//                                    box.state = .filled
//                                    changed = true
//                                }
//                            }
//                            if !number.fullfilled {
//                                number.fullfilled = true
//                                changed = true
//                            }
//                        } else if boxes[lastBox].state == .filled {
//                            debug("ruleMultipleNumbers - filled hits last border, fill rest. fromPos \((lastIndex+1)-(number.value-1)) toPos \(lastIndex+1)", doPrint: print)
//                            
//                            boxes[(lastBox-(number.value-1))..<lastBox].forEach { box in
//                                if box.state == .unknown {
//                                    box.state = .filled
//                                    changed = true
//                                }
//                            }
//                            if !number.fullfilled {
//                                number.fullfilled = true
//                                changed = true
//                            }
//                        } else {
//                            debug("ruleMultipleNumbers - filled hits no border, check middles", doPrint: print)
//                            
//                            //                            let didChange = ruleFillMiddles(
//                            //                                number: number,
//                            //                                from: firstBox,
//                            //                                to: lastBox,
//                            //                                boxes: boxes,
//                            //                                doPrint: print
//                            //                            )
//                            //                            if didChange {
//                            //                                changed = true
//                            //                            }
//                            
//                        }
//                        
//                    }
//                    
//                }
//            } else {
//                //                // MARK: i was here
//                //                // should not only be here?
//                //                debug("ruleMultipleNumbers - gapGroups not same amount as numbers - \(config.description)",  doPrint: print)
//                //                for number in config.numbers {
//                //                    debug("ruleMultipleNumbers - gap groups number")
//                //                    debug("Number: \(number.value), Fullfilled: \(number.fullfilled)", doPrint: print)
//                //                    debug("Fullfilled Boxes: \(number.fullfills)", doPrint: print)
//                //
//                //                }
//            }
//            
            
            // if not same amount, check for possible invalid gaps
            // -> some numbers already  used in gaps, -> rest of numbers to high
            
            // MARK: - when nothing changed. Check the fullfilled ones
            if config.numbers.contains(where: { $0.fullfilled }), !config.fullfilled {
                if print {
                    printBoard()
                }
                // MARK: i was here
                // should not only be here?
                var print = true
                debug("ruleMultipleNumbers - notChanged? check stuff besides fullfilled - \(config.description)",  doPrint: print)
                for index in config.numbers.indices {
                    var number = config.numbers[index]
                    debug("ruleMultipleNumbers - NumberIndex: \(index)", doPrint: print)
                    debug("Number: \(number.value), Fullfilled: \(number.fullfilled)", doPrint: print)
                    debug("Fullfilled Boxes: \(number.fullfills)", doPrint: print)
                    
                    if number.fullfilled {
                        
                        guard number.fullfills.count > 0 else {
                            debug("ruleMultipleNumbers - number fullfilled but no correct box identifiable", doPrint: print)
                            continue
                        }
                        
                        debug("ruleMultipleNumbers - check next numbers", doPrint: print)
                        // run new middle for numbers before and after
                        if index > 0 {
                            
                            debug("ruleMultipleNumbers - check numbers from right to left", doPrint: print)
                            // wich numbers are before?
                            // are they fullfilled?
                            // what is the range?
                            
                            
                            /*
                             were not the first number
                             go direction left in numbers
                             set first fullfiled box - 2 as to value (unknown - n...empty - filled ....)
                             lopp every number before, index = 2? nextindex = 1 ....
                                if fullfilled - adjust boxes range?
                                    to = newIndexes fullfilled - 2
                                if not
                                    set from rang from "to" - number value ?
                                if next is fullfilled again
                                    runFillMiddle for one number that was not filled.
                                    from will be currentNumber box last index + 2
                             
                                if newIndex == 0
                                    check if needs to set border as to value
                             */
                            
                            var from = 0
                            guard var to = boxes[0..<number.fullfills.first!].lastIndex(where: { $0.state != .empty }) else {
                                debug("all done before fullfiled number?", doPrint: print)
                                continue
                            }
                            
                            debug("toPos: \(to+1), fromPos: \(from+1)", doPrint: print)
                            var foundUnfullfilledNumbers: [Number] = []
                            for i in (0..<index).reversed() {
                                var nextNumber = config.numbers[i]
                                debug("Next Number: \(nextNumber.value)", doPrint: print)
                                debug("Fullfilled Boxes: \(nextNumber.fullfills)", doPrint: print)
                                /*
                                if nextNumber.fullfilled {
                                    if foundUnfullfilledNumbers.count == 1 {
                                        debug("Fullfilled and the number between unfulfiled. Check middle", doPrint: print)
                                        
                                        if let newTo = boxes[from...nextNumber.fullfills.first!-2].lastIndex(where: { $0.state == .empty }) {
                                            to = newTo
                                        }
                                        
                                        var didChange = ruleFillMiddles(
                                            number: foundUnfullfilledNumbers.removeFirst(),
                                            from: from+1,
                                            to: to,
                                            boxes: boxes,
                                            doPrint: print
                                        )
                                        if didChange {
                                            changed = true
                                        }
                                        foundUnfullfilledNumbers = []
                                        
                                    } else if foundUnfullfilledNumbers.count > 1 {
                                        debug("Fullfilled and there multiple numbers unfullfiled in between", doPrint: print)
                                        let didChange = ruleFillMiddles(
                                            forMultipleNumbers: foundUnfullfilledNumbers,
                                            initialFrom: from,
                                            initialTo: to,
                                            boxes: boxes,
                                            doPrint: print
                                        )
                                        
                                        foundUnfullfilledNumbers = []
                                    } else {
                                        
                                        debug("for sake fill the middles", doPrint: print)
                                        boxes[number.fullfills.last!..<nextNumber.fullfills.first!].forEach { box in
                                            if box.state == .unknown {
                                                debug("box \(box.pos) - set empty", doPrint: print)
                                                box.state = .empty
                                                changed = true
                                            }
                                        }
                                    }
                                    debug("get next from - current fromPos: \(from+1)", doPrint: print)
                                    
                                    if let newFrom = boxes[(nextNumber.fullfills.last!+1)...].firstIndex(where: { $0.state != .empty }) {
                                        from = newFrom
                                        debug("toPos: \(to+1), fromPos: \(from+1)", doPrint: print)
                                    }
                                    
                                } else {
                                    debug("unfullfilled number ... add to stack", doPrint: print)
                                    foundUnfullfilledNumbers.append(nextNumber)
                                }
                                 */
                            }
                            /*
                            debug("foundUnfullfilledNumbers: \(foundUnfullfilledNumbers.count)", doPrint: print)
                            if foundUnfullfilledNumbers.count == 1 {
                                debug("Fullfilled and the number afterward is unfulfiled. Check middle", doPrint: print)
                                
                                to = boxes[from...].lastIndex(where: { $0.state == .empty }) ?? size
                                
                                var didChange = ruleFillMiddles(
                                    number: foundUnfullfilledNumbers.removeFirst(),
                                    from: from+1,
                                    to: to,
                                    boxes: boxes,
                                    doPrint: print
                                )
                                if didChange {
                                    changed = true
                                }
                                foundUnfullfilledNumbers = []
                                break
                            } else if foundUnfullfilledNumbers.count > 1 {
                                debug("Fullfilled and there multiple numbers unfullfiled afterwards", doPrint: print)
                                
                                let didChange = ruleFillMiddles(
                                    forMultipleNumbers: foundUnfullfilledNumbers,
                                    initialFrom: from,
                                    initialTo: to,
                                    boxes: boxes,
                                    doPrint: print
                                )
                                
                                debug("Fullfilled and there multiple numbers unfullfiled afterwards - didChange: \(didChange)", doPrint: print)
                                
                                if didChange {
                                    changed = true
                                }
                                
                                foundUnfullfilledNumbers = []
                                break
                            }
                             */
                        }
                        
                        if index < config.numbers.count - 1 {
                            debug("ruleMultipleNumbers - check numbers from left to right", doPrint: print)
                            /*
                             -were not the last number
                             -go direction right in numbers
                             -set to as most right
                             -set first unknown after last fullfiled box as from, at least +2 (filled - n...empty - unknown)
                             -lop every number after, index = 1, nextIndex = 2
                                if number is fullfilled - adjust from range
                                    from = nextIndex last box + 2 (filled - n...empty - unknown)
                                if not
                                    set from range to first next unknown
                                if next Number is fullfilled again
                                    set range acordingly and runFillMiddle. -> but proceed afterwards and reset from - to
                                if nextIndex == last
                                    check to set
                             */
                            var to = size-1
                            guard var from = boxes[(number.fullfills.last!+1)...].firstIndex(where: { $0.state != .empty }) else {
                                debug("all done after fullfiled number?", doPrint: print)
                                continue
                            }
                            debug("toPos: \(to+1), fromPos: \(from+1)", doPrint: print)
                            var foundUnfullfilledNumbers: [Number] = []
                            for i in (index+1)..<config.numbers.count {
                                var nextNumber = config.numbers[i]
                                debug("Next Number: \(nextNumber.value)", doPrint: print)
                                debug("Fullfilled Boxes: \(nextNumber.fullfills)", doPrint: print)

                                if nextNumber.fullfilled {
                                    if foundUnfullfilledNumbers.count == 1 {
                                        debug("Fullfilled and the number between unfulfiled. Check middle", doPrint: print)
                                        
                                        if let newTo = boxes[from...nextNumber.fullfills.first!-2].lastIndex(where: { $0.state == .empty }) {
                                            to = newTo
                                        }
                                        
                                        var didChange = ruleFillMiddles(
                                            number: foundUnfullfilledNumbers.removeFirst(),
                                            from: from+1,
                                            to: to,
                                            boxes: boxes,
                                            doPrint: print
                                        )
                                        if didChange {
                                            changed = true
                                        }
                                        foundUnfullfilledNumbers = []
                                        
                                    } else if foundUnfullfilledNumbers.count > 1 {
                                        debug("Fullfilled and there multiple numbers unfullfiled in between", doPrint: print)
                                        let didChange = ruleFillMiddles(
                                            forMultipleNumbers: foundUnfullfilledNumbers,
                                            initialFrom: from,
                                            initialTo: to,
                                            boxes: boxes,
                                            doPrint: print
                                        )
                                        
                                        foundUnfullfilledNumbers = []
                                    } else {
                                        
                                        debug("for sake fill the middles", doPrint: print)
                                        boxes[number.fullfills.last!..<nextNumber.fullfills.first!].forEach { box in
                                            if box.state == .unknown {
                                                debug("box \(box.pos) - set empty", doPrint: print)
                                                box.state = .empty
                                                changed = true
                                            }
                                        }
                                    }
                                    debug("get next from - current fromPos: \(from+1)", doPrint: print)
                                    
                                    if let newFrom = boxes[(nextNumber.fullfills.last!+1)...].firstIndex(where: { $0.state != .empty }) {
                                        from = newFrom
                                        debug("toPos: \(to+1), fromPos: \(from+1)", doPrint: print)
                                    }
                                    
                                } else {
                                    debug("unfullfilled number ... add to stack", doPrint: print)
                                    foundUnfullfilledNumbers.append(nextNumber)
                                }
                            }
                            
                            debug("foundUnfullfilledNumbers: \(foundUnfullfilledNumbers.count)", doPrint: print)
                            if foundUnfullfilledNumbers.count == 1 {
                                debug("Fullfilled and the number afterward is unfulfiled. Check middle", doPrint: print)
                                
                                to = boxes[from...].lastIndex(where: { $0.state == .empty }) ?? size
                                
                                var didChange = ruleFillMiddles(
                                    number: foundUnfullfilledNumbers.removeFirst(),
                                    from: from+1,
                                    to: to,
                                    boxes: boxes,
                                    doPrint: print
                                )
                                if didChange {
                                    changed = true
                                }
                                foundUnfullfilledNumbers = []
                                break
                            } else if foundUnfullfilledNumbers.count > 1 {
                                debug("Fullfilled and there multiple numbers unfullfiled afterwards", doPrint: print)
                                
                                let didChange = ruleFillMiddles(
                                    forMultipleNumbers: foundUnfullfilledNumbers,
                                    initialFrom: from,
                                    initialTo: to,
                                    boxes: boxes,
                                    doPrint: print
                                )
                                
                                debug("Fullfilled and there multiple numbers unfullfiled afterwards - didChange: \(didChange)", doPrint: print)
                                
                                if didChange {
                                    changed = true
                                }
                                
                                foundUnfullfilledNumbers = []
                                break
                            }
                        }
                             
                    }
                    
                }
            }
            
        } else {
            debug("ruleMultipleNumbers - no filled boxes", doPrint: print)
        }
        
        
        debug("ruleMultipleNumbers -  finished - changed: \(changed)", doPrint: print)
        return changed
    }
    
    private func ruleFillMiddles(forMultipleNumbers numbers: [Number], initialFrom: Int, initialTo: Int, boxes: [Box], doPrint: Bool = false)  -> Bool {
        debug("ruleFillMiddles(forMultiplenumbers", doPrint: doPrint)
        let countOfNumbers = numbers.count
        var changed = false
        // MARK: -- middles for all numbers
        for i in 0..<countOfNumbers {
            debug("ruleFillMiddles(forMultiplenumbers - checkNumber: \(i)", doPrint: doPrint)
            // search for middles?
            var number = numbers[i]
            debug("ruleFillMiddles(forMultiplenumbers - checkNumber: \(i) value: \(number.value) fullfilled: \(number.fullfilled)", doPrint: doPrint)
            
            guard !number.fullfilled else {
                continue
            }
                        
            var from = initialFrom + 1
            if i > 0 {
                // add unfree space from numbers befor index
                for j in 0..<i {
                    from += 1
                    from += numbers[j].value
                }
            }
            
            var to = initialTo+1
            if i+1 < countOfNumbers {
                // add unfree space from numbers after index
                for j in i+1..<countOfNumbers {
                    to -= 1
                    to -= numbers[j].value
                }
            }
            
            debug("ruleFillMiddles(forMultiplenumbers - from: \(from), to: \(to)", doPrint: doPrint)
            
            let didChange = ruleFillMiddles(
                number: number,
                from: from,
                to: to,
                boxes: boxes,
                doPrint: doPrint
            )
            
            if didChange {
                changed = true
            }
        }
        
        return changed
    }
    
    private func ruleCheckDone(config: Config, boxes: [Box], size: Int) -> Bool {
        var print = false // config.pos == (x: 4, y: 0)
        
        debug("ruleCheckDone - config \(config.description)", doPrint: print)
        
        var changed = false
        let filledBoxes = boxes.filter({ $0.state == .filled }).count
        debug("ruleCheckDone - filled: \(filledBoxes), numberSize: \(config.numbersSize)", doPrint: print)
        if filledBoxes == config.numbersSize {
            debug("ruleCheckDone - all filled -> fill emptys", doPrint: print)
            for box in boxes.filter({$0.state == .unknown}) {
                box.state = .empty
            }
            config.numbers.forEach { $0.fullfilled = true }
            changed = true
        } else {
            
            if boxes.filter({ $0.state != .empty }).count == config.numbersSize {
                debug("ruleCheckDone - all filled -> fill emptys", doPrint: print)
                for box in boxes.filter({$0.state == .unknown}) {
                    box.state = .filled
                }
                config.numbers.forEach { $0.fullfilled = true }
                changed = true
            }
        }
        
        if !changed {
            printBoard()
            debug("ruleCheckDone - check for done numbers for sure", doPrint: print)
            debug("ruleCheckDone - from left to right", doPrint: print)
            
            var tmpIndexes: [Int] = []
            var currentNumberIndex = 0
            for index in boxes.indices {
                var box = boxes[index]
                guard box.state != .unknown else {
                    break
                }
                
                if box.state == .filled {
                    tmpIndexes.append(index)
                }
                if box.state == .empty {
                    if tmpIndexes.count > 0 {
                        var number = config.numbers[currentNumberIndex]
                        if number.value == tmpIndexes.count {
                            number.fullfilled = true
                            number.fullfills = tmpIndexes
                            currentNumberIndex += 1
                            debug("ruleCheckDone - fullfilled number: \(number.value) - boxes: \(number.fullfills) ", doPrint: print)
                        } else {
                            break
                        }
                    }
                    
                    tmpIndexes = []
                }
                
            }
            
            debug("ruleCheckDone - from right to left", doPrint: print)
            currentNumberIndex = config.numbers.count-1
            tmpIndexes = []
            for index in boxes.indices.reversed() {
                var box = boxes[index]
                guard box.state != .unknown else {
                    break
                }
                
                if box.state == .filled {
                    tmpIndexes.append(index)
                }
                if box.state == .empty {
                    if tmpIndexes.count > 0 {
                        var number = config.numbers[currentNumberIndex]
                        if number.value == tmpIndexes.count {
                            number.fullfilled = true
                            number.fullfills = tmpIndexes.reversed()
                            currentNumberIndex -= 1
                            debug("ruleCheckDone - fullfilled number: \(number.value) - boxes: \(number.fullfills) ", doPrint: print)

                        } else {
                            break
                        }
                    }
                    
                    tmpIndexes = []
                }
                
            }
           
            
        }
        
        if changed {
            var boxIndex = boxes.firstIndex(where: { $0.state == .filled })!
            debug("ruleCheckDone - changed - firstBoxIndex \(boxIndex)", doPrint: print)
            config.numbers.forEach { number in
                
                number.fullfills = (boxIndex..<(boxIndex+number.value)).map { Int($0) }
                debug("ruleCheckDone - changed - number: \(number.value) - fullfilles: \(number.fullfills)", doPrint: print)
                let nextStart = (number.fullfills.last!+1)
                if nextStart < size - 1 {
                    
                    if let newIndex = boxes[nextStart...].firstIndex(where: { $0.state == .filled }) {
                        boxIndex = newIndex
                        debug("ruleCheckDone - changed - newBoxIndex \(boxIndex)", doPrint: print)
                    } else {
                        debug("ruleCheckDone - changed - no new box", doPrint: print)
                    }
                }
                
            }
        }
        
        debug("ruleCheckDone - didChange: \(changed)", doPrint: print)
        return changed
    }
   
    
    func solveViaConf() {
        var changed = false
        
        repeat {
            changed = false
            for i in 0..<configs.count {
                var config = configs[i]
                
                var print = false // config.pos == (x: 4, y: 0)
                
                debug("check: \(i) -> \(config.description)", doPrint: print)

                
                var configBoxes = [Box]()
                var sizeForRule = 0
                
                if config.pos.x == 0 {
                    // boxes from left to right
                    configBoxes = boxes.filter { $0.pos.y == config.pos.y }
                    sizeForRule = width
                } else {
                    // boxes from top to bottom
                    configBoxes = boxes.filter { $0.pos.x == config.pos.x }
                    sizeForRule = height
                }
                
                guard !config.fullfilled || configBoxes.contains(where: { $0.state == .unknown }) else {
                    debug("already done", doPrint: print)
                    continue
                }
                
                                
                guard !ruleFillAll(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleFillAll -> changed and continue", doPrint: print)
                    changed = true
                    continue
                }
                
                guard !ruleMultipleNumbersFillAll(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleMultipleNumbersFillAll -> changed and continue", doPrint: print)
                    changed = true
                    continue
                }
                
                guard !ruleCheckDone(config: config, boxes: configBoxes, size: sizeForRule) else {
                    debug("ruleCheckDone -> changed and continue", doPrint: print)
                    changed = true
                    continue
                }
                
                guard !ruleOneNumber(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleOneNumber -> changed and continue", doPrint: print)
                    changed = true
                    continue
                }
                
                guard !ruleMultipleNumbers(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleMultipleNumbers -> changed and continue", doPrint: print)
                    changed = true
                    continue
                }

            }
            
            printBoard()
        } while(boxes.contains(where: { $0.state == .unknown }) && changed)
    }
   
}

var grid = Grid(width: width, height: height)

if width > 0 {
    for i in 0...(width-1) {
        let blackGroups = readLine()!
        grid.addConfig(at: (x: i+1, y: 0), numbers: blackGroups)
    }
}
if height > 0 {
    for i in 0...(height-1) {
        let blackGroups = readLine()!
        grid.addConfig(at: (x: 0, y: i+1), numbers: blackGroups)
    }
}

grid.printBoard()
grid.solveViaConf()

var finalOutput = grid.printWhites()

finalOutput.forEach {
    print($0)
}

// END

print(exepcted == finalOutput)



