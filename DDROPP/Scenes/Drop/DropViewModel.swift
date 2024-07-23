//
//  DropViewModel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

final class DropViewModel: ObservableObject {
    private let channelId: String

    init(channelId: String) {
        self.channelId = channelId
    }
}
