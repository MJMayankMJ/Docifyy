//
//  SearchViewModel.swift
//  BookAppointment
//
//  Created by Mayank Jangid on 15/05/25.
//

import Foundation

protocol SearchNavigationDelegate: AnyObject {
    
}


protocol SearchViewModelProtocol {
    var navigationDelegate: SearchNavigationDelegate? {get set}
    var query: String? {get set}
}

class SearchViewModel: SearchViewModelProtocol {
    var navigationDelegate: SearchNavigationDelegate?
    var query: String?

    init(query: String) {
        self.query = query
    }
}
