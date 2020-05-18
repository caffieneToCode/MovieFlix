//
//  MovieCell.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var movieModel: Movie? {
        didSet {
            setCell()
        }
    }
    
    private func setCell() {
        self.titleLabel?.text = movieModel?.title
        self.descriptionLabel?.text = movieModel?.overview
        if let posterPath = movieModel?.posterPath {
            let posterUrlString = UrlStrings.imgBase + UrlStrings.defaultPosterSize + posterPath
            guard let url = URL(string: posterUrlString) else { return }
            self.posterImageView?.downloadImage(from: url, placeholderImage: UIImage(named: "reel"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
