//
//  ChannelViews.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI
import Kingfisher

struct LargeChannelView: View {
    private let channel: DropChannel

    init(channel: DropChannel) {
        self.channel = channel
    }

    var body: some View {
        VStack(spacing: 8) {
            imageView
            VStack(alignment: .leading, spacing: 0) {
                titleView
                HStack {
                    dropTotalCountView
                    Spacer()
                    newDropCountView
                }
                justSharedView
            }.padding(6)
        }
        .padding(8)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
                .opacity(0.4)
        )
    }

    private var imageView: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(channel.lastDropImage)
                .resizable()
                .scaledToFill()
                .cornerRadius(12)
                .overlay(
                    // Gradient to make sure the white label is visible on white images
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .cornerRadius(12)
                    .frame(height: 300),
                    alignment: .bottom
                )

            Text("just shared by Victor")
                .ddroppCompactFont(size: 12)
                .foregroundColor(.white)
                .padding(.bottom, 8)
                .padding(.trailing, 8)
        }
    }

    private var titleView: some View {
        Text(channel.name)
            .ddroppCompactFont(size: 24)
            .foregroundColor(.white)
    }

    private var dropTotalCountView: some View {
        Text("420 drops")
            .ddroppCompactFont(size: 12)
            .foregroundColor(.white)
            .opacity(0.8)
    }

    private var newDropCountView: some View {
        Text("\(channel.newDropsCount) new drops")
            .ddroppCompactFont(size: 16)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.red.opacity(0.8))
            )
    }

    private var justSharedView: some View {
        Text("Emma and Jason just shared")
            .ddroppCompactFont(size: 12)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}
