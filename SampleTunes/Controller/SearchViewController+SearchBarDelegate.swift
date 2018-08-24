//
//  SearchViewController+SearchBarDelegate.swift
//  SampleTunes
//
//  Created by Abraham, Aneesh on 8/22/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            queryService.getSearchResults(searchTerm: searchBar.text!) { results, errorMessage in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if let results = results {
                    self.searchResults = results
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(CGPoint.zero, animated: false)
                }
                if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
            }
        }
    }
}
