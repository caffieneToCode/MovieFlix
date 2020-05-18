//
//  MovieDetailsViewController.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    var viewModel: DetailViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        if let backDropPath = viewModel?.movie?.backdropPath {
            let backDropImageUrlString = UrlStrings.imgBase + "original" + backDropPath
            guard let backDropImageUrl = URL(string: backDropImageUrlString) else { return }
            backDropImageView.downloadImage(from: backDropImageUrl, placeholderImage: UIImage(named: "reel"))
        }
    }
}
