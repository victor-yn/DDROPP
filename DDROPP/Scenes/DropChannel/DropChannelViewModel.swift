//
//  DropChannelViewModel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

struct DropEvent {
    let id: String
    let author: String
    let images: [URL]
}

final class DropChannelViewModel: ObservableObject {
    enum ChannelType {
        case loading
        case all(drops: [Drop])
        case grouped(events: [DropEvent])
    }
    @Published private(set) var drops: [Drop] = []
    @Published private(set) var type: ChannelType = .loading

    // We don't want to run grouping computation until the user goes there
    lazy private var dropEvents: [DropEvent] = {
        createDropEvents(from: drops)
    }()

    private let channelId: String
    private let getDropsUseCase: GetDropsUseCaseProtocol
    private let disposeBag = DisposeBag()

    init(channelId: String,
         getDropsUseCase: GetDropsUseCaseProtocol = GetDropsUseCase()) {
        self.channelId = channelId
        self.getDropsUseCase = getDropsUseCase
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

    // Encapsulates grouping logic. Here I faked some rules.
    private func createDropEvents(from drops: [Drop]) -> [DropEvent] {
        // Dictionary to group drops by dropEventId
        var groupedDrops = [String: (author: String, images: [URL])]()

        // Group drops by dropEventId
        for drop in drops {
            if var entry = groupedDrops[drop.dropEventId] {
                entry.images.append(drop.image)
                groupedDrops[drop.dropEventId] = entry
            } else {
                groupedDrops[drop.dropEventId] = (author: drop.author, images: [drop.image])
            }
        }

        // Convert the grouped dictionary to an array of DropEvent
        let dropEvents = groupedDrops.map { (key, value) in
            DropEvent(id: key, author: value.author, images: value.images)
        }

        return dropEvents
    }
}
