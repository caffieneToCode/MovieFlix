//
//  SearchViewModel.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/18/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//
import Foundation

class SearchViewModel: NSObject {
    
    weak var viewController: SearchViewController?
    
    var movies: [Movie]? {
        didSet {
            DispatchQueue.main.async {
                self.viewController?.moviesCollectionView?.reloadData()
            }
        }
    }
    
    private var searchResults: [Movie]? {
        didSet {
            movies = searchResults ?? [Movie]()
        }
    }
    
    func fetchMovies(urlString: String) {
        NetworkManager.sharedInstance.makeRequestWithURL(urlString: urlString, type: .get, parameters: nil) { [weak self] (data) in
            do {
                let responseModel = try JSONDecoder.snakeCaseDecoder.decode(MoviesResponseModel.self, from: data!)
                if let movies = responseModel.results {
                    self?.searchResults = movies
                    DispatchQueue.main.async {
                        self?.viewController?.moviesCollectionView?.reloadData()
                    }
                }
            } catch {
                debugPrint("Unable to fetch movie list")
            }
        }
    }
    
    func filerMoviesBy(name: String) {
        guard !name.isEmpty, let moviesArray = searchResults else {
            movies = searchResults ?? [Movie]()
            return
        }
        movies = moviesArray.filter { item in
            guard let movie = item as? Movie, let movieTitle = movie.title  else { return false }
            return movieTitle.lowercased().contains(name.lowercased())
        }
    }
}
