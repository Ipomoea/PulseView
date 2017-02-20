# PulseView

View with pulsed animating circles

![alt tag](http://i.imgur.com/aXHPAr5.gif)

Installation
--------------
Download file and move it to your project directory

Properties
--------------

The PulseView class has the following properties:
```swift
var colors: [UIColor]
```
An array of colors to paint circles.
```swift
var animationTime: TimeInterval
```
Default is 0.3.
```swift
var animationPause: TimeInterval
```
Time until start new circle.
```swift
private(set) var animating = false
```
Get animation state.

Methods
--------------

The PulseView class has the following methods:

```swift
func startAnimating()
```

```swift
func stopAnimating())
```

