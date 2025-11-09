//
//  ActivateCardViewViewModel.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

@MainActor
final class ActivateCardViewModel: ObservableObject {
    // Published
    @Published var message: String = ""
    @Published var buttonTitle: String = "Activate"
    @Published var isButtonEnabled: Bool = true
    @Published var isLoading: Bool = false
    @Published var navTitle: String = "Activate"

    // Dependency
    private let manager: ScratchCardManager

    init(manager: ScratchCardManager) {
        self.manager = manager
        configureFromStatus()
    }

    // Initial state texts
    private func configureFromStatus() {
        switch manager.scratchCard.status {
        case .new:
            message = "Your card wasn't wiped till now, please do it from main screen"
            buttonTitle = "Activate"
            isButtonEnabled = false
            isLoading = false

        case .active:
            message = "Your card was activated"
            buttonTitle = "Activated"
            isButtonEnabled = false
            isLoading = false

        case .wiped:
            message = "You can activate card with button below"
            buttonTitle = "Activate"
            isButtonEnabled = true
            isLoading = false
        }
    }

    func onAppear() {
        configureFromStatus()
    }

    func activateTapped() {
        guard !isLoading, isButtonEnabled else { return }

        isButtonEnabled = false
        isLoading = true
        message = ""

        manager.activateCard { [weak self] status in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false

                if status == .wiped {
                    self.message = "You can activate card with button below"
                    self.buttonTitle = "Activate"
                    self.isButtonEnabled = true
                }
            }
        }
    }
}
