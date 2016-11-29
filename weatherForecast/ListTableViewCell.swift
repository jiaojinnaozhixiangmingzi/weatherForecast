//
//  ListTableViewCell.swift
//  weatherForecast
//
//  Created by 王阿星 on 2016/11/29.
//  Copyright © 2016年 wanghaixin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var serchInput: UITextField!
    @IBOutlet weak var hotBbuttonForBeijing: UILabel!
    @IBOutlet weak var hotBbuttonForShanghai: UILabel!
    @IBOutlet weak var hotBbuttonForTianjin: UILabel!
    @IBOutlet weak var hotBbuttonForJinan: UILabel!
    @IBOutlet weak var hotBbuttonForDalian: UILabel!
    @IBOutlet weak var hotBbuttonForChangchun: UILabel!
    @IBOutlet weak var hotBbuttonForChongqing: UILabel!
    @IBOutlet weak var hotBbuttonForNanjing: UILabel!
    @IBOutlet weak var hotBbuttonForShenyang: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
