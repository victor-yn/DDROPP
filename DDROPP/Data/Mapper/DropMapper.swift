//
//  DropMapper.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

protocol DropMapperProtocol {
    func map(_ dto: [DropChannelDTO]) -> [DropChannel]
    func map(_ dto: [DropDTO]) -> [Drop]
}

struct DropMapper: DropMapperProtocol {
    enum DropMappingError: Error {
        case invalidUrl
    }

    func map(_ dto: [DropChannelDTO]) -> [DropChannel] {
        dto.compactMap(map)
    }

    func map(_ dto: DropChannelDTO) -> DropChannel? {
        // We run validation rules here, will add some more example; e.g.
        guard let newDropsCount = Int(dto.newDropsCount) else {
            // Invalid API response, the "newDropCount" string cannot be represented as an Integer for us
            return nil // We skip the element but we don't fail the entire channel mapping
        }

        return DropChannel(
            id: dto.id,
            name: dto.name,
            newDropsCount: newDropsCount,
            lastDropImage: URL(string: dto.lastDropImage)
        )
    }

    func map(_ dto: [DropDTO]) -> [Drop] {
        dto.compactMap(map)
    }

    func map(_ dto: DropDTO) -> Drop? {
        guard let url = URL(string: dto.image) else {
            // Invalid URL, we skip the picture (we don't want to show empty drops)
            return nil
        }
        return Drop(
            image: url,
            author: dto.author,
            date: dto.date,
            dropEventId: dto.dropId
        )
    }
}
