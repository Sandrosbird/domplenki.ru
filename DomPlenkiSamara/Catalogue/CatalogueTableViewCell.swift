//
//  CatalogueTableViewCell.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 22.01.2021.
//

import UIKit

class CatalogueTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    @IBOutlet weak var cellActionPrice: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
