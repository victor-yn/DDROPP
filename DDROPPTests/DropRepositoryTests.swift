//
//  DropRepositoryTests.swift
//  DDROPPTests
//
//  Created by Victor YAN on 23/07/2024.
//

import XCTest
import RxSwift
import RxBlocking

@testable import DDROPP

class DropRepositoryTests: XCTestCase {

    func testGetDropChannels_success() throws {
        let mockService = MockDropService(
            dropChannels: [DropChannelDTO(id: "1", name: "Test Channel", newDropsCount: "10", lastDropImage: "http://voodoo.io/image.jpg")]
        )
        let repository = DropRepository(dropService: mockService)

        // Making async calls synchronous to test robustness
        let result = repository.getDropChannels().toBlocking().materialize()

        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements.first?.count, 1)
            XCTAssertEqual(elements.first?.first?.id, "1")
            XCTAssertEqual(elements.first?.first?.name, "Test Channel")
        default:
            XCTFail("Expected success :-(")
        }
    }

    func testGetDropChannels_failure() throws {
        let mockService = MockDropService(shouldFail: true)
        let repository = DropRepository(dropService: mockService)

        let result = repository.getDropChannels().toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Expected failure :-(")
        case .failed(_, let error):
            XCTAssertNotNil(error)
        }
    }

    func testGetDrops_success() throws {
        let mockService = MockDropService(
            drops: [DropDTO(image: "http://voodoo.io/image.jpg", author: "Author", date: Date(), dropId: "")]
        )
        let repository = DropRepository(dropService: mockService)

        let result = repository.getDrops(by: "1").toBlocking().materialize()

        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements.first?.count, 1)
            XCTAssertEqual(elements.first?.first?.author, "Author")
        case .failed(_, let error):
            XCTFail("Expected success :-(")
        }
    }

    func testGetDrops_failure() throws {
        let mockService = MockDropService(shouldFail: true)
        let repository = DropRepository(dropService: mockService)

        let result = repository.getDrops(by: "1").toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Expected failure :-(")
        case .failed(_, let error):
            XCTAssertNotNil(error)
        }
    }
}

class MockDropService: DropServiceProtocol {
    private let dropChannels: [DropChannelDTO]
    private let drops: [DropDTO]
    private let shouldFail: Bool

    init(dropChannels: [DropChannelDTO] = [], drops: [DropDTO] = [], shouldFail: Bool = false) {
        self.dropChannels = dropChannels
        self.drops = drops
        self.shouldFail = shouldFail
    }

    func getDropChannels() -> Single<[DropChannelDTO]> {
        if shouldFail {
            return Single.error(NSError(domain: "Test", code: -1, userInfo: nil))
        } else {
            return Single.just(dropChannels)
        }
    }

    func getDrops(by id: String) -> Single<[DropDTO]> {
        if shouldFail {
            return Single.error(NSError(domain: "Test", code: -1, userInfo: nil))
        } else {
            return Single.just(drops)
        }
    }
}
