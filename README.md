# RobotKit

*Tell your Mac what to do*

## What is RobotKit?

`Robot` uses CoreGraphics to generate native mouse and keyboard input. It can also get information about the screen like the bounds, center, or even generating an image. `Robot` also can use `Vision` to read text for an image.

## Robot Actions

- Mouse: Robot control of the mouse
    - move: Move the mouse to the display and point
    - leftClick: Click the left mouse button
    - rightClick: Click the right mouse button
- Keyboard: Robot control of the keyboard
    - type: Type one or many Keys
    - typeShifted: Type one or many Keys while holding shift
    - press: Press a key down until you call `release`
    - release: Release the key from being pressed
- Screen: Robot information of the screen
    - bounds: Get the bounds of the display
    - center: Get the center point of the bounds of the display
    - image: Create an image of the display for a certain CGRect
- Vision: Robot information using [Vision](https://developer.apple.com/documentation/vision)
    - text: Use [Vision](https://developer.apple.com/documentation/vision) to request the text in the provided image

## Basic Usage

```swift
import RobotKit

let robot = Robot.default

// or

await Robot.task { robot in 
    // ...
}
```

## Robot Example

```swift
try await Robot.task { robot in
    // Find the center of the screen
    let mainScreenCenter: CGPoint = await robot.screen.center()
    
    // Move to the center of the screen and click the left mouse button
    await robot.mouse.move(to: mainScreenCenter)
    
    await robot.mouse.leftClick()
    
    // Type the expected output
    await robot.keyboard.task { keyboard in
        keyboard.type(.slash, .slash)
        
        keyboard.type(.Space)
        
        keyboard.press(.Shift)
        keyboard.press(.h)
        keyboard.release(.h)
        keyboard.release(.Shift)
        
        keyboard.type(.e, .l, .l, .o)
        
        keyboard.type(.Space)
        
        keyboard.press(.Shift)
        keyboard.press(.w)
        keyboard.release(.w)
        keyboard.release(.Shift)
        
        keyboard.type(.o)
        keyboard.type(.r)
        keyboard.type(.l)
        keyboard.type(.d)
        keyboard.typeShifted(._1)
    }
    
    // Create a CGImage from the screen's bounds
    let image = await robot.screen.image(rect: robot.screen.bounds())!
    
    // Get text observations from the image
    let imageTextObservations = try await robot.vision.text(in: image)
    
    // The Robot should have typed the expected output and the image we created should contain it.
    XCTAssert(
        imageTextObservations.contains { observation in
            observation.topCandidates(10).contains { text in
                text.string.contains("// Hello World!")
            }
        }
    )
    
    await robot.mouse.rightClick()
}
```
