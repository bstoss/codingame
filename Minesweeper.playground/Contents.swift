/// https://www.codingame.com/ide/puzzle/minesweeper-1
/// will not run by default cause there is no realy input data
/// so just a copy of the code in the game to have a backup

import Foundation

var input = ["16",
             "9",
             "................",
             "................",
             "................",
             "................",
             "................",
             "....x...........",
             "................",
             "................",
             "................"]

func readLine() -> String? {
    return input.removeFirst()
}

// code begins here


func randomItem<T>(fromArray a: Array<T>) -> T {
    var rng = SystemRandomNumberGenerator()
    let randomInt = Int.random(in: 0..<a.count, using: &rng)
    return a[randomInt]
}

typealias Position = (Int, Int)
typealias Row = [Int: Tile]
typealias Grid = [Int: Row]

enum CellValue: Equatable {
    case unknown
    case empty
    case borderMine(Int)
    case bomb

     static func ==(lhs: CellValue, rhs: CellValue) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
            (.empty, .empty),
            (.bomb, .bomb):
            return true
        case (let .borderMine(lhnum), let .borderMine(rhnum)):
            return lhnum == rhnum
        default:
            return false
        }
    }
}

class Tile {
    var position: Position
    var value: CellValue
    var tileBlockDone = false

    lazy var surroundingPos: [Position] = {
        return [(position.0-1,position.1-1), (position.0-1,position.1), (position.0-1,position.1+1),
                (position.0, position.1-1), (position.0, position.1+1),
                (position.0+1,position.1-1), (position.0+1,position.1), (position.0+1,position.1+1)]
    }()

    var printedPos: String {
        return "\(position.0) \(position.1)"
    }
   
    init(atPosition pos: Position) {
        self.position = pos
        self.value = .unknown
    }

    // check if can set flags if this tile is a number field
    func setFlagsIfPossible(inGrid g: Grid) -> String? {
        var flags = ""
        if case CellValue.borderMine(let num) = value {

            let sTiles: [Tile] = surroundingPos.compactMap({ pos in
                guard let tile = g[pos.1]?[pos.0],
                tile.value == .unknown ||
                tile.value == .bomb else {
                    return nil
                }
                return tile
            })

            let bombs = sTiles.filter({$0.value == .bomb})
            let unknows = sTiles.filter({$0.value != .bomb})

            // if unrevealed tiles are less than already spottet bombs
            // the rest must me bombs ... so we flag them
            if unknows.count <= num-bombs.count {
                for tile in unknows {
                    tile.value = .bomb
                }

                flags = sTiles.flatMap({ $0.printedPos }).joined(separator: " ")
            }

        }
        
        // mark tile as done if no surrounding tile is unknown, for later filtering a bit easier
        checkIfDone(inGrid: g)
        return flags.isEmpty ? nil : flags
    }

    // check of surrounding tiles are really no bomb
    func hasSaveMove(inGrid g: Grid) -> Position? {

        let sTiles: [Tile] = surroundingPos.compactMap({ pos in
             guard let tile = g[pos.1]?[pos.0],
                case .borderMine(_) = tile.value else {
                return nil
            }
            return tile
         })

         for tile in sTiles {
            if case CellValue.borderMine(let num) = tile.value {
            let ssTilesWithBomb: [Tile] = tile.surroundingPos.compactMap({ pos in
                guard let tile = g[pos.1]?[pos.0],
                tile.value == .bomb else {
                    return nil
                }
                return tile
            })
            // if the number value is same as amount of detected bombs, its save here !!!
            if ssTilesWithBomb.count == num {
                return position
            }
         }
        }

        return nil
    }

    func checkIfDone(inGrid g: Grid) {

         let sTiles: [Tile] = surroundingPos.compactMap({ pos in
             guard let tile = g[pos.1]?[pos.0],
                 tile.value == .unknown else {
                return nil
            }
            return tile
         })
        // no unknown surrounding bomb?, tile is done !!!
        tileBlockDone = sTiles.isEmpty
    }

