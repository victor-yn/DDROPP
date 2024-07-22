//
//  ReviewDropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import PhotosUI

struct ReviewDropView: View {
    @Binding var selectedImages: [UIImage]
    @State private var selectedIndex: Int = 0

    // To improve
    @State private var showEmojis: Bool = false
    @State private var emojis: [String] = []
    @State private var emojiPositions: [CGPoint] = []
    @State private var emojiOffsets: [CGSize] = []
    @State private var emojiOpacities: [Double] = []

    @State private var showSuccessScreen = false

    var body: some View {
        VStack(spacing: 0) {
            if selectedImages.indices.contains(selectedIndex) {
                Image(uiImage: selectedImages[selectedIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 12, height: UIScreen.main.bounds.width - 12)
                    .background(.white)
                    .cornerRadius(20)
                    .overlay(
                        emojiOverlay()
                    )
            }

            Text("You have selected \(selectedImages.count) photos to drop")
                .lineLimit(0)
                .font(.custom("RightGrotesk-SpatialBlack", size: 16))
                .foregroundColor(.white)
                .padding()

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
            Spacer()
            Button(action: {
                // Todo: Implement upload action
                uploadMedia()
            }) {
                HStack(alignment: .center) {
                    Text("DDROPP")
                        .font(.custom("RightGrotesk-CompactBlack", size: 64))
                        .foregroundColor(.white)
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .frame(maxHeight: .infinity)
                        .padding()
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    // Move this out
    private func uploadMedia() {
        print("Woof! Uploading \(selectedImages.count) images...")
        showSuccessScreen = true
    }

    // Move this out
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

    // Move this out
    private func showRandomEmojis() {
         emojis = ["🤩", "🔥", "❤️"].shuffled().map { $0 }
         emojiPositions = emojis.map { _ in
             CGPoint(x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50), y: CGFloat.random(in: 200...UIScreen.main.bounds.height - 200))
         }
         emojiOffsets = Array(repeating: .zero, count: emojis.count)
        emojiOpacities = Array(repeating: 1.0, count: emojis.count)
         showEmojis = true

         withAnimation(.easeOut(duration: 1.5)) {
             for i in 0..<emojiOffsets.count {
                 emojiOffsets[i].height = -150
                 emojiOffsets[i].width = CGFloat.random(in: -30...30)
                 emojiOpacities[i] = 0.0
             }
         }

         DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
             showEmojis = false
         }
     }
}
