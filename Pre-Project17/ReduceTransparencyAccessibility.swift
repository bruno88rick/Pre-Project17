//
//  ReduceTransparencyAccessibility.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 30/12/24.
//

import SwiftUI

//One last option you should consider supporting is Reduce Transparency, and when that’s enabled apps should reduce the amount of blur and translucency used in their designs to make doubly sure everything is clear.

//For example, this code uses a solid black background when Reduce Transparency is enabled, otherwise using 50% transparency:

struct ReduceTransparencyAccessibility: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    ReduceTransparencyAccessibility()
}
