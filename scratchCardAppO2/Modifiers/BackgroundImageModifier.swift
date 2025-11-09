//
//  BackgroundImageModifier.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    let imageName: String

    func body(content: Content) -> some View {
        content
            .background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}

extension View {
    func backgroundImage(_ name: String = "Background") -> some View {
        self.modifier(BackgroundImageModifier(imageName: name))
    }
}
