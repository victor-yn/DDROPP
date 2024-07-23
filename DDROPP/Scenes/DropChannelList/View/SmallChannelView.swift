//
//  SmallChannelView.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI
import Kingfisher

struct SmallChannelView: View {
    private let channel: DropChannel

    init(channel: DropChannel) {
        self.channel = channel
    }

    var body: some View {
        HStack {
            imageView
            VStack(alignment: .leading) {
                titleView
                dropTotalCountView
            }
            Spacer()
        }
        .cornerRadius(12)
    }

    private var imageView: some View {
        KFImage(channel.lastDropImage)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            .clipped()
    }

    private var titleView: some View {
        Text(channel.name)
            .ddroppCompactFont(size: 24)
            .foregroundColor(.white)
    }

    private var dropTotalCountView: some View {
        Text("231 drops")
            .ddroppCompactFont(size: 12)
            .foregroundColor(.white)
    }
}
