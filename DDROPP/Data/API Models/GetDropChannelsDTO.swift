//
//  GetDropsResponseDTO.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

// Represents our API contract.
// This object mirrors our expectations (object types, mandatory/optional fields, etc.) to the API.
struct GetDropsResponseDTO: Decodable {
    let data: [DropChannelDTO]
}

struct DropChannelDTO : Decodable {
    let id: String
    let name: String
    let newDropsCount: String // Assuming the API contract was designed in a good way and returns a String for an Integer field
}
