//
//  DefaultHorizontalPaddingModifier.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import SwiftUI

struct DefaultHorizontalPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
    }
}
