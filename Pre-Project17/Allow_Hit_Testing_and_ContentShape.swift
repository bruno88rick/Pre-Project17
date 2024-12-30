//
//  Allow_Hit_Testing_and_ContentShape.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 27/12/24.
//

import SwiftUI

struct Allow_Hit_Testing_and_ContentShape: View {
    var body: some View {
        
        ///SwiftUI has an advanced hit testing algorithm that uses both the frame of a view and often also its contents. For example, if you add a tap gesture to a text view then all parts of the text view are tappable – you can’t tap through the text if you happen to press exactly where a space is. On the other hand, if you attach the same gesture to a circle then SwiftUI will ignore the transparent parts of the circle.
        ///
        
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("Rectangle Tapped")
                }
            
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("Circle Tapped")
                }
        }
        .padding()
        
        
        ///SwiftUI lets us control user interactivity in two useful ways, the first of which is the allowsHitTesting() modifier. When this is attached to a view with its parameter set to false, the view isn’t even considered tappable. That doesn’t mean it’s inert, though, just that it doesn’t catch any taps – things behind the view will get tapped instead.
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("Rectangle Tapped")
                }
            
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("Circle Tapped")
                }
                .allowsHitTesting(false)
        }
        ///Now tapping the circle will always print “Rectangle tapped!”, because the circle will refuses to respond to taps.
        
        ///The other useful way of controlling user interactivity is with the contentShape() modifier, which lets us specify the tappable shape for something. By default the tappable shape for a circle is a circle of the same size, but you can specify a different shape instead like this:
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    print("Rectangle Tapped")
                }
            
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle Tapped")
                }
        }
        
        ///Where the contentShape() modifier really becomes useful is when you tap actions attached to stacks with spacers, because by default SwiftUI won’t trigger actions when a stack spacer is tapped. Here’s an example you can try out:
        VStack {
            Text("Hello")
            Spacer()
                .frame(height: 100)
            Text("world!")
        }
        .padding()
        .onTapGesture {
            print("VStack Tapped!")
        }
        ///If you run that you’ll find you can tap the “Hello” label and the “World” label, but not the space in between.
        
        
        ///However, if we use contentShape(.rect) on the VStack then the whole area for the stack becomes tappable, including the spacer:
        VStack {
            Text("Hello")
            Spacer()
                .frame(height: 100)
            Text("world!")
        }
        .padding()
        .contentShape(.rect)
        .onTapGesture {
            print("VStack Tapped!")
        }
        
    }
    
    
}

#Preview {
    Allow_Hit_Testing_and_ContentShape()
}
