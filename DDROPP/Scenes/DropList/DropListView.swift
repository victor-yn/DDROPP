//
//  DropListView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

struct DropListView: View {
    @ObservedObject private var viewModel: DropListViewModel

    init(viewModel: DropListViewModel = DropListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                if viewModel.isLoading {
                    loadingView
                } else {
                    ScrollView(showsIndicators: false) {
                        channelView
                            .padding()
                    }
                }
            }
            .foregroundColor(.white)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView {
                Text("Loading")
                    .font(.custom("RightGrotesk-CompactBlack", size: 64))
                    .foregroundColor(.white)
            }
            Spacer()
            Text("DDROPP")
                .font(.custom("RightGrotesk-CompactBlack", size: 32))
                .foregroundColor(.white)
        }

    }

    private var channelView: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            if !viewModel.hotChannels.isEmpty {
                Text("Hot ones 🌶️")
                    .font(.custom("RightGrotesk-CompactBlack", size: 32))
                    .foregroundColor(.white)
                ForEach(viewModel.hotChannels) { channel in
                    NavigationLink(destination: DropView(viewModel: DropViewModel(channelId: channel.id))) {
                        LargeChannelView(channel: channel)
                    }
                }
            }
            if !viewModel.quietChannels.isEmpty {
                Text("Chilling 💆")
                    .font(.custom("RightGrotesk-CompactBlack", size: 32))
                    .foregroundColor(.white)
                ForEach(viewModel.quietChannels) { channel in
                    NavigationLink(destination: DropView(viewModel: DropViewModel(channelId: channel.id))) {
                        SmallChannelView(channel: channel)
                    }
                }
            }
        }
    }
}

#Preview {
    DropListView()
}
