//
//  OrderTableViewCell.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 01.02.2021.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellTextField: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configureFields()
        // Initialization code
    }
    
    private func configureFields() {
        StyleButtonsFields.styleTextField(cellTextField)
    }
}
