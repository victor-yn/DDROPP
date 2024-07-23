//
//  DropChannelViewModel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

struct DropEvent: Equatable {
    let id: String
    let author: String
    let images: [URL]
}

final class DropListViewModel: ObservableObject {
    enum ChannelType: Equatable {
        case loading
        case all(drops: [Drop])
        case grouped(events: [DropEvent])
    }
    @Published private(set) var drops: [Drop] = []
    @Published private(set) var type: ChannelType = .loading

    // We don't want to run grouping computation until the user goes there
    lazy private var dropEvents: [DropEvent] = {
        dropGrouper.createDropEvents(from: drops)
    }()

    private let channelId: String
    private let getDropsUseCase: GetDropsUseCaseProtocol
    private let dropGrouper: DropListGrouperProtocol
    private let disposeBag = DisposeBag()

    init(channelId: String,
         getDropsUseCase: GetDropsUseCaseProtocol = GetDropsUseCase(),
         dropGrouper: DropListGrouperProtocol = DropListGrouper()) {
        self.channelId = channelId
        self.getDropsUseCase = getDropsUseCase
        self.dropGrouper = dropGrouper
    }

    func onAppear() {
        fetchDrops()
    }

    func didToggle() {
        switch type {
        case .all:
            type = .grouped(events: dropEvents)
        case .grouped:
            type = .all(drops: drops)
        case .loading: break
        }
    }

    private func fetchDrops() {
        type = .loading
        getDropsUseCase.execute(id: channelId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] drops in
                print("Received \(drops.count) drops!")
                self?.type = .all(drops: drops)
                self?.drops = drops
            }, onFailure: { error in
                // todo: Handle error state
            })
            .disposed(by: disposeBag)
    }
}
