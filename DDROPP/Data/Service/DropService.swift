//
//  DropService.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

protocol DropServiceProtocol {
    func getDropChannels() -> Single<[DropChannelDTO]>
    func getDrops(by id: String) -> Single<[DropDTO]>
}

final class DropService: DropServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func getDropChannels() -> Single<[DropChannelDTO]> {
        networkService.get(path: "/channel")
    }

    func getDrops(by id: String) -> Single<[DropDTO]> {
        networkService.get(path: "/drop")
    }
}
