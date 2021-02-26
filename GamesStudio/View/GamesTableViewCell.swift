//
//  GamesTableViewCell.swift
//  Games Studio
//
//  Created by Ravi on 24/02/21.
//

import UIKit
import SDWebImage

class GamesTableViewCell: UITableViewCell {

    static let identifier = "GamesCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDesc: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var thumbNailImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbNailImage.layer.cornerRadius = 10;
        thumbNailImage.clipsToBounds = true;
        thumbNailImage.contentMode = .scaleAspectFill
    }
    
    public var viewModel: GamesListTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            title.text = viewModel.title
            shortDesc.text = viewModel.shortDescription
            publisher.text = viewModel.publisher
            thumbNailImage.sd_setImage(with: URL(string: viewModel.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
