//
//  PrimaryButtonStyle.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var isEnabled: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                ZStack {
                    if isEnabled {
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(configuration.isPressed ? 0.8 : 0.9),
                                Color.cyan.opacity(configuration.isPressed ? 0.7 : 0.8)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .overlay(.ultraThinMaterial.opacity(0.25))
                    } else {
                        Color.gray.opacity(0.4)
                    }

                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .foregroundStyle(.white)
            .shadow(color: .blue.opacity(isEnabled ? 0.4 : 0), radius: 8, y: 3)
            .opacity(isEnabled ? 1 : 0.5)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}
