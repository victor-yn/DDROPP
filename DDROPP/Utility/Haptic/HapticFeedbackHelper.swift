//
//  HapticFeedback.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import UIKit

protocol HapticFeedbackHelperProtocol {
    func triggerSuccess()
}

final class HapticFeedbackHelper: HapticFeedbackHelperProtocol {

    private let feedbackGenerator: UINotificationFeedbackGenerator

    init(feedbackGenerator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()) {
        self.feedbackGenerator = feedbackGenerator
    }

    func triggerSuccess() {
        feedbackGenerator.notificationOccurred(.success)
    }
}
