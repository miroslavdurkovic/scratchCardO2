//
//  MainViewViewModel.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI
import Combine

// MARK: - ViewModel
final class MainViewModel: ObservableObject {
    // Published
    @Published var navTitle: String = ""
    @Published var codeText: String = ""

    // Static texts
    let wipeButtonTitle = "Wipe off"
    let activateButtonTitle = "Activate"

    // Dependencies
    let scratchCardManager: ScratchCardManager

    private var bag = Set<AnyCancellable>()

    init(manager: ScratchCardManager) {
        self.scratchCardManager = manager
        bind()
    }

    private func bind() {
        scratchCardManager.$scratchCard
            .receive(on: RunLoop.main)
            .sink { [weak self] card in
                self?.navTitle = card.statusText
                self?.codeText = card.code.isEmpty ? "" : "Your code is:\n\(card.code)"
            }
            .store(in: &bag)
    }
}
