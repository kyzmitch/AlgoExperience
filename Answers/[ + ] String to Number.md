## Questions to ask
* what if overflows Integer?
* what if contains not only digits like "123sometext?" "123 some text"?
* should we truncate leading spaces?
* what to return if overflows Int?

# Solution
* Clean and validate the input
* run on valid characters array


## Converting valid characters sequence to Int 

Characters array must be only with valid 0-9 characters and instead of sign should be `negative` provided

```swift
    func charactersToNumber(_ characters: [Character], negative: Bool) -> Int {
        var multiplier = 1
        var value = 0
        guard let firstNonZero = characters.index(where: { $0 != "0" }) else { return  0 }
        let characters = characters[firstNonZero...]
        
        for char in characters.reversed() {
            guard let digit = char.digit() else { continue }
            let addition = multiplier * digit   
            let capacity = Int.max - value
            // check on overflow capacity or next multiplier
            guard addition < capacity, multiplier <= Int.max / 10 else {
                return negative ? Int.min : Int.max
            }
            value += addition
            multiplier *= 10
        }
        
        value *= negative ? -1 : 1
        return value
    }
```


## Cleaning input and use

Be wery carefull with cleaning

```swift
func myAtoi(_ str: String) -> Int {
        
        // Remove leading spaces and get first substring, truncating the rest
        guard let firstSubstring = str.split(separator: " ").first else { return 0 }
        
        var characters = [Character]()
        for char in firstSubstring {
            guard char.isDigitOrSign() else { break } // exit on first illegal char
            characters.append(char)
        }
        
        // check if the first symbol is a sign and change multiplier if it's "-"
        var negative = false
        if let first = characters.first, let sign = first.sign() {
            negative = sign == -1
            characters.removeFirst()
        }
        
        // if sequence not empty and first is digit
        guard let first = characters.first, first.isDigit() else { return 0 }
        return charactersToNumber(characters, negative: negative)
    }
```


### Helping functions
```swift
    static let digits: [Character: Int] = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9]
    static let signs: = ["-": -1 ,"+": 1]
    
private extension Character {
    
    func isDigit() -> Bool {
        return digits[self] != nil
    }
    func isSign() -> Bool {
        return signs[self] != nil
    }
    func isDigitOrSign() -> Bool {
        return isDigit() || isSign()
    }
    func digit() -> Int? {
        return digits[self]
    }
    func sign() -> Int? {
        return signs[self]
    }
}

```

