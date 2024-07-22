//
//  DropMapper.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

protocol DropMapperProtocol {
    func map(_ dto: GetDropsResponseDTO) -> [DropChannel]
}

struct DropMapper: DropMapperProtocol {
    enum DropMappingError: Error {
        case invalidUrl
    }

    func map(_ dto: GetDropsResponseDTO) -> [DropChannel] {
        dto.data.compactMap(map)
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
            newDropsCount: newDropsCount
        )
    }
}
