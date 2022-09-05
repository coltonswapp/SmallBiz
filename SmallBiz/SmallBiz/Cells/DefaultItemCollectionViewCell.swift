//
//  DefeultItemCollectionViewCell.swift
//  SmallBiz
//
//  Created by Colton Swapp on 9/2/22.
//

import UIKit

class DefaultItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var defaultItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
    }
}
