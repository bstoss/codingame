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

var input = inputMusic
var exepcted = expectedOutputMusic

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
            */

func debug(_ message: String) {
    print(message)
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
    
    func printBoard() {
        
        
        let confYAllNumbers = configs.filter { $0.pos.y == 0 }
        var topLine: String = ""
        
        var sortedForYMax = confYAllNumbers.sorted { $0.numbers.count > $1.numbers.count }
        var maxYCount = sortedForYMax.first!.numbers.count
        
        let confXAllNumbers = configs.filter { $0.pos.x == 0 }
        let sortedForXMax = confXAllNumbers.sorted { $0.numbers.count > $1.numbers.count }
        var maxXCount = sortedForXMax.first!.numbers.count
        
        for k in 0..<maxYCount {
            topLine += (0..<maxXCount).map({ _ in " " }).joined(separator: " ") + " |"
            for config in confYAllNumbers {
                
                let count = config.numbers.count
                if count < maxYCount - k {
                    topLine += "   |"
                } else {
                    topLine += " \(config.numbers[count-(maxYCount-k)].value) |"
                }
            }
            debug(topLine)
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
                            row += "  "
                        } else {
                            row += "\(config.numbers[count-(maxXCount-k)].value) "
                        }
                    }
                    row += "|"
                } else {
                    row += " \(boxes.first(where: { $0.pos == (x: j, y: i) })!.printedState) |"
                }
            }
            
            debug(row)
            
        }
    }
    
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
        
        debug("find possible space")
        // TODO: find a way to reafactor ....
        // something like rules ...
        
        debug("one number. fill middle")

        changed = ruleFillMiddles(
            number: number,
            from: from,
            to: to,
            boxes: boxes
        )
        
        
        return changed

    }
    
    private func ruleFillMiddles(number: Number, from: Int, to: Int, boxes: [Box]) -> Bool {
        
        debug("ruleFillMiddles from: \(from) to: \(to)")
        
        var changed = false
        
        var outers = to - (from-1) - number.value
        debug("ruleFillMiddles outer: \(outers)")
        
        var lower = from + outers
        var upper = to - outers
        
        guard lower <= upper else {
            debug("ruleFillMiddles - no match")
            return false
        }
        
        debug("ruleFillMiddles - match -> fillMiddles lower \(lower) to \(upper)")
        for j in lower...upper {
            // use j - 1
            if j > 0 && (j-1) < boxes.count {
                var box = boxes[j-1]
                debug("box \(box.pos)")
                if box.state == .unknown {
                    box.state = .filled
                    changed = true
                }
                
            }
        }
                
        return changed
    }
    
    private func ruleMultipleNumbers(config: Config, size: Int, boxes: [Box]) -> Bool {
        var changed = false
        
        debug("ruleMultipleNumbers")
        
        let countOfNumbers = config.numbers.count
        
        guard countOfNumbers > 1 else {
            debug("ruleMultipleNumbers - no multiple numbers")
            return false
        }
            
            
        debug("ruleMultipleNumbers - numbers - \(countOfNumbers)")
        
        for ii in 0..<countOfNumbers {
            // search for middles?
            var number = config.numbers[ii]
            
            guard !number.fullfilled else {
                continue
            }
            
            debug("ruleMultipleNumbers - check middle for index: \(ii) - value: \(number.value)")
            
            var from = 1
            if ii > 0 {
                // add unfree space from numbers befor index
                for j in 0..<ii {
                    from += 1
                    from += config.numbers[j].value
                }
            }
            
            var to = size
            if ii+1 < countOfNumbers {
                // add unfree space from numbers after index
                for j in ii+1..<countOfNumbers {
                    to -= 1
                    to -= config.numbers[j].value
                }
            }
            
            debug("ruleMultipleNumbers - from: \(from), to: \(to)")
            
            let didChange = ruleFillMiddles(
                number: number,
                from: from,
                to: to,
                boxes: boxes
            )
            
            if didChange {
                changed = true
            }
        }
        
//        debug("ruleMultipleNumbers - fill borders if not fit")
//        if boxes.contains(where: { $0.state == .empty }) {
//            
////            var firstNumber = config.numbers.first!
////            var lastNumber = config.numbers.last!
////            debug("ruleMultipleNumbers - firstNumber: \(firstNumber.value) lastNumber: \(lastNumber.value)")
////            
//            var numberIndex = 0
//            
//            for index in boxes.indices {
//                guard boxes[index].state == .unknown else { continue }
//                guard numberIndex < config.numbers.count else { break }
//                
//                var number = config.numbers[numberIndex]
//                
//                let minIndex = max(0, index-(number.value-1))
//                let maxIndex = min(size-1, index+(number.value-1))
//                debug("ruleMultipleNumbers - index: \(index) minIndex: \(minIndex) maxIndex: \(maxIndex)")
//                var filtered = boxes[minIndex...maxIndex].filter({ $0.state == .unknown || $0.state == .filled })
//                
//                filtered.forEach { box in
//                    debug("box pos: \(box.pos) state: \(box.state)")
//                }
//                
//                if filtered.count < number.value {
//                    debug("ruleMultipleNumbers - change box \(boxes[index].pos)")
//                    boxes[index].state = .empty
//                    changed = true
//                } else {
//                    debug("ruleMultipleNumbers - number does fit. go to next")
//                    numberIndex += 1
//                }
//            }
//        } else {
//            debug("ruleMultipleNumbers - no empty fields")
//        }
        
        debug("ruleMultipleNumbers - check border fields")
        
        if boxes.contains(where: { $0.state == .filled }) {
            
            let firstIndex = boxes.firstIndex(where: { $0.state == .filled })!
            let lastIndex = boxes.lastIndex(where: { $0.state == .filled })!
            debug("ruleMultipleNumbers - firstIndexPos: \(firstIndex+1) lastIndexPos: \(lastIndex+1)")
            
            var firstNumber = config.numbers.first!
            var lastNumber = config.numbers.last!
            debug("ruleMultipleNumbers - firstNumber: \(firstNumber.value) lastNumber: \(lastNumber.value)")
            
            if firstIndex == 0 && boxes[0...firstNumber.value].contains(where: { $0.state == .unknown }) && !firstNumber.fullfilled {
                debug("ruleMultipleNumbers - hit first border - fill rest")
                boxes[0..<firstNumber.value].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                
                boxes[firstNumber.value].state = .empty
                debug("box: \(boxes[firstNumber.value].pos) empty")
                firstNumber.fullfilled = true
                changed = true
            }
            
            if !boxes[0..<firstIndex].contains(where: { $0.state == .unknown }) && !firstNumber.fullfilled {
                debug("ruleMultipleNumbers - hit first border - fill rest - borde was an empty")
                boxes[firstIndex..<(firstNumber.value+firstIndex-1)].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                boxes[firstIndex+firstNumber.value].state = .empty
                debug("box: \(boxes[firstIndex+firstNumber.value].pos) empty")
                firstNumber.fullfilled = true
                changed = true
            }
            
            if lastIndex == size-1 && boxes[(size-lastNumber.value-1)...].contains(where: { $0.state == .unknown }) && !lastNumber.fullfilled {
                // ruleMultipleNumbers - firstIndexPos: 4 lastIndexPos: 10
                debug("ruleMultipleNumbers - hit last border - fill rest")
                boxes[(size-lastNumber.value)...].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                boxes[size-lastNumber.value-1].state = .empty
                debug("box: \(boxes[size-lastNumber.value-1].pos) empty")
                lastNumber.fullfilled = true
                changed = true
            }
            
            if !boxes[lastIndex...].contains(where: { $0.state == .unknown }) && !lastNumber.fullfilled {
                debug("ruleMultipleNumbers - hit last border - fill rest - borde was an empty")
                boxes[lastIndex-lastNumber.value-1..<lastIndex].forEach({
                    debug("box: \($0.pos) filled")
                    $0.state = .filled
                })
                boxes[lastIndex-lastNumber.value].state = .empty
                debug("box: \(boxes[lastIndex-lastNumber.value].pos) empty")
                lastNumber.fullfilled = true
                changed = true
            }
            
    
            debug("ruleMultipleNumbers - check first filled if can be raised")
            
            
            let lastEmptyBoxFromFirstIndex = boxes[0..<firstIndex].lastIndex(where: { $0.state == .empty }) ?? 0
            debug("ruleMultipleNumbers - LastEmptyFromFirstPos: \(lastEmptyBoxFromFirstIndex+1)")
            
            
//            if firstNumber.value == 1, firstIndex == 1,  !firstNumber.fullfilled {
//                debug("ruleMultipleNumbers - first number already done")
//                firstNumber.fullfilled = true
//                boxes[0..<firstIndex].forEach { box in
//                    debug("box \(box.pos) empty")
//                    box.state = .empty
//                }
//
//                boxes[firstNumber.value].state = .empty
//                changed = true
//            }
            
            
            if firstIndex+1 <= firstNumber.value {
                debug("ruleMultipleNumbers - first filled is smaller than first number")
                boxes[firstIndex..<firstNumber.value].forEach { box in
                    if box.state != .filled {
                        debug("box \(box.pos) filled")
                        box.state = .filled
                        changed = true
                    }
                }
                
                if boxes[firstIndex..<firstNumber.value].filter({ $0.state == .filled }).count == firstNumber.value {
                    debug("FirstNumber \(firstNumber.fullfilled) fillfilled")
                    firstNumber.fullfilled = true
                    
                    boxes[0..<firstIndex].forEach { box in
                        debug("box \(box.pos) empty")
                        box.state = .empty
                    }
    
                    boxes[firstNumber.value].state = .empty
                }

            } else {
                debug("ruleMultipleNumbers - not raised")
            }
            
            
        } else {
            debug("ruleMultipleNumbers - no filled boxes")
        }
        
        
        
        return changed
    }
    
    private func ruleCheckDone(config: Config, boxes: [Box]) -> Bool {
        debug("ruleCheckDone")
        
        var changed = false
        if boxes.filter({ $0.state == .filled }).count == config.numbersSize {
            debug("ruleCheckDone - all filled -> fill emptys")
            for box in boxes.filter({$0.state == .unknown}) {
                box.state = .empty
            }
            config.numbers.forEach { $0.fullfilled = true }
            changed = true
        }
        
        if boxes.filter({ $0.state != .empty }).count == config.numbersSize {
            debug("ruleCheckDone - all filled -> fill emptys")
            for box in boxes.filter({$0.state == .unknown}) {
                box.state = .filled
            }
            config.numbers.forEach { $0.fullfilled = true }
            changed = true
        }
        
        return changed
    }
   
    
    func solveViaConf() {
        var changed = false
        
        repeat {
            changed = false
            for i in 0..<configs.count {
                var config = configs[i]
                
                debug("check: \(i) -> \(config.description)")

                guard !config.fullfilled else {
                    debug("already done")
                    continue
                }
                
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
                                
                guard !ruleFillAll(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleFillAll -> changed and continue")
                    changed = true
                    continue
                }
                
                guard !ruleMultipleNumbersFillAll(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleMultipleNumbersFillAll -> changed and continue")
                    changed = true
                    continue
                }
                
                guard !ruleCheckDone(config: config, boxes: configBoxes) else {
                    debug("ruleCheckDone -> changed and continue")
                    changed = true
                    continue
                }
                
                guard !ruleOneNumber(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleOneNumber -> changed and continue")
                    changed = true
                    continue
                }
                
                guard !ruleMultipleNumbers(config: config, size: sizeForRule, boxes: configBoxes) else {
                    debug("ruleMultipleNumbers -> changed and continue")
                    changed = true
                    continue
                }

            }
            
            printBoard()
        } while(boxes.contains(where: { $0.state == .unknown }) && changed)
    }
    
    func fillHorizontalMiddles(withNumber number: Number, y: Int, from: Int, to: Int, checkIfDone: Bool) -> Bool {
        var changed = false
        
        var outers = to - (from-1) - number.value
        var lower = from + outers
        var upper = to - outers
        
        if lower <= upper {
            for j in lower...upper {
                if var box = boxes.first(where: { $0.pos == (x: j, y: y)  && $0.state == .unknown }) {
                    box.state = .filled
                    changed = true
                }
            }
        } else {
            debug("no middles to fill")
        }
        
        if checkIfDone {
            debug("check if done")
            var configBoxes = boxes.filter { $0.pos.y == y }
            if configBoxes.filter({ $0.state == .filled }).count == number.value {
                debug("done - fill white")
                configBoxes.filter({$0.state == .unknown}).forEach {
                    $0.state = .empty
                }
                number.fullfilled = true
                return true
            }
        }
        
        debug("not done ... probably need to fill gaps")
        
        return changed
    }
    
    func fillVerticalMiddles(withNumber number: Number, x: Int, from: Int, to: Int, checkIfDone: Bool) -> Bool {
        var changed = false
        
        debug("Num: \(number.value) - From: \(from) - To: \(to)")
        
        var outers = to - (from-1) - number.value
        var lower = from + outers
        var upper = to - outers
        
        debug("Outers: \(outers) - Low: \(lower) - Up: \(upper)")
        if lower <= upper {
            for j in lower...upper {
                if var box = boxes.first(where: { $0.pos == (x: x, y: j)  && $0.state == .unknown }) {
                    box.state = .filled
                    changed = true
                }
            }
        } else {
            debug("no middles to fill")
        }
        
        // currently only for one number in conf
        if checkIfDone {
            debug("check if done")
            var configBoxes = boxes.filter { $0.pos.x == x }
            if configBoxes.filter({ $0.state == .filled }).count == number.value {
                debug("done - fill white")
                configBoxes.filter({$0.state == .unknown}).forEach {
                    $0.state = .empty
                }
                number.fullfilled = true
                return true
            }
        }
        debug("not done ... probably need to fill gaps")
        
        return changed
    }
    
    func solveViaBox() {
        var changed = false
        
        repeat {
            
            for box in boxes.filter({ $0.state == .unknown }) {
//                debug("Box pos: \(box.pos)")
                
                let leftConfig = configs.first(where: { $0.pos == (x: 0, y: box.pos.y) })!
                let topConfig = configs.first(where: { $0.pos == (x: box.pos.x, y: 0) })!
                
//                box.state = .filled
//
//                                
//                if neighbors(of: box).contains(where: { $0.state == .filled }) {
//                    box.state = .empty
//                    continue
//                }
            }
        } while(boxes.contains(where: { $0.state == .unknown }) && changed )
    }
    
    
    
    func neighbors(of box: Box) -> [Box] {
        var neighbors: [Box] = []
        
        if let topBox = boxes.first(where: { $0.pos == (x: box.pos.x, y: box.pos.y-1) }) {
            neighbors.append(topBox)
        }
        
        if let rightBox = boxes.first(where: { $0.pos == (x: box.pos.x+1, y: box.pos.y) }) {
            neighbors.append(rightBox)
        }
        
        if let bottomBox = boxes.first(where: { $0.pos == (x: box.pos.x, y: box.pos.y+1) }) {
            neighbors.append(bottomBox)
        }
        
        if let leftBox = boxes.first(where: { $0.pos == (x: box.pos.x-1, y: box.pos.y) }) {
            neighbors.append(leftBox)
        }
        
        return neighbors
    }
    
    func printWhites() -> [String] {
        
        var output = [String]()
        
        for config in configs {
//            debug("Conf: \(config.description)")
            if config.pos.y == 0 {
                
//                if let number = config.numbers.first, config.numbers.count == 1 {
//                    output.append("\(height - number.value)")
//                    continue
//                }
                
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
                
//                if let number = config.numbers.first, config.numbers.count == 1 {
//                    output.append("\(width - number.value)")
//                    continue
//                }
                
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
//grid.printBoard()
//grid.solveViaBox()
//grid.printBoard()

var finalOutput = grid.printWhites()

finalOutput.forEach {
    print($0)
}
//
//if width > 0 {
//    for i in 0...(width-1) {
//
//        // Write an answer using print("message...")
//        // To debug: print("Debug messages...", to: &errStream)
//
//        let output = ""
//        finalOutput.append(output)
//        print(output)
//        
//    }
//}

print(exepcted == finalOutput)



