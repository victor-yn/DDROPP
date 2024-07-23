//
//  GetDropsUseCase.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import RxSwift

protocol GetDropsUseCaseProtocol {
    func execute(id: String) -> Single<[Drop]>
}

final class GetDropsUseCase: GetDropsUseCaseProtocol {
    private let dropRepository: DropRepositoryProtocol

    init(dropRepository: DropRepositoryProtocol = DropRepository()) {
        self.dropRepository = dropRepository
    }

    func execute(id: String) -> Single<[Drop]> {
        dropRepository.getDrops(by: id)
    }
}
