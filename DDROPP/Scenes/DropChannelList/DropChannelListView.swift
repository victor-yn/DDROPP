//
//  DropListView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

struct DropChannelListView: View {
    @ObservedObject private var viewModel: DropChannelListViewModel
    @State private var isDropViewPresented = false

    init(viewModel: DropChannelListViewModel = DropChannelListViewModel()) {
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
                            .padding(8)
                    }
                }
            }
            .foregroundColor(.white)
            .sheet(isPresented: $isDropViewPresented) {
                NavigationStack {
                    DropView(viewModel: DropViewModel(channelId: "example"))
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView {
                Text("Loading")
                    .ddroppCompactFont(size: 64)
                    .foregroundColor(.white)
            }
            Spacer()
            Text("DDROPP")
                .ddroppCompactFont(size: 32)
                .foregroundColor(.white)
        }
    }

    private var channelView: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            if !viewModel.hotChannels.isEmpty {
                Text("\(viewModel.newDrops) new drops! 🌶️")
                    .ddroppCompactFont(size: 32)
                    .foregroundColor(.white)
                ForEach(viewModel.hotChannels, id: \.id) { channel in
                    Button(action: {
                        isDropViewPresented = true
                    }) {
                        LargeChannelView(channel: channel)
                    }
                }
            }
            if !viewModel.quietChannels.isEmpty {
                Text("Chilling 💆")
                    .ddroppCompactFont(size: 32)
                    .foregroundColor(.white)
                ForEach(viewModel.quietChannels, id: \.id) { channel in
                    Button(action: {
                        isDropViewPresented = true
                    }) {
                        SmallChannelView(channel: channel)
                    }
                }
            }
        }
    }
}

#Preview {
    DropChannelListView()
}
