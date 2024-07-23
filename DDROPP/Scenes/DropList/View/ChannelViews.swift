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
            KFImage(URL(string: "https://i.ytimg.com/vi/yAv5pLO37mE/maxresdefault.jpg")) // WIP
                .resizable()
                .aspectRatio(1, contentMode: .fill)
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
                .font(.custom("RightGrotesk-CompactBlack", size: 12))
                .foregroundColor(.white)
                .padding(.bottom, 8)
                .padding(.trailing, 8)
        }
    }

    private var titleView: some View {
        Text(channel.name)
            .font(.custom("RightGrotesk-CompactBlack", size: 24))
            .foregroundColor(.white)
    }

    private var dropTotalCountView: some View {
        Text("420 drops")
            .font(.custom("RightGrotesk-CompactBlack", size: 12))
            .foregroundColor(.white)
            .opacity(0.8)
    }

    private var newDropCountView: some View {
        Text("\(channel.newDropsCount) new drops")
            .font(.custom("RightGrotesk-CompactBlack", size: 16))
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
            .font(.custom("RightGrotesk-CompactBlack", size: 12))
            .foregroundColor(.white)
            .opacity(0.8)
    }
}

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
        KFImage(URL(string: "https://i.ytimg.com/vi/yAv5pLO37mE/maxresdefault.jpg")) // WIP
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            .clipped()
    }

    private var titleView: some View {
        Text(channel.name)
            .font(.custom("RightGrotesk-CompactBlack", size: 24))
            .foregroundColor(.white)
    }

    private var dropTotalCountView: some View {
        Text("231 drops")
            .font(.custom("RightGrotesk-CompactBlack", size: 12))
            .foregroundColor(.white)
    }
}
