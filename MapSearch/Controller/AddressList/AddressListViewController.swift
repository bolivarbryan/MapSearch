//
//  AddressListViewController.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class AddressListViewController: UIViewController, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!
    var allLocationsSectionEnabled = false
    var places: [Address] = []
    let kSectionSeparator: CGFloat = 28.0
    let kAllLocationsCellIdentifier = "AllLocationsCellIdentifier"
    let kLocationCellIdentifier = "LocationCellIdentifier"
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //Empty State
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UISearchBar Delegate
    func updateSearchResults(for searchController: UISearchController) {
        APIRequests.listPlacesWithName(name: searchController.searchBar.text!) { (results) in
            self.isSearching = true
            self.places = results
            self.allLocationsSectionEnabled = self.places.count > 1
            self.tableView.reloadData()
        }
    }
}

extension AddressListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if allLocationsSectionEnabled == true {
            if section == 0 {
                return kSectionSeparator
            }else{
                return 0
            }
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
//MARK: - UITableView DataSource and Delegate Methods

extension AddressListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allLocationsSectionEnabled == true {
            if section == 0 {
                return 1
            }else{
                return places.count
            }
        }else {
            return places.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if allLocationsSectionEnabled == true {
            return 2
        }else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if allLocationsSectionEnabled == true {
            if indexPath.section == 0 {
                return allCell()
            }else{
                return locationCell(place: places[indexPath.row])
            }
        }else {
            return locationCell(place: places[indexPath.row])
        }
    }
    
    func allCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: kAllLocationsCellIdentifier)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = NSLocalizedString("Display all on Map", comment: "Display all on Map")
        return cell
    }
    
    func locationCell(place: Address) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: kLocationCellIdentifier)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = place.formattedAddress
        return cell
    }
    
}

//MARK: - Empty State
extension AddressListViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Results", attributes: nil)
    }
}
extension AddressListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isSearching
    }
}
