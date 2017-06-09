/*:
 # Largest exponential
 [Problem 99](https://projecteuler.net/problem=99) - Difficulty level: 10%

 Comparing two numbers written in index form like 2¹¹ and 3⁷ is not difficult, as any calculator would confirm that 2¹¹ = 2048 < 3⁷ = 2187.
 
 However, confirming that 632382⁵¹⁸⁰⁶¹ > 519432⁵²⁵⁸⁰⁶ would be much more difficult, as both numbers contain over three million digits.
 
 Using base_exp.txt, a 22K text file containing one thousand lines with a base/exponent pair on each line, determine which line number has the greatest numerical value.
 
 NOTE: The first two lines in the file represent the numbers in the example given above.
 
 *NOTE: The contents of base_exp.txt are available in `var numbers: [Number]`. Number is a struct that contains the base and exponent of a number.*
 */
//#-hidden-code
/// A struct that contains each of the parts of a full Number.
struct Number {
  /// The base of the number.
  var base: Int
  /// The exponent of the number.
  var exponent: Int
}

/// The numbers parsed from base_exp.txt.
let numbers: [Number] = {
  var numbers: [Number] = []
  let contents = parseTextFile(named: "base_exp").components(separatedBy: .newlines)
  for line in contents {
    let lineContents = line.components(separatedBy: ",")
    let number = Number(
      base: Int(lineContents[0])!,
      exponent: Int(lineContents[1])!)
    numbers.append(number)
  }
  return numbers
}()
//#-end-hidden-code
