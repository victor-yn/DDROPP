//
//  DropChannelListViewModelTests.swift
//  DDROPPTests
//
//  Created by Victor YAN on 23/07/2024.
//

import XCTest
import RxSwift
import Combine

@testable import DDROPP

class DropChannelListViewModelTests: XCTestCase {

    func testFetchChannels_success() throws {
        let mockUseCase = MockGetDropChannelsUseCase(channels: [
            DropChannel(id: "1", name: "Hot Channel 1", newDropsCount: 10, lastDropImage: nil),
            DropChannel(id: "2", name: "Quiet Channel 1", newDropsCount: 0, lastDropImage: nil),
            DropChannel(id: "3", name: "Hot Channel 2", newDropsCount: 5, lastDropImage: nil)
        ])
        let viewModel = DropChannelListViewModel(getDropChannelsUseCase: mockUseCase)

        let expectation = XCTestExpectation(description: "Fetching channels")

        // Bind to the changes in the ViewModel properties
        viewModel.$isLoading.sink { isLoading in
            if !isLoading {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.onAppear()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(viewModel.hotChannels.count, 2)
        XCTAssertEqual(viewModel.quietChannels.count, 1)
        XCTAssertEqual(viewModel.newDrops, 15)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchChannels_failure() throws {
        /* ... behavior not implemented ... */
    }

    private var cancellables = Set<AnyCancellable>()
}

class MockGetDropChannelsUseCase: GetDropChannelsUseCaseProtocol {
    private let channels: [DropChannel]
    private let shouldFail: Bool

    init(channels: [DropChannel], shouldFail: Bool = false) {
        self.channels = channels
        self.shouldFail = shouldFail
    }

    func execute() -> Single<[DropChannel]> {
        if shouldFail {
            return Single.error(NSError(domain: "Test", code: -1, userInfo: nil))
        } else {
            return Single.just(channels)
        }
    }
}
