//
//  Toggle.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import SwiftUI

struct Toggle: View {
    @Binding var isActive: Bool

    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.black)
                .frame(width: 120, height: 50)
                .overlay(Capsule().stroke(Color.gray, lineWidth: 1))

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .frame(width: 80, height: 50)
                .offset(x: isActive ? 35 : -35)
                .animation(.easeInOut(duration: 0.1), value: isActive)

            HStack(spacing: 0) {
                Image(systemName: "list.bullet")
                    .foregroundColor(isActive ? .gray : .black)
                    .padding()
                Spacer()
                Image(systemName: "square.grid.2x2")
                    .foregroundColor(isActive ? .black : .gray)
                    .padding()
            }
            .frame(width: 120, height: 50)
        }
        .onTapGesture {
            isActive.toggle()
        }
    }
}

#Preview {
    Toggle(isActive: .constant(true))
}
