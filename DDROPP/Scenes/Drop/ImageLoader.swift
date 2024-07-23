//
//  ImageLoader.swift
//  DDROPP
//
//  Created by Victor YAN on 22/07/2024.
//

import SwiftUI
import PhotosUI

class ImageLoader: ObservableObject {
    @Published var selectedImages: [UIImage] = []

    func loadImages(from results: [PHPickerResult], completion: @escaping () -> Void) {
        selectedImages.removeAll()
        let dispatchGroup = DispatchGroup()
        results
            .filter { $0.itemProvider.canLoadObject(ofClass: UIImage.self) }
            .forEach { item in
                dispatchGroup.enter()
                item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    defer { dispatchGroup.leave() }
                    if let uiImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.selectedImages.append(uiImage)
                        }
                    }
                }
            }
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
