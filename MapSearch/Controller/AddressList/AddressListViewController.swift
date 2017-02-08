//
//  AddressListViewController.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var allLocationsSectionEnabled = true
    var locations: [Address] = []
    let kSectionSeparator: CGFloat = 28.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        //loading database registers
        locations = DatabaseManager.sharedInstance.listAllAddresses()
        self.tableView.reloadData()
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

extension AddressListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allLocationsSectionEnabled == true {
            if section == 0 {
                return 1
            }else{
                return locations.count
            }
        }else {
            return locations.count
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
                return locationCell(location: locations[indexPath.row])
            }
        }else {
            return locationCell(location: locations[indexPath.row])
        }
    }
    
    func allCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "AllLocationsCellIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = "Display all on Map"
        return cell
    }
    
    func locationCell(location: Address) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "LocationCellIdentifier")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = location.name
        return cell
    }
    
    
}
