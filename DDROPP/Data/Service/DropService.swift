//
//  DropService.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

protocol DropServiceProtocol {
    func getDrops() -> Single<GetDropsResponseDTO>
}

final class DropService: DropServiceProtocol {
    // TODO
    // let networkService: NetworkServiceProtocol
    //
    //    init(networkService: NetworkServiceProtocol = NetworkService()) {
    //        self.networkService = networkService
    //    }

    init() { }

    func getDrops() -> Single<GetDropsResponseDTO> {
        // Simulating a real API call
//        Single.create { observer in
//            observer(.success(
//                GetDropsResponseDTO(data: [
//                    DropChannelDTO(id: "mock", name: "Irlande", newDropsCount: "30"),
//                    DropChannelDTO(id: "yay", name: "We goin' hiking", newDropsCount: "3"),
//                    DropChannelDTO(id: "woof", name: "Dodo", newDropsCount: "OOPS! This is not good"), // Should be skipped by the validation rules in the Mapper
//                    DropChannelDTO(id: "doggo", name: "Woo!", newDropsCount: "0"),
//                    DropChannelDTO(id: "ads", name: "I like coffee", newDropsCount: "0"),
//                    DropChannelDTO(id: "dogssso", name: "Windows!", newDropsCount: "0"),
//                    DropChannelDTO(id: "doggdsdo", name: "Plante verte", newDropsCount: "0")
//                ])
        //                )
        //            )
        //            return Disposables.create()
        //        }

        Single.just(
            GetDropsResponseDTO(data: [
                DropChannelDTO(id: "mock", name: "Irlande", newDropsCount: "30"),
                DropChannelDTO(id: "yay", name: "We goin' hiking", newDropsCount: "3"),
                DropChannelDTO(id: "woof", name: "Dodo", newDropsCount: "OOPS! This is not good"), // Should be skipped by the validation rules in the Mapper
                DropChannelDTO(id: "doggo", name: "Woo!", newDropsCount: "0"),
                DropChannelDTO(id: "ads", name: "I like coffee", newDropsCount: "0"),
                DropChannelDTO(id: "dogssso", name: "Windows!", newDropsCount: "0"),
                DropChannelDTO(id: "doggdsdo", name: "Plante verte", newDropsCount: "0")
            ])
        ).delay(.seconds(2), scheduler: MainScheduler.instance)
    }
}

