//
//  GetDropChannelsUseCase.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import RxSwift

protocol GetDropChannelsUseCaseProtocol {
    func execute() -> Single<[DropChannel]>
}

final class GetDropChannelsUseCase: GetDropChannelsUseCaseProtocol {
    private let dropRepository: DropRepositoryProtocol

    init(dropRepository: DropRepositoryProtocol = DropRepository()) {
        self.dropRepository = dropRepository
    }

    func execute() -> Single<[DropChannel]> {
        dropRepository.getDropChannels()
    }
}
