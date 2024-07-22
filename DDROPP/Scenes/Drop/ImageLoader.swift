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

        for item in results {
            if item.itemProvider.canLoadObject(ofClass: UIImage.self) {
                dispatchGroup.enter()
                item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let uiImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.selectedImages.append(uiImage)
                        }
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }
}
