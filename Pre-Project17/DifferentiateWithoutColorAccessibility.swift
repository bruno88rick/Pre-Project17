//
//  DifferentiateWithoutColorAccessibility.swift
//  Pre-Project17
//
//  Created by Bruno Oliveira on 30/12/24.
//

import SwiftUI

//You can test that in the simulator by going to the Settings app and choosing Accessibility > Display & Text Size > Differentiate Without Color.
//is helpful for the 1 in 12 men who have color blindness. When this setting is enabled, apps should try to make their UI clearer using shapes, icons, and textures rather than colors.

struct DifferentiateWithoutColorAccessibility: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

#Preview {
    DifferentiateWithoutColorAccessibility()
}
