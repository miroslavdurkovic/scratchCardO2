//
//  MainView.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI
import Combine

// MARK: - SwiftUI View
struct MainView: View {
    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Padding.medium) {
                MessageCard(text: viewModel.codeText)

                Spacer()

                HStack(spacing: Constants.Padding.medium) {
                    NavigationLink(viewModel.wipeButtonTitle) {
                        WipeCardView(viewModel: WipeCardViewModel(manager: viewModel.scratchCardManager))
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    NavigationLink(viewModel.activateButtonTitle) {
                        ActivateCardView(viewModel: ActivateCardViewModel(manager: viewModel.scratchCardManager))
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .screenLayout(title: viewModel.navTitle)
        }
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(manager: ScratchCardManager()))
    }
}
