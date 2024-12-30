//
//  ContentView.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 27/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmountMagnification = 0.0
    @State private var finalAmountMagnification = 1.0
    
    @State private var currentAmountRotation = Angle.zero
    @State private var finalAmountRotation = Angle.zero
    
    // how far the circle has been dragged
    @State private var circleOffset = CGSize.zero
    
    // whether it is currently being dragged or not
    @State private var circleIsDragging = false
    
    var body: some View {
        VStack {
            Text("Double Tap")
                .padding()
                .onTapGesture(count: 2) {
                    print("Double Tapped!")
                }
            
            Text("Long Press Standard")
                .padding()
                .onLongPressGesture {
                    print("Long Press!")
                }
            
            ///Like tap gestures, long press gestures are also customizable. For example, you can specify a minimum duration for the press, so your action closure only triggers after a specific number of seconds have passed. For example, this will trigger only after two seconds
            Text("Long Press Minimum 2 seconds")
                .padding()
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long pressed!")
                }
            
            ///You can even add a second closure that triggers whenever the state of the gesture has changed. This will be given a single Boolean parameter as input, and it will work like this:
            
            ///1- As soon as you press down the change closure will be called with its parameter set to true.
            ///2- If you release before the gesture has been recognized (so, if you release after 1 second when using a 2-second recognizer), the change closure will be called with its parameter set to false.
            ///3-If you hold down for the full length of the recognizer, then the change closure will be called with its parameter set to false (because the gesture is no longer in flight), and your completion closure will be called too.
            
            Text("Long Press with closure (onPressingChanged)")
                .padding()
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long Pressed!")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)")
                }
            
            ///For more advanced gestures you should use the gesture() modifier with one of the gesture structs: DragGesture, LongPressGesture, MagnifyGesture, RotateGesture, and TapGesture. These all have special modifiers, usually onEnded() and often onChanged() too, and you can use them to take action when the gestures are in-flight (for onChanged()) or completed (for onEnded()).
            ///
            
            Text("More Advanced Gestures: Magnification")
                .padding()
                .scaleEffect(finalAmountMagnification + currentAmountMagnification)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            print("Value Magnification before: \(value.magnification)")
                            currentAmountMagnification = value.magnification - 1
                            print("Value Magnification after: \(currentAmountMagnification)")
                        }
                        .onEnded { value in
                            print("On Ended Start magnifiction: \(value.magnification)")
                            finalAmountMagnification += currentAmountMagnification
                            print("On ended Final magnification: \(finalAmountMagnification)")
                            currentAmountMagnification = 0
                            print("On ended currentAmountMagnification back to 0: \(currentAmountMagnification)")
                        }
                )
            
            ///Exactly the same approach can be taken for rotating views using RotateGesture, except now we’re using the rotationEffect() modifier:
            
            Text("More Advanced Gestures: Rotate")
                .padding()
                .rotationEffect(currentAmountRotation + finalAmountRotation)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            print("Value Rotation before: \(value.rotation)")
                            currentAmountRotation = value.rotation
                            print("Value Rotation after: \(currentAmountRotation)")
                        }
                        .onEnded { value in
                            print("On Ended Start Rotation: \(value.rotation)")
                            finalAmountRotation += currentAmountRotation
                            print("On ended Final Rotation: \(finalAmountRotation)")
                            currentAmountRotation = .zero
                            print("On ended CurrentAmountRotation back to 0: \(currentAmountMagnification)")
                            
                        }
                )
            
            ///Where things start to get more interesting is when gestures clash – when you have two or more gestures that might be recognized at the same time, such as if you have one gesture attached to a view and the same gesture attached to its parent.
            
            VStack {
                Text("Gesture to View and its Parent (View Priority)")
                    .padding()
                    .onTapGesture {
                        print("Text View tapped!")
                    }
            }
            .onTapGesture {
                print("VStack parent tapped!")
            }
            
            ///In this situation SwiftUI will always give the child’s gesture priority, which means when you tap the text view above you’ll see “Text tapped”. However, if you want to change that you can use the highPriorityGesture() modifier to force the parent’s gesture to trigger instead, like this:
            
            VStack {
                Text("Gesture to View and its Parent (Priority Changed to Parent)")
                    .padding()
                    .onTapGesture {
                        print("Text View tapped!")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        print("VStack parent tapped!")
                    }
            )
            
            ///Alternatively, you can use the simultaneousGesture() modifier to tell SwiftUI you want both the parent and child gestures to trigger at the same time, like this:
            ///
            
            VStack {
                Text("Simultaneos parent and Child gesture trigger")
                    .padding()
                    .onTapGesture {
                        print("Text Tapped!")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded{
                        print("VStack parent tapped!")
                    }
            )
            
        }
        .padding()
        ///That will print both “Text tapped” and “VStack tapped”.
        ///
        
        
        ///Finally, SwiftUI lets us create gesture sequences, where one gesture will only become active if another gesture has first succeeded. This takes a little more thinking because the gestures need to be able to reference each other, so you can’t just attach them directly to a view.Here’s an example that shows gesture sequencing, where you can drag a circle around but only if you long press on it first:
        
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in
                circleOffset = value.translation
                print("Circle offset at start of On Changed Gesture: \(circleOffset)")

            }
            .onEnded { value in
                withAnimation {
                    //stay where the circle are on final gesture
                    circleOffset = value.translation
                    print("Circle Offset on end of On Ended Gesture: \(circleOffset)")
                    
                    //back to initial position
                    ///circleOffset = .zero
                    circleIsDragging = false
                }
            }
        
        //a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    circleIsDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combinedGesture = pressGesture.sequenced(before: dragGesture)
        
        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.green)
            .frame(width: 64, height: 64)
            .scaleEffect(circleIsDragging ? 1.5 : 1)
            .offset(circleOffset)
            .gesture(combinedGesture)
        
        
    }
}

#Preview {
    ContentView()
}
