//
//  DropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

struct DropView: View {
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

                Spacer()

                seeAllDrops
            }
        }
    }

    private var dropButton: some View {
        Button(action: {
            // todo:
            // viewModel.didTapOnDrop()
        }) {
            ZStack {
                Image("DDROPP")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(color: Color.white.opacity(0.3), radius: 20, x: 0, y: 10)

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
    DropView()
}
