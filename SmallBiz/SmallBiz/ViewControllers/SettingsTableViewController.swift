//
//  SettingsTableViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 9/1/22.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    lazy var datasource: [SettingsItem] = {
        var item = SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)
        item.readDefaults()
        var secondItem = SettingsItem(settingTitle: "Default Items", isActive: false, type: .disclosure)
        return [item, secondItem]
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datasource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = datasource[indexPath.row]

        switch item.type {
            
        case .toggleSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.item = item
            cell.delegate = self
            return cell
            
        case .disclosure:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as? DisclosureTableViewCell else { return UITableViewCell() }
            cell.disclosureCellLabel.text = item.settingTitle
            
            return cell
        }
    }
}

extension SettingsTableViewController: SettingChangedProtocol {
    func settingToggled(item: SettingsItem) {
        let defaults = UserDefaults.standard
        defaults.set(!item.isActive, forKey: item.settingTitle)
        
    }
}

struct SettingsItem {
    var settingTitle: String
    var isActive: Bool
    var type: SettingCellType
    
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

enum SettingCellType {
    case toggleSwitch
    case disclosure
}
