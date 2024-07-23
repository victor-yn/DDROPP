//
//  DropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import PhotosUI

struct DropView: View {
    @State private var isPickerPresented = false
    @State private var selectedItems: [PHPickerResult] = []
    @StateObject private var imageLoader = ImageLoader()
    @State private var isReviewScreenPresented = false

    private let viewModel: DropViewModel

    init(viewModel: DropViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("👋 Have something to drop?")
                    .ddroppCompactFont(size: 40)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                dropButton
                    .padding()
                    .fullScreenCover(isPresented: $isPickerPresented, onDismiss: {
                        guard !selectedItems.isEmpty else { return }
                        imageLoader.loadImages(from: selectedItems) {
                            isReviewScreenPresented = true
                    }
                    }) {
                        PhotoPicker(selectedItems: $selectedItems)
                            .preferredColorScheme(.dark)
                    }
                Spacer()
                seeAllDrops
            }
            .padding(.bottom, 16)
        }
        .navigationDestination(isPresented: $isReviewScreenPresented) {
            ReviewDropView(selectedImages: $imageLoader.selectedImages)
        }
    }

    private var dropButton: some View {
        Button(action: {
            isPickerPresented = true
        }) {
            ZStack {
                WaveformCircle()
                    .frame(width: 300, height: 300)

                Text("DDROPP")
                    .tracking(4)
                    .ddroppCompactFont(size: 80)
                    .shadow(radius: 10)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(15))
                    .padding(.top, -20)
            }
        }
    }

    private var seeAllDrops: some View {
        NavigationLink {
            DropListView(viewModel: DropListViewModel(channelId: "10"))
        } label: {
            HStack(spacing: 0) {
                Spacer()
                Text("See all drops")
                    .ddroppCompactFont(size: 24)
                    .foregroundColor(.white)
                Image(systemName: "list.bullet.rectangle.portrait")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

#Preview {
    DropView(viewModel: DropViewModel(channelId: "20"))
}
