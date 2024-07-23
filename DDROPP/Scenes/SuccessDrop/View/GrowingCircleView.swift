//
//  GrowingCircleView.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI

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
                    self.scale = 4.0
                    self.opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + circle.duration) {
                    self.opacity = 0.0
                }
            }
    }
}

#Preview {
    GrowingCirclesView()
}
