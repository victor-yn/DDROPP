//
//  ReviewDropViewModel.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import Foundation
import RxSwift

final class ReviewDropViewModel: ObservableObject {
    @Published var navigateToSuccess = false
    private let disposeBag = DisposeBag()

    func onSubmitTap() {
        uploadImages()
    }

    private func uploadImages() {
        /* upload work */
        Single<Void>.just(())
            .subscribe(onSuccess: { [weak self] _ in
                self?.navigateToSuccess = true
            }, onFailure: { _ in
                // ToDo: implement error
            }).disposed(by: disposeBag)
    }
}
