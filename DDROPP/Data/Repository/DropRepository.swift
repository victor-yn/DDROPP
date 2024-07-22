//
//  DropRepository.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

protocol DropRepositoryProtocol {
    func getDrops() -> Single<[DropChannel]>
}

final class DropRepository: DropRepositoryProtocol {
    private let dropService: DropServiceProtocol
    private let dropMapper: DropMapperProtocol

    init(dropService: DropServiceProtocol = DropService(),
         dropMapper: DropMapperProtocol = DropMapper()) {
        self.dropService = dropService
        self.dropMapper = dropMapper
    }

    func getDrops() -> Single<[DropChannel]> {
        dropService.getDrops()
            .map { dto in
                self.dropMapper.map(dto)
            }
    }
}
