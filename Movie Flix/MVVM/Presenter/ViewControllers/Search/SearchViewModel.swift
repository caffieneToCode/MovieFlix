//
//  SearchViewModel.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/18/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//
import Foundation

class SearchViewModel: NSObject {
    
    var movies = Binder(val: [Movie]())
    private var responseData: [Movie]? {
        didSet {
            movies.value = responseData ?? [Movie]()
        }
    }
    
    typealias MoviesFetched = (() -> ())
    var moviesFetched: MoviesFetched?
    
    func fetchMovies(urlString: String) {
        NetworkManager.sharedInstance.makeRequestWithURL(urlString: urlString, type: .get, parameters: nil) { [weak self] (data) in
            do {
                let responseModel = try JSONDecoder.snakeCaseDecoder.decode(MoviesResponseModel.self, from: data!)
                if let movies = responseModel.results {
                    self?.responseData = movies
                }
            } catch {
                debugPrint("Unable to fetch movie list")
            }
        }
    }
    
    func filerMoviesBy(name: String) {
        guard !name.isEmpty, let moviesArray = responseData else {
            movies.value = responseData ?? [Movie]()
            return
        }
        movies.value = moviesArray.filter { item in
            guard let movie = item as? Movie, let movieTitle = movie.title  else { return false }
            return movieTitle.lowercased().contains(name.lowercased())
        }
    }
}
