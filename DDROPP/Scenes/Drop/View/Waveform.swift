//
//  Waveform.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

struct WaveformCircle: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        ZStack {
            ForEach(0..<8) { i in
                WaveLine(phase: phase + CGFloat(i) * 0.4, size: 50 + CGFloat(i) * 20)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 150 + CGFloat(i) * 40, height: 150 + CGFloat(i) * 40)
                    .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: phase)
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            phase += 0.06
        }
    }
}

struct WaveLine: Shape {
    var phase: CGFloat
    var amplitude: CGFloat = 10
    var frequency: CGFloat = 6
    var size: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = size

        var path = Path()

        for angle in stride(from: 0, to: 360, by: 1) {
            let theta = CGFloat(angle) * .pi / 180
            let x = center.x + (radius + amplitude * sin(theta * frequency + phase)) * cos(theta)
            let y = center.y + (radius + amplitude * sin(theta * frequency + phase)) * sin(theta)

            if angle == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        path.closeSubpath()

        return path
    }
}

#Preview {
    VStack {
        WaveformCircle()
            .frame(width: 400, height: 400)

        Spacer()
    }.background(Color.black)
}
