//
//  View+Font.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI

extension View {
    func ddroppCompactFont(size: CGFloat) -> some View {
        self.font(.custom("RightGrotesk-CompactBlack", size: size))
    }

    func ddroppSpatialFont(size: CGFloat) -> some View {
        self.font(.custom("RightGrotesk-SpatialBlack", size: size))
    }
}
