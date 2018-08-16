Follow-up questions:
* 

## Straitforward version

```swift
extension Array where Element: Hashable {

    func distinct() -> Array {
        guard var previous = self.first else { return self }
        var result = [previous]
        for element in self where element != previous {            
            result.append(element)
        }
        return result        
    }

}
```



### Inplace-ish
```swift
    mutating func distinct() {
        guard count > 0 else { return }
        var last = 0
        var previous: Element?
        for element in self  where element != previous {
            self[last] = element
            previous = element
            last += 1
        }
        self = Array(self[..<last])
    }
```

## What if unsorted?
There are two solution, one is sort first what gives us O(n log n) and second is O(n) + O(n) space
```swift
    mutating func distinct() {
        guard count > 0 else { return }
        var uniq = Set<Element>()
        var last = 0
        for element in self where !uniq.contains(element) {
            self[last] = element
            uniq.insert(element)
            last += 1
        }
        self = Array(self[..<last])
    }
```
