//
//  HandlingScenePhase.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 30/12/24.
//

import SwiftUI

/*You might wonder why it’s called scene phase as opposed to something to do with your current app state, but remember that on iPad the user can run multiple instances of your app at the same time – they can have multiple windows, known as scenes, each in a different state.
 
 To see the various scene phases in action, try this code:
 */


struct HandlingScenePhase: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
    
    /*As you can see, there are three scene phases we need to care about:
     
     Active scenes are running right now, which on iOS means they are visible to the user. On macOS an app’s window might be wholly hidden by another app’s window, but that’s okay – it’s still considered to be active.
     Inactive scenes are running and might be visible to the user, but the user isn’t able to access them. For example, if you’re swiping down to partially reveal the control center then the app underneath is considered inactive.
     Background scenes are not visible to the user, which on iOS means they might be terminated at some point in the future.*/
}

#Preview {
    HandlingScenePhase()
}
