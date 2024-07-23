//
//  DropChannelView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import Kingfisher

struct DropListView: View {
    @ObservedObject private var viewModel: DropListViewModel

    @State private var isToggleActive = true

    init(viewModel: DropListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                switch viewModel.type {
                case .loading:
                    loadingView
                case .all(let drops):
                    DropGridView(drops: drops.map { $0.image })
                case .grouped(let events):
                    DropEventGroupedView(events: events)
                }
                VStack {
                    Spacer()
                    Toggle(isActive: $isToggleActive)
                        .shadow(color: .black, radius: 20)
                        .onChange(of: isToggleActive) { _ in
                            viewModel.didToggle()
                        }
                }
            }
            .foregroundColor(.white)
        }
        .navigationBarBackButtonHidden()
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
}

#Preview {
    DropListView(viewModel: DropListViewModel(channelId: "3"))
}
