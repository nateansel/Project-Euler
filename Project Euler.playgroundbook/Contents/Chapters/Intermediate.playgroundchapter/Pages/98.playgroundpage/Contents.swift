/*:
 # Anagramic squares
 [Problem 98](https://projecteuler.net/problem=98) - Difficulty level: 35%

 By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 36². What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number: 9216 = 96². We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted, neither may a different letter have the same digital value as another letter.
 
 Using words.txt, a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).
 
 What is the largest square number formed by any member of such a pair?
 
 NOTE: All anagrams formed must be contained in the given text file.
 
 *NOTE: The contents of words.txt are stored in `var words: [String]`. The contents of the text file are parsed when the playground is run, which can take between 5-10 seconds.*
 */
//#-hidden-code
var words: [String] = {
  var contents = parseTextFile(named: "42-2")
  contents = contents.replacingOccurrences(of: "\"", with: "")
  return contents.components(separatedBy: ",")
}()
//#-end-hidden-code
