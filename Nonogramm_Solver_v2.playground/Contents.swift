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

//var input = inputDog
//var exepcted = expectedOutputDog

var input = inputMusic
var exepcted = expectedOutputMusic

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
       |^1 |^3 |^2 |^5 |^1 |
    ^1 | · | · | · | ■ | · |
 ^1 ^3 | ■ | · | ■ | ■ | ■ |
    ^3 | · | ■ | ■ | ■ | · |
 ^1 ^1 | · | ■ | · | ■ | · |
 ^1 ^1 | · | ■ | · | ■ | · |

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

func debug(_ message: String, doPrint: Bool = true) {
    if doPrint {
        print(message)
    }
}


/// START

let inputs = (readLine()!).split(separator: " ").map(String.init)
let width = Int(inputs[0])!
let height = Int(inputs[1])!

var configs: [Config] = []
if width > 0 {
    for i in 0...(width-1) {
        let blackGroups = readLine()!
        configs.append(
            Config(
                pos: (x: i+1, y: 0),
                clues: blackGroups.split(separator: " ").map { Int($0)! }
            )
        )
    }
}
if height > 0 {
    for i in 0...(height-1) {
        let blackGroups = readLine()!
        configs.append(
            Config(
                pos: (x: 0, y: i+1),
                clues: blackGroups.split(separator: " ").map { Int($0)! }
            )
        )
    }
}

/// Generate all possible Nonogram line patterns for given length and clues.
/// Each pattern is an array of Int (0 = empty, 1 = filled).
func generatePatterns(length n: Int, blocks: [Int]) -> [[Int]] {
    let k = blocks.count
    if k == 0 { return [Array(repeating: 0, count: n)] } // no blocks → all empty
    
    let totalBlocks = blocks.reduce(0, +)
    let minSpaces = k - 1
    let minLength = totalBlocks + minSpaces
    let slack = n - minLength
    if slack < 0 { return [] } // impossible
    
    var patterns: [[Int]] = []
    var slots = Array(repeating: 0, count: k + 1)
    
    // recursive helper to distribute the "slack" empties into (k+1) slots
    func distribute(_ index: Int, _ remaining: Int) {
        if index == k {
            slots[index] = remaining
            var line: [Int] = []
            // prefix empties
            line.append(contentsOf: repeatElement(0, count: slots[0]))
            // blocks + gaps
            for i in 0..<k {
                line.append(contentsOf: repeatElement(1, count: blocks[i]))
                if i < k - 1 {
                    line.append(contentsOf: repeatElement(0, count: 1 + slots[i + 1]))
                }
            }
            // trailing empties
            line.append(contentsOf: repeatElement(0, count: slots.last ?? 0))
            if line.count == n {
                patterns.append(line)
            }
            return
        }
        for value in 0...remaining {
            slots[index] = value
            distribute(index + 1, remaining - value)
        }
    }
    
    distribute(0, slack)
    return patterns
}

/// Utility to render a pattern as a string
func renderPattern(_ pattern: [Int]) -> String {
    return pattern.map { $0 == 1 ? "#" : "." }.joined()
}

typealias Pos = (x: Int, y: Int)

class Config: Hashable {
    let pos: Pos
    let clues: [Int]
    
    init(pos: Pos, clues: [Int]) {
        self.pos = pos
        self.clues = clues
    }
    
    var description: String {
        "\(pos) - \(clues))"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(pos)")
    }
}

func ==(lhs: Config, rhs: Config) -> Bool {
    lhs.pos == rhs.pos
}

typealias Pattern = [Config: [[Int]]]

var xPatterns: Pattern = [:]
var yPatterns: Pattern = [:]

for config in configs {
    if config.pos.x == 0 {
        let length = height
        xPatterns[config] = generatePatterns(length: length, blocks: config.clues)
    }
    if config.pos.y == 0 {
        let length = width
        yPatterns[config] = generatePatterns(length: length, blocks: config.clues)
    }
}

