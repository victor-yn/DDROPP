//
//  DropListGrouper.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import Foundation

protocol DropListGrouperProtocol {
    func createDropEvents(from drops: [Drop]) -> [DropEvent]
}

// Component meant to encapsulate grouping logic & associated rules. Here I faked some rules.
struct DropListGrouper: DropListGrouperProtocol {
    func createDropEvents(from drops: [Drop]) -> [DropEvent] {
        // Dictionary to group drops by dropEventId
        var groupedDrops = [String: (author: String, images: [URL])]()
        // Group drops by dropEventId
        for drop in drops {
            if var entry = groupedDrops[drop.dropEventId] {
                entry.images.append(drop.image)
                groupedDrops[drop.dropEventId] = entry
            } else {
                groupedDrops[drop.dropEventId] = (author: drop.author, images: [drop.image])
            }
        }
        // Convert the grouped dictionary to an array of DropEvent
        let dropEvents = groupedDrops.map { (key, value) in
            DropEvent(id: key, author: value.author, images: value.images)
        }
        return dropEvents
    }
}
