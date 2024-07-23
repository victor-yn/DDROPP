//
//  GetDropsDTO.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import Foundation

// Represents our API contract.
// This object mirrors our expectations (object types, mandatory/optional fields, etc.) to the API.
struct DropDTO:  Decodable {
    let image: String
    let author: String
    let date: Date
    let dropId: String
}
