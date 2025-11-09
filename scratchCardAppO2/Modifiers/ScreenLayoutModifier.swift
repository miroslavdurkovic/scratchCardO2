//
//  ScreenLayoutModifier.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct ScreenLayoutModifier: ViewModifier {
    let title: String
    let alignment: Alignment
    let topPadding: CGFloat
    let horizontalPadding: CGFloat

    init(title: String, alignment: Alignment = .top, topPadding: CGFloat = Constants.Padding.medium, horizontalPadding: CGFloat = Constants.Padding.medium) {
        self.title = title
        self.alignment = alignment
        self.topPadding = topPadding
        self.horizontalPadding = horizontalPadding
    }

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .padding(.top, topPadding)
            .padding(.horizontal, horizontalPadding)
            .navigationTitle(title)
            .backgroundImage()
    }
}

extension View {
    func screenLayout(title: String, alignment: Alignment = .top, topPadding: CGFloat = Constants.Padding.medium, horizontalPadding: CGFloat = Constants.Padding.medium) -> some View {
        self.modifier(
            ScreenLayoutModifier(
                title: title,
                alignment: alignment,
                topPadding: topPadding,
                horizontalPadding: horizontalPadding
            )
        )
    }
}
