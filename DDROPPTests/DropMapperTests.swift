//
//  DropMapperTests.swift
//  DDROPPTests
//
//  Created by Victor YAN on 23/07/2024.
//

import XCTest
@testable import DDROPP

class DropMapperTests: XCTestCase {

    func testMapDropChannelDTO_validDTO_shouldReturnDropChannel() {
        let dto = DropChannelDTO(id: "1", name: "Test Channel", newDropsCount: "5", lastDropImage: "https://voodoo.io/image.png")
        let mapper = DropMapper()

        let result = mapper.map(dto)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, "1")
        XCTAssertEqual(result?.name, "Test Channel")
        XCTAssertEqual(result?.newDropsCount, 5)
        XCTAssertEqual(result?.lastDropImage?.absoluteString, "https://voodoo.io/image.png")
    }

    func testMapDropChannelDTO_invalidNewDropsCount_shouldReturnNil() {
        let dto = DropChannelDTO(id: "1", name: "Test Channel", newDropsCount: "blabla this is not valid", lastDropImage: "https://voodoo.io/image.png")
        let mapper = DropMapper()

        let result = mapper.map(dto)

        XCTAssertNil(result)
    }

    func testMapDropDTO_validDTO_shouldReturnDrop() {
        let dto = DropDTO(image: "https://voodoo.io/image.png", author: "Test Author", date: Date(), dropId: "123")
        let mapper = DropMapper()

        let result = mapper.map(dto)

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.image.absoluteString, "https://voodoo.io/image.png")
        XCTAssertEqual(result?.author, "Test Author")
        XCTAssertEqual(result?.dropEventId, "123")
    }

    func testMapDropChannelDTOArray_validDTOs_shouldReturnDropChannels() {
        let dtos = [
            DropChannelDTO(id: "1", name: "Channel 1", newDropsCount: "5", lastDropImage: "https://voodoo.io/image1.png"),
            DropChannelDTO(id: "2", name: "Channel 2", newDropsCount: "10", lastDropImage: "https://voodoo.io/image2.png")
        ]
        let mapper = DropMapper()

        let result = mapper.map(dtos)

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[1].id, "2")
    }

    func testMapDropChannelDTOArray_containsInvalidDTO_shouldSkipInvalid() {
        let dtos = [
            DropChannelDTO(id: "1", name: "Channel 1", newDropsCount: "5", lastDropImage: "https://voodoo.io/image1.png"),
            DropChannelDTO(id: "2", name: "Channel 2", newDropsCount: "invalid", lastDropImage: "https://voodoo.io/image2.png")
        ]
        let mapper = DropMapper()

        let result = mapper.map(dtos)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].id, "1")
    }

    func testMapDropDTOArray_validDTOs_shouldReturnDrops() {
        let dtos = [
            DropDTO(image: "https://voodoo.io/image1.png", author: "Author 1", date: Date(), dropId: "1"),
            DropDTO(image: "https://voodoo.io/image2.png", author: "Author 2", date: Date(), dropId: "2")
        ]
        let mapper = DropMapper()

        let result = mapper.map(dtos)

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].image.absoluteString, "https://voodoo.io/image1.png")
        XCTAssertEqual(result[1].image.absoluteString, "https://voodoo.io/image2.png")
    }
}
