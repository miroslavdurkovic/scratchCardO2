//
//  ScratchCardApp.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 09/11/2025.
//

import SwiftUI

@main
struct ScratchCardApp: App {
    // Share dependencies here
    @StateObject private var manager = ScratchCardManager()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(manager: manager))
                .onAppear {
                    // Change globally nabar title color to white
                    let appearance = UINavigationBarAppearance()
                    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().standardAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    UINavigationBar.appearance().compactAppearance = appearance
                    UINavigationBar.appearance().tintColor = .white
                }
        }
    }
}
