//
//  Rswift+SwiftUI.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import RswiftResources
import SwiftUI

extension FontResource {
    func font(size: CGFloat) -> Font {
        Font.custom(name, size: size)
    }
}
