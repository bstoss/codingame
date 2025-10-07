/// https://www.codingame.com/ide/puzzle/nonogram-inversor

import UIKit

var input = [
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

var expectedOutput = [
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

@MainActor
func readLine() -> String? {
    inputMusic.removeFirst()
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
                    
//                        let conf = configs.first(where: { $0.pos == (x: j, y: i) })!
//
//                        row += " \(conf.numbers.map { "\($0.value)" }.joined(separator: " ")) |"
                } else {
                    row += " \(boxes.first(where: { $0.pos == (x: j, y: i) })!.printedState) |"
                }
                    
                
            }
            
            debug(row)
            
        }
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
                
                // check horizontal configs
                if config.pos.x == 0 {
                    
                    var configBoxes = boxes.filter { $0.pos.y == config.pos.y }
                    
                    // number is full width
                    if var number = config.numbers.first(where: { $0.value == width }) {
                        debug("full width")
                        for j in 1...width {
                            var box = boxes.first(where: { $0.pos == (x: j, y: config.pos.y) })
                            box?.state = .filled
                        }
                        
                        number.fullfilled = true
                        changed = true
                        continue
                    }
                    
                    // one number, fill possible space, maybe function for bigger ones
                    if var number = config.numbers.first, config.numbers.count == 1 {
                        debug("one number")
                        // TODO: check for possible space.
                        // check if already contains a filled one
                        // Only fill middle in possible space
                        // mark impossible space as empty
                        
                        debug("check if can set emptys")
                        var filledBoxes = configBoxes.filter { $0.state == .filled }
                        var fbCount = filledBoxes.count
                        if fbCount > 0 && fbCount < number.value {
                            debug("found already filled. align on them")
                            // check what can be set as empty
                            var first = filledBoxes.first!
                            var last = filledBoxes.last!
                            
                            // 4 ... 2fb .. pos 6... alles bis 4 empty
                            
                            var emptyLeftRange = first.pos.x - (number.value-fbCount)
                            var emptyRightRange = last.pos.x + (number.value-fbCount)
                            
                            var unknownBoxes = configBoxes.filter { $0.state == .unknown }
                            
                            unknownBoxes.forEach { box in
                                if box.pos.x < emptyLeftRange {
                                    box.state = .empty
                                    changed = true
                                }
                                if box.pos.x > emptyRightRange {
                                    box.state = .empty
                                    changed = true
                                }
                            }
                            
                            if changed {
                                continue
                            }
                            
                            // check new middle range
                            
                            // fill all?
                            
                        } else {
                            debug("no filled box")
                        }
                        
                        debug("find possible space")
                        // TODO: find a way to reafactor ....
                        // something like rules ... 
                        
                        debug("one number. fill middle")
                        
                        
                        let didChange = fillHorizontalMiddles(
                            withNumber: number,
                            y: config.pos.y,
                            from: 1,
                            to: width,
                            checkIfDone: true
                        )
                        if didChange {
                            changed = true
                        }
                        
                    } else if config.numbersSizeWithGaps == width {
                        debug("numbers fill width")
                        var boxIndex = 0
                        var configBoxes = boxes.filter { $0.pos.y == config.pos.y }
                        
                        for number in config.numbers {
                            for j in 0..<number.value {
                                configBoxes[boxIndex].state = .filled
                                boxIndex += 1
                            }
                            if boxIndex < configBoxes.count {
                                configBoxes[boxIndex].state = .empty
                                boxIndex += 1
                            }
                        }
                        
                    } else {
                        
                        let countOfNumbers = config.numbers.count
                        debug("multiple horizontal numbers - \(countOfNumbers)")
                        
                        for ii in 0..<countOfNumbers {
                            // search for middles?
                            var number = config.numbers[ii]
                            
                            guard !number.fullfilled else {
                                continue
                            }
                            
                            debug("check middle for index: \(ii) - value: \(number.value)")
                            
                            var from = 1
                            if ii > 0 {
                                // add unfree space from numbers befor index
                                for j in 0..<ii {
                                    from += 1
                                    from += config.numbers[j].value
                                }
                            }
                            
                            var to = width
                            if ii+1 < countOfNumbers {
                                // add unfree space from numbers after index
                                for j in ii+1..<countOfNumbers {
                                    to -= 1
                                    to -= config.numbers[j].value
                                }
                            }
                            
                            debug("from: \(from), to: \(to)")
                            
                            let didChange = fillHorizontalMiddles(
                                withNumber: number,
                                y: config.pos.y,
                                from: from,
                                to: to,
                                checkIfDone: false
                            )
                            
                            if didChange {
                                changed = true
                            }
                            
                        }
                    }
                    
                    
                    let count = configBoxes.filter({ $0.state == .filled }).count
                    if count == config.numbersSize  {
                        debug("done horizontal- fill white")
                        configBoxes.filter({$0.state == .unknown}).forEach {
                            $0.state = .empty
                        }
                        config.numbers.forEach {  $0.fullfilled = true }
                        changed = true
                        
                    }else {
                        debug("not done. Current: \(count) - All: \(config.numbersSize)")
                    }
                    
                }
                // check vertical configs
                else if config.pos.y == 0 {
                    
                    var configBoxes = boxes.filter { $0.pos.x == config.pos.x }
                    
                    if var number = config.numbers.first(where: { $0.value == height }) {
                        debug("full height")
                        for j in 1...height {
                            var box = boxes.first(where: { $0.pos == (x: config.pos.x, y: j) })
                            box?.state = .filled
                        }
                        
                        number.fullfilled = true
                        changed = true
                        continue
                    } else if var number = config.numbers.first, config.numbers.count == 1 {
                        
                        debug("one number")
                        
                        var from = 1
                        var to = height
                        // TODO: check for possible space.
                        // check if already contains a filled one
                        // Only fill middle in possible space
                        // mark impossible space as empty
                        
                        debug("check if can set emptys")
                        var filledBoxes = configBoxes.filter { $0.state == .filled }
                        var fbCount = filledBoxes.count
                        if fbCount > 0 && fbCount < number.value {
                            
                            // check what can be set as empty
                            var first = filledBoxes.first!
                            var last = filledBoxes.last!
                            
                            // 4 ... 2fb .. pos 6... alles bis 4 empty
                            
                            var emptyUpperRange = first.pos.y - (number.value-fbCount)
                            var emptyLowerRange = last.pos.y + (number.value-fbCount)
                            
                            var unknownBoxes = configBoxes.filter { $0.state == .unknown }
                            
                            unknownBoxes.forEach { box in
                                if box.pos.y < emptyUpperRange {
                                    box.state = .empty
                                    changed = true
                                }
                                if box.pos.y > emptyLowerRange {
                                    box.state = .empty
                                    changed = true
                                }
                            }
                            
                            if changed {
                                continue
                            }
                            
                            from = max(emptyUpperRange+1, 1)
                            to = min(emptyLowerRange, height)
                            
                            // check new middle range
                            
                            // fill all?
                            
                        } else {
                            debug("no filled box")
                        }
                        
                        debug("find possible space")
                        
                        
                        debug("one number. fill middle")
                        let didChange = fillVerticalMiddles(
                            withNumber: number,
                            x: config.pos.x,
                            from: from,
                            to: to,
                            checkIfDone: true
                        )
                        if didChange {
                            changed = true
                        }
                        
                    } else if config.numbersSizeWithGaps == height {
                        debug("numbers fill height")
                        var boxIndex = 0
                        var configBoxes = boxes.filter { $0.pos.x == config.pos.x }
                        
                        for number in config.numbers {
                            for j in 0..<number.value {
                                configBoxes[boxIndex].state = .filled
                                boxIndex += 1
                            }
                            if boxIndex < configBoxes.count {
                                configBoxes[boxIndex].state = .empty
                                boxIndex += 1
                            }
                        }
                        
                    } else {
                        
                        
                        let countOfNumbers = config.numbers.count
                        debug("multiple vertical numbers - \(countOfNumbers)")
                        
                        for ii in 0..<countOfNumbers {
                            // search for middles?
                            var number = config.numbers[ii]
                            
                            guard !number.fullfilled else {
                                continue
                            }
                            
                            debug("check middle for index: \(ii) - value: \(number.value)")
                            
                            var from = 1
                            if ii > 0 {
                                // add unfree space from numbers befor index
                                for j in 0..<ii {
                                    from += 1
                                    from += config.numbers[j].value
                                }
                            }
                            
                            var to = height
                            if ii+1 < countOfNumbers {
                                // add unfree space from numbers after index
                                for j in ii+1..<countOfNumbers {
                                    to -= 1
                                    to -= config.numbers[j].value
                                }
                            }
                            
                            debug("from: \(from), to: \(to)")
                            
                            let didChange = fillVerticalMiddles(
                                withNumber: number,
                                x: config.pos.x,
                                from: from,
                                to: to,
                                checkIfDone: false
                            )
                            
                            if didChange {
                                changed = true
                            }
                            
                        }
                    }
                    
                    let count = configBoxes.filter({ $0.state == .filled }).count
                    if count == config.numbersSize  {
                        debug("done verticals - fill white")
                        configBoxes.filter({$0.state == .unknown}).forEach {
                            $0.state = .empty
                        }
                        config.numbers.forEach {  $0.fullfilled = true }
                        changed = true
                        
                    } else {
                        debug("verticals not done. Current: \(count) - All: \(config.numbersSize)")
                    }
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

print(expectedOutputMusic == finalOutput)



