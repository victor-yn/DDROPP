//
//  DropRepository.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

protocol DropRepositoryProtocol {
    func getDropChannels() -> Single<[DropChannel]>
    func getDrops(by id: String) -> Single<[Drop]>
}

final class DropRepository: DropRepositoryProtocol {
    private let dropService: DropServiceProtocol
    private let dropMapper: DropMapperProtocol

    init(dropService: DropServiceProtocol = DropService(),
         dropMapper: DropMapperProtocol = DropMapper()) {
        self.dropService = dropService
        self.dropMapper = dropMapper
    }

    func getDropChannels() -> Single<[DropChannel]> {
        dropService.getDropChannels()
            .map { dto in
                self.dropMapper.map(dto)
            }
    }

    func getDrops(by id: String) -> Single<[Drop]> {
        dropService.getDrops(by: id)
            .map { dto in
                self.dropMapper.map(dto)
            }
    }
}
