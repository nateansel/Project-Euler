/*:
 # Square digit chains
 [Problem 96](https://projecteuler.net/problem=96) - Difficulty level: 25%

 Su Doku (Japanese meaning number place) is the name given to a popular puzzle concept. Its origin is unclear, but credit must be attributed to Leonhard Euler who invented a similar, and much more difficult, puzzle idea called Latin Squares. The objective of Su Doku puzzles, however, is to replace the blanks (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3 box contains each of the digits 1 to 9. Below is an example of a typical starting puzzle grid and its solution grid.
 
 ![](96-1.png)
 
 A well constructed Su Doku puzzle has a unique solution and can be solved by logic, although it may be necessary to employ "guess and test" methods in order to eliminate options (there is much contested opinion over this). The complexity of the search determines the difficulty of the puzzle; the example above is considered easy because it can be solved by straight forward direct deduction.
 
 The 6K text file, sudoku.txt, contains fifty different Su Doku puzzles ranging in difficulty, but all with unique solutions (the first puzzle in the file is the example above).
 
 By solving all fifty puzzles find the sum of the 3-digit numbers found in the top left corner of each solution grid; for example, 483 is the 3-digit number found in the top left corner of the solution grid above.
 
 *NOTE: The puzzles are stored in `var puzzles: [Puzzle]`. The definitions for the Puzzle and Box data types can be viewed by tapping their names and then 'Help'.
 
 The sudoku.txt file is parsed when the playground is run, and may take between 10-20 seconds to fully parse.*
 */
//#-hidden-code
/// A struct that contains a 3x3 square of numbers in a Su Doku puzzle. These numbers are stored as `Int?`. If a
/// particular space in the box is unfilled it will equal `nil` in this struct's data.
///
/// The values stored in this box are located in `var numbers: [[Int?]]`.
///
/// A box can easily be queried to see if it is solved by accessessing `var isSolved: Bool`. This value is calculated
/// each time you access it so it is always up to date.
struct Box {
  /// The values stored in this box.
  var numbers: [[Int?]] = []
  /// If this box is solved or not. This value is calculated on access.
  var isSolved: Bool {
    for row in numbers {
      for num in row {
        if num == nil {
          return false
        }
      }
    }
    return true
  }
  
  /// Returns a string representation of a row in this box. Used primarily in the Puzzle's `toString()` method.
  func string(forRow row: Int) -> String {
    return numbers[row].flatMap({ (num) -> String? in
      if let num = num {
        return "\(num)"
      }
      return "-"
    }).joined(separator: " ")
  }
}

/// A struct that contains a full 9x9 Su Doku puzzle. Each of the numbers are stored as `Int?`. If a particular space in
/// the puzzle is unfilled it will equal `nil` in this struct's data.
///
/// The values stored in this puzzle are located in `var boxes: [[Box]]`. Each box is a 3x3 square of the puzzle.
struct Puzzle {
  /// A 2D array of boxes
  var boxes: [[Box]] = []
  /// If this puzzle is solved or not. This value is calculated on access.
  var isSolved: Bool {
    for row in boxes {
      for box in row {
        if !box.isSolved {
          return false
        }
      }
    }
    return true
  }
  
  init(strings: [String]) {
    boxes = []
    var rows: [[Int?]] = []
    for string in strings {
      var row: [Int?] = []
      for char in string.characters {
        let num = Int(String(char))!
        row.append(num == 0 ? nil : num)
      }
      rows.append(row)
    }
    for i in stride(from: 0, to: 9, by: 3) { // rows
      var boxRow: [Box] = []
      for j in stride(from: 0, to: 9, by: 3) { // columns
        let row1: [Int?] = [rows[i][j], rows[i][j+1], rows[i][j+2]]
        let row2: [Int?] = [rows[i+1][j], rows[i+1][j+1], rows[i+1][j+2]]
        let row3: [Int?] = [rows[i+2][j], rows[i+2][j+1], rows[i+2][j+2]]
        let box = Box(numbers: [row1, row2, row3])
        boxRow.append(box)
      }
      boxes.append(boxRow)
    }
  }
  
  /// Returns a string representation of a su doku puzzle. Unanswered numbers are represented by dashes.
  func toString() -> String {
    var toReturn = " ----------------- \n"
    for i in 0..<3 {
      for j in 0..<3 {
        for k in 0..<3 {
          toReturn += "|\(boxes[i][k].string(forRow: j))"
        }
        toReturn += "|\n"
      }
      toReturn += " ----------------- \n"
    }
    return toReturn
  }
  
  func row(_ row: Int) -> [Int?] {
    return inNumbers()[row]
  }
  
  func column(_ column: Int) -> [Int?] {
    var toReturn: [Int?] = []
    for row in inNumbers() {
      toReturn.append(row[0])
    }
    return toReturn
  }
  
  func inNumbers() -> [[Int?]] {
    var numbers: [[Int?]] = []
    for row in boxes {
      numbers.append(contentsOf: transform(row))
    }
    return numbers
  }
  
  private func transform(_ row: [Box]) ->[[Int?]] {
    var rows: [[Int?]] = []
    for i in 0..<3 {
      var newRow: [Int?] = []
      for j in 0..<row.count {
        for k in 0..<3 {
          newRow.append(row[j].numbers[i][k])
        }
      }
      rows.append(newRow)
    }
    return rows
  }
}

var puzzles: [Puzzle] = {
  let contents = parseTextFile(named: "sudoku").components(separatedBy: .newlines)
  var puzzles: [Puzzle] = []
  
  let range = stride(from: 0, to: contents.count - 1, by: 10)
  for i in range {
    let newPuzzleLines = Array(contents[(i + 1)..<(i + 10)])
    let puzzle = Puzzle(strings: newPuzzleLines)
    puzzles.append(puzzle)
  }
  return puzzles
}()
//#-end-hidden-code
