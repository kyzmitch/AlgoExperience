
## To know
* `0` is most bottom view, so you should enumerate reversed
* You should not forget to convert the point
* Not check hidden views, with alpha < 0.01 and where user interaction is disabled
* event handling lays on overrides shoulders

### Function signatures
```swift
func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

func point(inside point: CGPoint, with event: UIEvent?) -> Bool
      
func convert(_ point: CGPoint, from view: UIView?) -> CGPoint
```

# Solution

```swift
func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard self.isValidEventReceiver, self.point(inside: point, with: event) else { return nil }
    
    for subview in subviews.reversed() where subview.isValidEventReceiver {
        let convertedPoint = subview.convert(point, from: self)
        if let hittedView = subview.hitTest(convertedPoint, with: event) {
            return hittedView
        }        
    }
    
    return self
}

private extension UIView {
    var isValidEventReceiver: Bool {
        return !isHidden && alpha > 0.01 && isUserInteractionEnabled
    }
}
```