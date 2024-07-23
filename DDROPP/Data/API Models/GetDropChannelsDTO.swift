//
//  GetDropsResponseDTO.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation

// Represents our API contract.
// This object mirrors our expectations (object types, mandatory/optional fields, etc.) to the API.
struct DropChannelDTO : Decodable {
    let id: String
    let name: String
    let newDropsCount: String // Simulate that the API contract was not designed in a good great and and returns a String for an Integer field
    let lastDropImage: String
}
