//
//  PrimaryButton.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isEnabled: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(PrimaryButtonStyle(isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Activate") { print("Tapped") }
        PrimaryButton(title: "Disabled", isEnabled: false) { }
        NavigationLink("Navigate") {
            Text("Destination")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    .padding()
}
