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
                    .font(.custom("RightGrotesk-CompactBlack", size: 40))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                dropButton
                    .padding()
                    .sheet(isPresented: $isPickerPresented, onDismiss: { imageLoader.loadImages(from: selectedItems) {
                        isReviewScreenPresented = true
                    }
                    }) {
                        PhotoPicker(selectedItems: $selectedItems)
                        //SuccessDropView()
                            .preferredColorScheme(.dark)
                    }
                Spacer()
                seeAllDrops
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isReviewScreenPresented) {
            ReviewDropView(selectedImages: $imageLoader.selectedImages)
        }
    }

    private var dropButton: some View {
        Button(action: {
            // todo:
            // viewModel.didTapOnDrop()
            isPickerPresented = true
        }) {
            ZStack {
                WaveformCircle()
                    .frame(width: 300, height: 300)

                Text("DDROPP")
                    .tracking(4)
                    .font(.custom("RightGrotesk-CompactBlack", size: 80))
                    .shadow(radius: 10)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(15))
                    .padding(.top, -20)
            }
        }
    }

    private var seeAllDrops: some View {
        HStack(spacing: 0) {
            Spacer()
            Text("See all drops")
                .font(.custom("RightGrotesk-CompactBlack", size: 24))
                .foregroundColor(.white)
            Button(action: {
                // todo:
                // viewModel.didTapOnSeeAll()
            }) {
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
