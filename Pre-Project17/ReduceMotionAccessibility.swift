//
//  ReduceMotionAccessibility.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 30/12/24.
//

import SwiftUI

//other way to apply or not the animation based on the Reduce Motion Accessibility enabled or not
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body:() throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

//is available in the simulator under Accessibility > Motion > Reduce Motion
//When this is enabled, apps should limit the amount of animation that causes movement on screen. For example, the iOS app switcher makes views fade in and out rather than scale up and down.

//With SwiftUI, this means we should restrict the use of withAnimation() when it involves movement, like this:

struct ReduceMotionAccessibility: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello World") {
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
        }
        .scaleEffect(scale)
        
        //other way using the UIKit func:
        Button("Hello World with UIKit Func!") {
            withOptionalAnimation {
                scale *= 1.5
            }
        }
        .scaleEffect(scale)
        ///Using this approach you don’t need to repeat your animation code every time.
    }
    
    //I don’t know about you, but I find that rather annoying to use. Fortunately we can add a little wrapper function around withAnimation() that uses UIKit’s UIAccessibility data directly, allowing us to bypass animation automatically. See the func above.
    
}

#Preview {
    ReduceMotionAccessibility()
}
