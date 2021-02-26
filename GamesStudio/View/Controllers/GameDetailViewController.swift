//
//  GameDetailViewController.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {
    private let gameDetailViewModel = GameDetailViewModel()
    var gameId: String = ""
    private var gameUrl: String = ""
    private var gameScreenShots: [GameScreenShots] = []
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var gameDesc: UITextView!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var screenShots: UILabel!
    @IBOutlet weak var screenShotsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGamesDetails(gameId)
        gameImageView.layer.cornerRadius = 10;
        gameImageView.clipsToBounds = true;
        gameImageView.contentMode = .scaleAspectFill
        gameTitle.isHidden = true
        publisher.isHidden = true
        developer.isHidden = true
        viewButton.isHidden = true
        screenShots.isHidden = true
        screenShotsCollectionView.register(UINib(nibName: "ScreenShotsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ScreenShotsCollectionViewCell.identifier)
    }
    
    func fetchGamesDetails(_ gameId: String) {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        activityView.startAnimating()

        self.view.addSubview(activityView)
        gameDetailViewModel.getGameDetails(gameId) {[weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.hidesWhenStopped = true
                    self?.setupData()
                }
            case .failure(_):
                print(ErrorModel.generalError())
            }
            
        }
    }

    func setupData() {
        gameTitle.isHidden = false
        publisher.isHidden = false
        developer.isHidden = false
        screenShots.isHidden = false
        let gameDetail = gameDetailViewModel.gameDetails
        thumbNailImageView.sd_setImage(with: URL(string: gameDetail.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
        gameImageView.sd_setImage(with: URL(string: gameDetail.thumbnail), placeholderImage: UIImage(named: "placeholder.png"))
        gameTitle.text = gameDetail.title
        publisher.text = gameDetail.publisher
        developer.text = gameDetail.developer
        gameDesc.text = gameDetail.description
        if(!gameDetail.game_url.isEmpty) {
            viewButton.isHidden = false
            gameUrl = gameDetail.game_url
        }
        if(gameDetail.screenshots.count > 0) {
            gameScreenShots = gameDetail.screenshots
            screenShotsCollectionView.reloadData()
        }
    }
    
    @IBAction func openInWeb(_ sender: UIButton) {
        if let url = URL(string: gameUrl) {
            UIApplication.shared.open(url)
        }
    }
}

extension GameDetailViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameScreenShots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ScreenShotsCollectionViewCell.identifier ,
                                                            for: indexPath as IndexPath) as? ScreenShotsCollectionViewCell else { return UICollectionViewCell()}
        cell.gameScreenShotModel = gameScreenShots[indexPath.row]
        cell.setSCreenShots()
        return cell
    }
    
    
}

extension GameDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 172.0, height: 177.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

}
