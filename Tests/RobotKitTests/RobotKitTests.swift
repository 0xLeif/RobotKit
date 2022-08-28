import XCTest
@testable import RobotKit

final class RobotKitTests: XCTestCase {
    func testRobot() async throws {
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
    }
}
