//
//  SettingsTableViewCell.swift
//  SmallBiz
//
//  Created by Colton Swapp on 9/1/22.
//

import UIKit

protocol SettingChangedProtocol: AnyObject {
    func settingToggled(item: SettingsItem)
}

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsNameLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    weak var delegate: SettingChangedProtocol?
    
    var item: SettingsItem! {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        settingsNameLabel.text = item.settingTitle
        settingsSwitch.isOn = item.isActive
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchToggled(_ sender: Any) {
        delegate?.settingToggled(item: item)
    }
}
