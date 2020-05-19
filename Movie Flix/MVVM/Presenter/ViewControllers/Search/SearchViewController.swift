//
//  SearchViewController.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var moviesCollectionView: UICollectionView?

    private let searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {

        self.searchViewModel.viewController = self
        setDelegates()
        registerXibs()
    }
    
    private func setDelegates() {
        moviesCollectionView?.delegate = self
        moviesCollectionView?.dataSource = self
        searchBar?.delegate = self
    }
    
    private func registerXibs() {
        moviesCollectionView?.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    internal func fetchMovies(urlString: String) {
        searchViewModel.fetchMovies(urlString: urlString)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
    }

    private func setupNib() {
        self.view = self.loadNib()
    }
    
    private func loadNib() -> UIView {
        let nibName = "SearchViewController"
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowCancel(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        shouldShowCancel(false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.filerMoviesBy(name: searchText)
    }
    
    func shouldShowCancel(_ shouldShow: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.searchBar?.showsCancelButton = shouldShow
            self?.view.layoutIfNeeded()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchViewModel.filerMoviesBy(name: "")
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = moviesCollectionView?.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let currentMovie = searchViewModel.movies?[indexPath.row]
        movieCell.movieModel = currentMovie
        return movieCell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBar?.resignFirstResponder()
        let detailsViewController = MovieDetailsViewController()
        let detailViewModel = DetailViewModel()
        detailViewModel.movie = searchViewModel.movies?[indexPath.row]
        detailsViewController.viewModel = detailViewModel
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
