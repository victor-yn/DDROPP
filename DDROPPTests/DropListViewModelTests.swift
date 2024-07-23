//
//  DropListViewModelTests.swift
//  DDROPPTests
//
//  Created by Victor YAN on 23/07/2024.
//

import XCTest
import RxSwift
import RxBlocking

@testable import DDROPP

class DropListViewModelTests: XCTestCase {

    func testFetchDrops_success() throws {
        let mockUseCase = MockGetDropsUseCase(drops: [
            Drop(image: URL(string: "https://example.com/image1.jpg")!, author: "Author1", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://example.com/image2.jpg")!, author: "Author2", date: Date(), dropEventId: "event2")
        ])
        let mockGrouper = MockDropListGrouper()

        let viewModel = DropListViewModel(channelId: "1", getDropsUseCase: mockUseCase, dropGrouper: mockGrouper)

        viewModel.onAppear()

        XCTAssertEqual(viewModel.drops.count, 2)
        XCTAssertEqual(viewModel.type, .all(drops: viewModel.drops))
    }

    func testFetchDrops_failure() throws {
        let mockUseCase = MockGetDropsUseCase(drops: [], shouldFail: true)
        let mockGrouper = MockDropListGrouper()

        let viewModel = DropListViewModel(channelId: "1", getDropsUseCase: mockUseCase, dropGrouper: mockGrouper)

        viewModel.onAppear()

        XCTAssertEqual(viewModel.drops.count, 0)
        XCTAssertEqual(viewModel.type, .loading)
    }

    func testDidToggle_allToGrouped() throws {
        let mockUseCase = MockGetDropsUseCase(drops: [
            Drop(image: URL(string: "https://example.com/image1.jpg")!, author: "Author1", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://example.com/image2.jpg")!, author: "Author2", date: Date(), dropEventId: "event2")
        ])
        let mockGrouper = MockDropListGrouper()

        let viewModel = DropListViewModel(channelId: "1", getDropsUseCase: mockUseCase, dropGrouper: mockGrouper)

        viewModel.onAppear()
        viewModel.didToggle()

        if case .grouped(let events) = viewModel.type {
            XCTAssertEqual(events.count, 2)
        } else {
            XCTFail("Expected grouped type but got \(viewModel.type)")
        }
    }

    func testDidToggle_groupedToAll() throws {
        let mockUseCase = MockGetDropsUseCase(drops: [
            Drop(image: URL(string: "https://example.com/image1.jpg")!, author: "Author1", date: Date(), dropEventId: "event1"),
            Drop(image: URL(string: "https://example.com/image2.jpg")!, author: "Author2", date: Date(), dropEventId: "event2")
        ])
        let mockGrouper = MockDropListGrouper()

        let viewModel = DropListViewModel(channelId: "1", getDropsUseCase: mockUseCase, dropGrouper: mockGrouper)

        viewModel.onAppear()
        viewModel.didToggle() // Switch to grouped
        viewModel.didToggle() // Switch back to all

        if case .all(let drops) = viewModel.type {
            XCTAssertEqual(drops.count, 2)
        } else {
            XCTFail("Expected all type but got \(viewModel.type)")
        }
    }
}

class MockGetDropsUseCase: GetDropsUseCaseProtocol {
    private let drops: [Drop]
    private let shouldFail: Bool

    init(drops: [Drop], shouldFail: Bool = false) {
        self.drops = drops
        self.shouldFail = shouldFail
    }

    func execute(id: String) -> Single<[Drop]> {
        if shouldFail {
            return Single.error(NSError(domain: "Test", code: -1, userInfo: nil))
        } else {
            return Single.just(drops)
        }
    }
}

class MockDropListGrouper: DropListGrouperProtocol {
    func createDropEvents(from drops: [Drop]) -> [DropEvent] {
        return drops.map { drop in
            DropEvent(id: drop.dropEventId, author: drop.author, images: [drop.image])
        }
    }
}
