//
//  ScreenShotsCollectionViewCell.swift
//  GamesStudio
//
//  Created by Ravi on 26/02/21.
//

import UIKit
import SDWebImage

class ScreenShotsCollectionViewCell: UICollectionViewCell {

    static let identifier = "Screenshotscell"
    
    @IBOutlet weak var screenShotImageView: UIImageView!
    var gameScreenShotModel: GameScreenShots?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        screenShotImageView.layer.cornerRadius = 10;
        screenShotImageView.clipsToBounds = true;
        screenShotImageView.contentMode = .scaleAspectFill
    }

    func setSCreenShots() {
        screenShotImageView.sd_setImage(with: URL(string: gameScreenShotModel?.image ?? ""), placeholderImage: UIImage(named: "thumbnail"))
    }
}
