//
//  HandlingTimers.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 30/12/24.
//

import SwiftUI

struct HandlingTimers: View {
    //create a timer publisher
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    ///That does several things all at once:
    /*
    1- It asks the timer to fire every 1 second.
    2- It says the timer should run on the main thread.
    3- It says the timer should run on the common run loop, which is the one you’ll want to use most of the time. (Run loops let iOS handle running code while the user is actively doing something, such as scrolling in a list.)
    4- It connects the timer immediately, which means it will start counting time.
    5- It assigns the whole thing to the timer constant so that it stays alive.
     */
    
    /*Before we’re done, there’s one more important timer concept I want to show you: if you’re okay with your timer having a little float, you can specify some tolerance. This allows iOS to perform important energy optimization, because it can fire the timer at any point between its scheduled fire time and its scheduled fire time plus the tolerance you specify.
     
     In practice this means the system can perform timer coalescing: it can push back your timer just a little so that it fires at the same time as one or more other timers, which means it can keep the CPU idling more and save battery power.

     As an example, this adds half a second of tolerance to our timer:*/
    
    let timer2 = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    ///If you need to keep time strictly then leaving off the tolerance parameter will make your timer as accurate as possible, but please note that even without any tolerance the Timer class is still “best effort” – the system makes no guarantee it will execute precisely
    
    @State private var counter = 0
    
    
    var body: some View {
        
        ///Once the timer starts it will send change announcements that we can monitor in SwiftUI using a new modifier called onReceive(). This accepts a publisher as its first parameter and a function to run as its second, and it will make sure that function is called whenever the publisher sends its change notification.
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onReceive(timer) { time in
                print("The time is now \(time)")
            }
        ///That will print the time every second until the timer is finally stopped.
        ///
        
        /*Speaking of stopping the timer, it takes a little digging to stop the one we created. You see, the timer property we made is an autoconnected publisher, so we need to go to its upstream publisher to find the timer itself. From there we can connect to the timer publisher, and ask it to cancel itself. Honestly, if it weren’t for code completion this would be rather hard to find, but here’s how it looks in code:
         
         timer.upstream.connect().cancel()*/
        
        //For example, we could update our existing example so that it fires the timer only five times, like this:
        
        Text("Hello World, with stop timer after 5 seconds")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The timer 2 is now \(time)")
                }
                counter += 1
            }
    }
}

#Preview {
    HandlingTimers()
}