    func bombHitPossibility(inGrid g: Grid) -> Float? {
        if case CellValue.borderMine(let num) = value {

            let sTiles: [Tile] = surroundingPos.compactMap({ pos in
                guard let tile = g[pos.1]?[pos.0],
                    tile.value == .unknown ||
                    tile.value == .bomb else {
                    return nil
                }
                return tile
            })
            
            let bombsCount: Float =  Float(sTiles.filter({$0.value == .bomb}).count)
            let unknowsCount: Float =  Float(sTiles.filter({$0.value != .bomb}).count)
            let floatNum = Float(num)
            let ratio = Float((floatNum-bombsCount) / unknowsCount)
            //print("BOMBS RATIO POS \(printedPos) - Number: \(num) Bombs: \(bombsCount) Unknows: \(unknowsCount) Ratio: \(ratio)", to: &errStream)
            
            if floatNum-bombsCount > 0 {
                return ratio
            } else {
                return Float(unknowsCount)
            }
        }

        return nil
    }

    func unknownTiles(inGrid g: Grid) -> [Tile] {
        return surroundingPos.compactMap({ pos in
            guard let tile = g[pos.1]?[pos.0],
                tile.value == .unknown else {
                return nil
            }
            return tile
        })
    }
}


struct Board {
    // need 2 dimensions because of faster access
    var g: Grid

    init() {
        g = [:]
        for i in 0...15 {
            var row: Row = [:]
            for j in 0...29 {
                row[j] = Tile(atPosition: (j,i))
            }
            g[i] = row
        }
    }

    func setNewValue(forTileAtPosition p: Position, value: String) {
        let newCellValue = cellValue(forString: value)
        let tile = g[p.1]![p.0]!
        if tile.value != .bomb {
            tile.value = newCellValue
        }
    }

    func flagTiles() -> String {
        let tileRows: [Row] = g.flatMap({ $0.value })
        let tiles: [Tile] = tileRows.flatMap({ $0.values })

        let numTiles: [Tile] = tiles.filter({ tile in
            guard case .borderMine(_) = tile.value,
                !tile.tileBlockDone else {
                return false
            }
            return true
        })
        var flags = ""
        // check every tile that is a number if can set some flags
        for tile in numTiles {
            if let newFlags = tile.setFlagsIfPossible(inGrid: g) {
                flags += " \(newFlags)"
            }
        }
        return flags
    }

    func outputForNextTile(isFirst first: Bool) -> String {

        guard !first else {
            return "20 7"
        }

        let tileRows: [Row] = g.flatMap({ $0.value })
        let tiles: [Tile] = tileRows.flatMap({ $0.values })

        let unknownTiles = tiles.filter { $0.value == .unknown }
        for tile in unknownTiles {
            if let move = tile.hasSaveMove(inGrid: g) {
                return "\(move.0) \(move.1)"
            }
        }

        // no save tile to hit ...
        // find the most possible "KNOWN" tile with less bomb possibility
                
        let tilesToCheck: [Tile] = tiles.filter({ tile in
            guard case .borderMine(_) = tile.value,
                !tile.tileBlockDone else {
                return false
            }

            return true
        })
        if tilesToCheck.count > 0 {
            // all number tiles can check the best possibility to not hit a bomb

            var lowestBombHit: Float = 1000
            var lowestBombsOnTile: Tile!
            for tile in tilesToCheck {
                if let hitPos = tile.bombHitPossibility(inGrid: g),
                    hitPos < lowestBombHit {
                    lowestBombHit = hitPos
                    lowestBombsOnTile = tile
                }
            }

            let unkTiles = lowestBombsOnTile.unknownTiles(inGrid: g)
            return randomItem(fromArray: unkTiles).printedPos
        } else {
            let tile = randomItem(fromArray: unknownTiles.filter({ $0.value == .unknown}))
            return "\(tile.printedPos)"
        }
    }


    private  func cellValue(forString s: String) -> CellValue {
        if s == "." {
            return .empty
        }

        if s == "?" {
            return .unknown
        }

        if let num = Int(s) {
            return .borderMine(num)
        }

        return .bomb
    }
}

var board = Board()

// first move is always 20 7 ... it seems to be the 100% success move :)
var firstMoveDone = false

// game loop
while true {
    for i in 0...15 {
        var j = 0
        for cell in ((readLine()!).split(separator: " ").map(String.init)) {
            // update the state of every tile, except when its marked as bomb

            board.setNewValue(forTileAtPosition: (j, i), value: cell)
            
            j += 1
        }
    }

    let flags = board.flagTiles()
    let output = board.outputForNextTile(isFirst: !firstMoveDone)

    print("\(output)\(flags)")
    firstMoveDone = true
}
