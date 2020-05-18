//
//  NowPlayingViewController.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import UIKit

class NowPlayingViewController: SearchViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = UrlStrings.baseUrl + UrlStrings.nowPlaying + UrlStrings.apiKey
        fetchMovies(urlString: urlString)
    }
}