func checkToRemove(forOnlyComb theComb: [Int], positon: Int, config: Config, combs: [[Int]]) -> [[Int]] {
    let combCount = combs.count
    debug("Pattern: \(config.description) - Combinations: \(combCount)")
    let thisPosition = config.pos.x == 0 ? config.pos.y : config.pos.x
    
    var combToRemove: [[Int]] = []
    for index in combs.indices {
        let comb = combs[index]
        debug("\(comb)")
        if comb[positon-1] != theComb[thisPosition-1] {
            debug("remove")
            combToRemove.append(comb)
        }
    }
    return combToRemove
}

var changed = false
var doPrint = true
repeat {
    changed = false
    debug("x Patterns check for reduce", doPrint: doPrint)
    for pattern in xPatterns {
        let combCount = pattern.value.count
        debug("\(pattern.key.description) - Combinations: \(combCount)", doPrint: doPrint)
        
        if combCount == 1 {
            debug("Only 1 pattern. Remove all in yPatterns where not match", doPrint: doPrint)
            let theComb = pattern.value.first!
            let y = pattern.key.pos.y
            
            for yPattern in yPatterns {
                let combToRemove = checkToRemove(forOnlyComb: theComb, positon: y, config: yPattern.key, combs: yPattern.value)
                if combToRemove.count > 0 {
                    changed = true
                }
                yPatterns[yPattern.key]?.removeAll { comb in
                    combToRemove.contains(comb)
                }
                
            }
            
        }
        
    }
    
    debug("y Patterns check for reduce", doPrint: doPrint)
    for pattern in yPatterns {
        let combCount = pattern.value.count
        debug("\(pattern.key.description) - Combinations: \(combCount)", doPrint: doPrint)
        if combCount == 1 {
            debug("Only 1 pattern. Remove all in yPatterns where not match", doPrint: doPrint)
            let theComb = pattern.value.first!
            debug("\(theComb)", doPrint: doPrint)
            let x = pattern.key.pos.x
            
            for xPattern in xPatterns {
                let combToRemove = checkToRemove(forOnlyComb: theComb, positon: x, config: xPattern.key, combs: xPattern.value)
                if combToRemove.count > 0 {
                    changed = true
                }
                xPatterns[xPattern.key]?.removeAll { comb in
                    combToRemove.contains(comb)
                }
                
            }
        }
    }
} while (changed)

let printOutput = false
for pattern in xPatterns.sorted(by: { lhs, rhs in lhs.key.pos.y < rhs.key.pos.y }) {
    for comb in pattern.value {
        debug(renderPattern(comb), doPrint: printOutput)
    }
}

var outputLines: [String] = []
for pattern in yPatterns.sorted(by: { lhs, rhs in lhs.key.pos.x < rhs.key.pos.x }) {
    var tmpCount = 0
    var output = ""
    debug(pattern.key.description, doPrint: printOutput)
    debug("\(pattern.value)", doPrint: printOutput)
    for value in pattern.value.first! {
        if value == 0 {
            tmpCount += 1
        } else if tmpCount > 0 {
            if output.isEmpty {
                output += "\(tmpCount)"
            } else {
                output += " \(tmpCount)"
            }
            tmpCount = 0
        }
    }
    
    if output.isEmpty {
        output += "\(tmpCount)"
    } else if tmpCount > 0 {
        output += " \(tmpCount)"
    }
    debug(output, doPrint: printOutput)
    
    outputLines.append(output)
}

for pattern in xPatterns.sorted(by: { lhs, rhs in lhs.key.pos.y < rhs.key.pos.y }) {
    var tmpCount = 0
    var output = ""
    debug(pattern.key.description, doPrint: printOutput)
    debug("\(pattern.value)", doPrint: printOutput)
    for value in pattern.value.first! {
        if value == 0 {
            tmpCount += 1
        } else if tmpCount > 0 {
            if output.isEmpty {
                output += "\(tmpCount)"
            } else {
                output += " \(tmpCount)"
            }
            tmpCount = 0
        }
    }
    
    if output.isEmpty {
        output += "\(tmpCount)"
    } else if tmpCount > 0 {
        output += " \(tmpCount)"
    }
    debug(output, doPrint: printOutput)
    
    outputLines.append(output)
}

/*
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
 */

outputLines.forEach {
    print($0)
}

// END

print(exepcted == outputLines)

//print("Number of patterns:", patterns.count)
//print("First 5 patterns:")
//for i in 0..<min(5, patterns.count) {
//    print(renderPattern(patterns[i]))
//}
