//
//  MovieCell.swift
//  Flix App Pt 1
//
//  Created by Ayon Paul on 2/13/21.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var synopsisView: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
