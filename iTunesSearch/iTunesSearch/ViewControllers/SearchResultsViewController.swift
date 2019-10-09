//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Chance Payne on 10/5/19.
//  Copyright © 2019 Chance Payne. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    var searchResultController = SearchResultController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        buildUiSegmentedControl()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func buildUiSegmentedControl() {
        for i in 0...ResultType.types.count - 1 {
            if i < typeController.numberOfSegments {
                typeController.setTitle(Array(ResultType.types.keys)[i], forSegmentAt: i)
            } else {
                typeController.insertSegment(withTitle: Array(ResultType.types.keys)[i], at: i, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.searchResultController.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        // Configure the cell...
        cell.searchResult = searchResultController.searchResults[indexPath.row]
        
        return cell
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
        let resultType = self.typeController.titleForSegment(at: self.typeController.selectedSegmentIndex) else { return }
        
//        guard let resultType = self.typeController.titleForSegment(at: self.typeController.selectedSegmentIndex)
        
        self.searchResultController.performSearch(search: searchTerm, resultType: ResultType.types[resultType]!) { error in
            //NSLog(self.searchResultController.searchResults[0].title)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
}
