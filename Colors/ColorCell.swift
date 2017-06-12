//
//  ColorCell.swift
//  Colors
//
//  Created by Thiago Lioy on 12/06/17.
//  Copyright © 2017 Thiago Lioy. All rights reserved.
//

import UIKit
import Reusable

class ColorCell: UITableViewCell {
    
    @IBOutlet weak var colorContainer: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    func setup(with color: Color) {
        colorLabel.text = color.name
        colorContainer.backgroundColor = color.color
    }
}

extension ColorCell: Reusable {}
