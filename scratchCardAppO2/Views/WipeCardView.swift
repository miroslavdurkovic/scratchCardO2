//
//  WipeCardView.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct WipeCardView: View {
    @ObservedObject var viewModel: WipeCardViewModel

    var body: some View {
        VStack(spacing: Constants.Padding.medium) {
            MessageCard(text: viewModel.message,
                        isLoading: viewModel.isLoading)

            Spacer()

            PrimaryButton(
                title: viewModel.buttonTitle,
                isEnabled: viewModel.isButtonEnabled
            ) {
                viewModel.wipeTapped()
            }
        }
        .screenLayout(title: viewModel.navTitle)
        .onDisappear { viewModel.cancelPendingWork() }
    }
}

// MARK: - Preview
struct WipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        WipeCardView(viewModel: WipeCardViewModel(manager: ScratchCardManager()))
    }
}
