//
//  DropListGrouperTests.swift
//  DDROPPTests
//
//  Created by Victor YAN on 23/07/2024.
//

import XCTest

@testable import DDROPP

class DropListGrouperTests: XCTestCase {

    func testCreateDropEvents_singleEvent() {
        let drops = [
            Drop(image: URL(string: "https://voodoo.io/image1.jpg")!, author: "Moka", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://voodoo.io/image2.jpg")!, author: "Moka", date: Date(), dropEventId: "event1")
        ]

        let grouper = DropListGrouper()
        let dropEvents = grouper.createDropEvents(from: drops)

        XCTAssertEqual(dropEvents.count, 1)
        XCTAssertEqual(dropEvents.first?.id, "event1")
        XCTAssertEqual(dropEvents.first?.author, "Moka")
        XCTAssertEqual(dropEvents.first?.images.count, 2)
    }

    func testCreateDropEvents_multipleEvents() {
        let drops = [
            Drop(image: URL(string: "https://voodoo.io/image1.jpg")!, author: "Moka", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://voodoo.io/image2.jpg")!, author: "Kamo", date: Date(), dropEventId: "event2"),
            Drop(image: URL(string: "https://voodoo.io/image3.jpg")!, author: "Kamo", date: Date(), dropEventId: "event2"),
            Drop(image: URL(string: "https://voodoo.io/image4.jpg")!, author: "Moka", date: Date(), dropEventId: "event3")
        ]

        let grouper = DropListGrouper()
        let dropEvents = grouper.createDropEvents(from: drops)

        XCTAssertEqual(dropEvents.count, 3)

        let event1 = dropEvents.first(where: { $0.id == "event1" })
        XCTAssertEqual(event1?.author, "Moka")
        XCTAssertEqual(event1?.images.count, 1)

        let event2 = dropEvents.first(where: { $0.id == "event2" })
        XCTAssertEqual(event2?.author, "Kamo")
        XCTAssertEqual(event2?.images.count, 2)

        let event3 = dropEvents.first(where: { $0.id == "event3" })
        XCTAssertEqual(event3?.author, "Moka")
        XCTAssertEqual(event3?.images.count, 1)
    }

    func testCreateDropEvents_emptyList() {
        let drops: [Drop] = []

        let grouper = DropListGrouper()
        let dropEvents = grouper.createDropEvents(from: drops)

        XCTAssertEqual(dropEvents.count, 0)
    }

    func testCreateDropEvents_mixedEvents() {
        let drops = [
            Drop(image: URL(string: "https://voodoo.io/image1.jpg")!, author: "Moka", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://voodoo.io/image2.jpg")!, author: "Kamo", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://voodoo.io/image3.jpg")!, author: "Moka", date: Date(), dropEventId: "event2"),
            Drop(image: URL(string: "https://voodoo.io/image4.jpg")!, author: "Kamo", date: Date(), dropEventId: "event3"),
            Drop(image: URL(string: "https://voodoo.io/image5.jpg")!, author: "Moka", date: Date(), dropEventId: "event3")
        ]

        let grouper = DropListGrouper()
        let dropEvents = grouper.createDropEvents(from: drops)

        XCTAssertEqual(dropEvents.count, 3)

        let event1 = dropEvents.first(where: { $0.id == "event1" })
        XCTAssertEqual(event1?.images.count, 2)

        let event2 = dropEvents.first(where: { $0.id == "event2" })
        XCTAssertEqual(event2?.images.count, 1)

        let event3 = dropEvents.first(where: { $0.id == "event3" })
        XCTAssertEqual(event3?.images.count, 2)
    }
}
