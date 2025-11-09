//
//  ActivateCardView.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

struct ActivateCardView: View {
    @ObservedObject var viewModel: ActivateCardViewModel

    var body: some View {
        VStack(spacing: Constants.Padding.medium) {

            MessageCard(text: viewModel.message,
                        isLoading: viewModel.isLoading)

            Spacer()

            PrimaryButton(
                title: viewModel.buttonTitle,
                isEnabled: viewModel.isButtonEnabled
            ) {
                viewModel.activateTapped()
            }
        }
        .screenLayout(title: viewModel.navTitle)
        .onAppear { viewModel.onAppear() }
    }
}

// MARK: - Preview
struct ActivateCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivateCardView(viewModel: ActivateCardViewModel(manager: ScratchCardManager()))
    }
}
