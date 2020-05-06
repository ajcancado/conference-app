//
//  EventCell.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alreadySubscribeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = ""
        alreadySubscribeView.isHidden = true
    }
}
