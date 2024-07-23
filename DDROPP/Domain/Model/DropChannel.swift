//
//  DropChannel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

struct DropChannel {
    let id: String
    let name: String
    let newDropsCount: Int
    let lastDropImage: URL? // Functionality speaking, we could show a placeholder for the channel if no img
}
