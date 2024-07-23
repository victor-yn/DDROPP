//
//  DropChannelView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import Kingfisher

struct DropChannelView: View {
    @ObservedObject private var viewModel: DropChannelViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var isToggleActive: Bool = true

    init(viewModel: DropChannelViewModel) {
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
                    HStack {
                        BackButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
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
                    .font(.custom("RightGrotesk-CompactBlack", size: 64))
                    .foregroundColor(.white)
            }
            Spacer()
            Text("DDROPP")
                .font(.custom("RightGrotesk-CompactBlack", size: 32))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    DropChannelView(viewModel: DropChannelViewModel(channelId: "3"))
}

struct BackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black))
                .shadow(color: .black, radius: 10, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
