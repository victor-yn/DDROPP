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
                Text("See all drops")
                    .font(.custom("RightGrotesk-CompactBlack", size: 24))
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            HapticFeedbackHelper.triggerSuccess()
        }
    }
}

struct GrowingCirclesView: View {
    @State private var circles: [CircleData] = []

    var body: some View {
        ZStack {
            ForEach(circles) { circle in
                GrowingCircle(circle: circle)
                    .position(x: circle.position.x, y: circle.position.y)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                let newCircle = CircleData(id: UUID(), position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height)), duration: Double.random(in: 1...6.0))
                circles.append(newCircle)
            }
        }
    }
}

struct CircleData: Identifiable {
    let id: UUID
    let position: CGPoint
    let duration: Double
}

struct GrowingCircle: View {
    let circle: CircleData
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 0.7

    var body: some View {
        Circle()
            .fill(Color.orange)
            .frame(width: CGFloat.random(in: 50...150), height: CGFloat.random(in: 50...150))
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear(duration: circle.duration)) {
                    self.scale = 3.0
                    self.opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + circle.duration) {
                    self.opacity = 0.0
                }
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
