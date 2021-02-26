//
//  ViewController.swift
//  GamesStudio
//
//  Created by Ravi on 24/02/21.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {
    private let viewModel = GamesListTableViewModel()
    @IBOutlet weak var gamesTableView: UITableView!
    var isLoadedIntially = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let filterImage = UIImage(named: "Filter")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openFilters))
            
        gamesTableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: GamesTableViewCell.identifier)
        isLoadedIntially = true
        getGamesList(QueryParamters.releaseDate.rawValue)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(isLoadedIntially) {
            isLoadedIntially = false
            showLoader()
        }
    }
    
    @objc func openFilters(sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let filterVC =  storyBoard.instantiateViewController(withIdentifier: "FilterVC") as? FilterViewController else { return }
        filterVC.completionBlock = { [weak self] dataReturned in
            if(dataReturned["sort"] != "" && dataReturned["filterName"] != "") {
                self?.showLoader()
                self?.filterGames(dataReturned)
            } else if(dataReturned["sort"] != "") {
                self?.showLoader()
                self?.getGamesList(dataReturned["sort"] ?? QueryParamters.releaseDate.rawValue)
            }
        }
        self.navigationController?.present(filterVC, animated: true)
     }
    
    func showLoader() {
        gamesTableView.isSkeletonable = true
        gamesTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                    animation: nil, transition: .crossDissolve(0.25))
    }
}

extension ViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return GamesTableViewCell.identifier
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier,
                                                       for: indexPath as IndexPath) as? GamesTableViewCell else { return UITableViewCell()}
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameDetailVC =  storyBoard.instantiateViewController(withIdentifier: "GameDetailVC") as? GameDetailViewController else { return }
        gameDetailVC.gameId = viewModel.gameId(index: indexPath.row)
        self.navigationController?.pushViewController(gameDetailVC, animated: true)
     }
    
}

//MARK : List of API Calls
extension ViewController {
    
    func getGamesList(_ sort: String) {
        viewModel.getGamesList(sort) { [weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self?.gamesTableView.stopSkeletonAnimation()
                    self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self?.gamesTableView.reloadData()
                })
            case .failure(_):
                print(ErrorModel.generalError())
            }
        }
    }
    
    func filterGames(_ filter: [String: String]) {
        viewModel.filterGames(filter) { [weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self?.gamesTableView.stopSkeletonAnimation()
                    self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    self?.gamesTableView.reloadData()
                })
            case .failure(_):
                print(ErrorModel.generalError())
            }
        }
    }
}




