//
//  DropEventGroupedView.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI
import Kingfisher

struct DropEventGroupedView: View {
    private let events: [DropEvent]

    init(events: [DropEvent]) {
        self.events = events
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(events, id: \.id) { dropEvent in
                    section(for: dropEvent)
                }
            }
            .padding()
        }
    }

    private func section(for event: DropEvent) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(event.author) dropped \(event.images.count) pictures")
                    .font(.custom("RightGrotesk-CompactBlack", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Text("4h ago")
                    .font(.custom("RightGrotesk-CompactBlack", size: 12))
                    .foregroundColor(.gray)
            }
            ZStack {
                ForEach(Array(event.images.prefix(3).enumerated()), id: \.element) { index, imageUrl in
                    image(for: imageUrl)
                        // Image stack effect
                        .offset(x: CGFloat(index) * 20, y: CGFloat(index) * 20)
                        .rotationEffect(.degrees(Double(index * 2)))
                }
            }
            .frame(height: 240)
            .padding(.bottom, 48)
        }
    }

    private func image(for url: URL) -> some View {
        KFImage(url)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .cornerRadius(20)
            .clipped()
            .shadow(radius: 5)
    }
}
