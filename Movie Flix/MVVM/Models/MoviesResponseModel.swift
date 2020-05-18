//
//  NowPlayingModel.swift
//  Movie Flix
//
//  Created by Ashish Verma on 5/17/20.
//  Copyright © 2020 Ashish Verma. All rights reserved.
//

import Foundation

// MARK: - NowPlayingModel
struct MoviesResponseModel: Codable {
    let page, totalResults, totalPages: Int?
    let dates: Dates?
    let results: [Movie]?
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ko = "ko"
}
