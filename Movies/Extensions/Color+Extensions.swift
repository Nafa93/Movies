//
//  Color+Extensions.swift
//  Movies
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 05/09/2024.
//

import SwiftUI

extension Color {
    static var imdbBackground: Color {
        Color("Background")
    }
}

extension UIColor {
    static var imdbBackground: UIColor? {
        UIColor(named: "Background")
    }
}
