//
//  SuccessDropView.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI

struct SuccessDropView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            GrowingCirclesView()
            VStack {
                Spacer()
                successText
                Spacer()
                NavigationLink {
                    DropListView(viewModel: DropListViewModel(channelId: "10"))
                } label: {
                    seeAllText
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            HapticFeedbackHelper().triggerSuccess()
        }
    }

    private var successText: some View {
        Text("DDROPPED!")
            .ddroppCompactFont(size: 64)
            .foregroundColor(.white)
            .scaleEffect(1.2)
            .opacity(1.0)
            .transition(.scale)
    }

    private var seeAllText: some View {
        Text("See all drops")
            .ddroppCompactFont(size: 24)
            .foregroundColor(.white)
    }
}

#Preview {
    SuccessDropView()
}
