//
//  DropGridView.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI
import Kingfisher

struct DropGridView: View {
    private let drops: [URL]

    init(drops: [URL]) {
        self.drops = drops
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width - 16), spacing: 8)], spacing: 8) {
                ForEach(drops, id: \.self) { imageUrl in
                    image(for: imageUrl)
                }
            }
        }
    }

    private func image(for url: URL) -> some View {
        KFImage(url)
            .resizable()
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.height / 2)
            .cornerRadius(8)
            .clipped()
    }
}

