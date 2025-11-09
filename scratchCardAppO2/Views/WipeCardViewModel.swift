//
//  WipeCardViewModel.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI
import Combine

@MainActor
final class WipeCardViewModel: ObservableObject {
    // Published
    @Published var message: String = ""
    @Published var buttonTitle: String = "Wipe off"
    @Published var isButtonEnabled: Bool = true
    @Published var isLoading: Bool = false
    @Published var navTitle: String = "Wipe off"

    // Dependency
    private let manager: ScratchCardManager
    private var pendingTask: Task<Void, Never>?

    init(manager: ScratchCardManager) {
        self.manager = manager
        configureFromStatus()
    }

    // Initial state texts
    private func configureFromStatus() {
        switch manager.scratchCard.status {
        case .wiped:
            message = "Your card was wiped.\nYour code is: \n\(manager.scratchCard.code)"
            buttonTitle = "Wiped"
            isButtonEnabled = false
            isLoading = false

        case .active:
            message = "Your card was activated, no other actions are available"
            buttonTitle = "Activated"
            isButtonEnabled = false
            isLoading = false

        default:
            message = "You can wipe off card with button below"
            buttonTitle = "Wipe off"
            isButtonEnabled = true
            isLoading = false
        }

        isLoading = false
    }

    func wipeTapped() {
        guard isButtonEnabled, !isLoading else { return }

        isButtonEnabled = false
        isLoading = true
        message = ""

        pendingTask?.cancel()

        pendingTask = Task { [weak self] in
            guard let self else { return }
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                try Task.checkCancellation()

                manager.wipeOff()

                await MainActor.run {
                    self.isLoading = false
                }
                self.isLoading = false

            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    func cancelPendingWork() {
        pendingTask?.cancel()
        pendingTask = nil
        isButtonEnabled = true
        isLoading = false
    }
}
