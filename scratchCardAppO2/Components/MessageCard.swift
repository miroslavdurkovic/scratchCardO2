//
//  MessageCard.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct MessageCard: View {
    let text: String
    var isLoading: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)

            if isLoading {
                ProgressView()
                    .padding(.vertical, 8)
            }
        }
        .padding()
        .frame(maxWidth: 320, minHeight: 180)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    ZStack {
        Image("Background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        VStack(spacing: 20) {
            MessageCard(text: "Your card was wiped.\nYour code is: ABC123")
            MessageCard(text: "Activating card...", isLoading: true)
        }
        .padding()
    }
}
