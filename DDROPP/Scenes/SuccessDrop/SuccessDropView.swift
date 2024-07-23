//
//  SuccessDropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

// Should I keep?
struct UploadingView: View {
    var body: some View {
        VStack {
            ProgressView("Uploading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
    }
}

struct SuccessDropView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            GrowingCirclesView()
            VStack {
                Spacer()
                Text("DDROPPED!")
                    .font(.custom("RightGrotesk-CompactBlack", size: 64))
                    .foregroundColor(.white)
                    .scaleEffect(1.2)
                    .opacity(1.0)
                    .transition(.scale)
                Spacer()
                NavigationLink {
                    DropChannelView(viewModel: DropChannelViewModel(channelId: "10"))
                } label: {
                    Text("See all drops")
                        .font(.custom("RightGrotesk-CompactBlack", size: 24))
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            HapticFeedbackHelper.triggerSuccess()
        }
    }
}

// Move this out!
class HapticFeedbackHelper {
    static func triggerSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    SuccessDropView()
}
