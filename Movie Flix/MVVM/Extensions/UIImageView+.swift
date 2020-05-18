//
//  UIImageView+.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL, placeholderImage: UIImage?) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage
                } else {
                    self.image = placeholderImage
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
