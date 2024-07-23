//
//  DropListViewModel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

final class DropChannelListViewModel: ObservableObject {
    @Published private(set) var hotChannels: [DropChannel] = []
    @Published private(set) var quietChannels: [DropChannel] = []
    @Published private(set) var newDrops = 0
    @Published private(set) var isLoading: Bool = false

    private let getDropChannelsUseCase: GetDropChannelsUseCaseProtocol
    private let disposeBag = DisposeBag()

    init(getDropChannelsUseCase: GetDropChannelsUseCaseProtocol = GetDropChannelsUseCase()) {
        self.getDropChannelsUseCase = getDropChannelsUseCase
    }

    func onAppear() {
        fetchChannels()
    }

    private func fetchChannels() {
        isLoading = true
        getDropChannelsUseCase.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] channels in
                print("Received \(channels.count) channels!")
                self?.isLoading = false
                self?.set(channels: channels)
                self?.hotChannels = channels.filter { $0.newDropsCount > 0 }
                self?.quietChannels = channels.filter { $0.newDropsCount == 0 }
            }, onFailure: { error in
                // todo: Handle error state
            })
            .disposed(by: disposeBag)
    }

    // Run rules to separate the different datasource based on our own business logic.
    // This should be within the ViewModel rather than having the rule at the View layer
    private func set(channels: [DropChannel]) {
        var hotChannels: [DropChannel] = []
        var quietChannels: [DropChannel] = []
        for channel in channels {
            if channel.newDropsCount > 0 {
                hotChannels.append(channel)
                newDrops += channel.newDropsCount
            } else {
                quietChannels.append(channel)
            }
        }
        self.hotChannels = hotChannels
        self.quietChannels = quietChannels
    }
}
