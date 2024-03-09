//
//  MainView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct MainView: View {
    @Bindable var viewModel: MainViewModel

    var body: some View {
    }
}

struct MainView_Previews: PreviewProvider {
    private static let mainComponent = MainComponent()

    static var previews: some View {
        MainView(viewModel: mainComponent.viewModel)
    }
}
