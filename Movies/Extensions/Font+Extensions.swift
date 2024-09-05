//
//  Font+Extensions.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 04/09/2024.
//

import SwiftUI

extension Font {
    static func regular(_ size: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: size)
    }

    static func semiBold(_ size: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: size)
    }
}
