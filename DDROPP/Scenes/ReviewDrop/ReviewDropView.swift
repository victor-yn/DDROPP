//
//  ReviewDropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import PhotosUI

struct ReviewDropView: View {
    @ObservedObject private var viewModel: ReviewDropViewModel

    @Binding private var selectedImages: [UIImage]
    @State private var selectedIndex: Int = 0

    // Quick prototype for the emoji animation
    @State private var emojis: [String] = []
    @State private var emojiPositions: [CGPoint] = []
    @State private var emojiOffsets: [CGSize] = []
    @State private var emojiOpacities: [Double] = []

    init(viewModel: ReviewDropViewModel = ReviewDropViewModel(),
        selectedImages: Binding<[UIImage]>) {
        self.viewModel = viewModel
        self._selectedImages = selectedImages
    }

    var body: some View {
        VStack(spacing: 0) {
            if selectedImages.indices.contains(selectedIndex) {
                previewImage(index: selectedIndex)
            }
            selectionCountText
            imageSlider
            Spacer()
            dropButton
            NavigationLink(destination: SuccessDropView(), isActive: $viewModel.navigateToSuccess) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    private func previewImage(index: Int) -> some View {
        Image(uiImage: selectedImages[index])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width - 12, height: UIScreen.main.bounds.width - 12)
            .background(.white)
            .cornerRadius(20)
            .overlay {
                emojiOverlay()
            }
    }

    private var selectionCountText: some View {
        Text("You have selected \(selectedImages.count) photos to drop")
            .lineLimit(0)
            .ddroppSpatialFont(size: 16)
            .foregroundColor(.white)
            .padding()
    }

    private var imageSlider: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(selectedImages.indices, id: \.self) { index in
                    Image(uiImage: selectedImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.horizontal, 5)
                        .overlay(
                            // Rounded selection
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: selectedIndex == index ? 4 : 0)
                                .frame(width: 100, height: 100)
                        )
                        .onTapGesture {
                            showRandomEmojis()
                            selectedIndex = index
                        }
                }
            }
            .padding(.horizontal)
        }
    }

    private var dropButton: some View {
        Button(action: {
            viewModel.onSubmitTap()
        }) {
            HStack(alignment: .center) {
                Text("DDROPP")
                    .ddroppCompactFont(size: 64)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }.padding()
        }
    }

    // Emoji animation
    @ViewBuilder
    private func emojiOverlay() -> some View {
        ForEach(0..<emojis.count, id: \.self) { index in
            Text(emojis[index])
                .font(.system(size: 42))
                .position(emojiPositions[index])
                .offset(emojiOffsets[index])
                .opacity(emojiOpacities[index])
        }
    }

    // Quick animation prototype
    private func showRandomEmojis() {
        let selectedEmojis = Array(["🤩", "🔥", "❤️", "🌶️", "💖", "🤩", "😎"].shuffled().prefix(3))
        emojis = selectedEmojis
        emojiPositions = emojis.map { _ in
            CGPoint(x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50),
                    y: CGFloat.random(in: 100...UIScreen.main.bounds.height / 2)
            )
        }
        emojiOffsets = Array(repeating: .zero, count: selectedEmojis.count)
        emojiOpacities = Array(repeating: 1.0, count: selectedEmojis.count)

        for i in 0..<emojiOffsets.count {
            withAnimation(.easeOut(duration: 1)) {
                emojiOffsets[i].height = -30
                emojiOffsets[i].width = CGFloat.random(in: -30...30)
                emojiOpacities[i] = 0.0
            }
        }
    }
}

#Preview {
    ReviewDropView(selectedImages: .constant([.strokedCheckmark]))
}
