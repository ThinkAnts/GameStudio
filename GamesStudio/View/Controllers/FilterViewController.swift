//
//  FilterViewController.swift
//  GamesStudio
//
//  Created by Ravi on 25/02/21.
//

import UIKit
typealias appliedFilters = (_ selectedFilters : [String: String]) ->()

class FilterViewController: UIViewController {

    var completionBlock: appliedFilters?
    var listOfPlatforms: [String] = ["PC", "Browser"]
    var listOfCategories: [String] = ["MMORPG", "Strategy", "Shooter", "MOBA", "Fighting", "Social", "Sports", "Card Game", "Battle Royale", "Card"]
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filtersTableView: UITableView!

    private var filterName: String = ""
    private var sortSelected: String = QueryParamters.releaseDate.rawValue
    private var filterSelected: String = QueryParamters.platform.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filtersTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: FilterTableViewCell.identifier)
        filtersTableView.tableFooterView = UIView()
    }
    
    @IBAction func sortSegChanged(_ sender: UISegmentedControl) {
        switch sortSegmentedControl.selectedSegmentIndex
        {
        case 0:
            sortSelected = QueryParamters.releaseDate.rawValue
            break
        case 1:
            sortSelected = QueryParamters.alphabetical.rawValue
            break
        case 2:
            sortSelected = QueryParamters.relevance.rawValue
            break
        default:
            break;
        }
    }
    
    @IBAction func filterSegChanged(_ sender: UISegmentedControl) {
        switch filterSegmentedControl.selectedSegmentIndex
        {
        case 0:
            filterSelected = QueryParamters.platform.rawValue
            break
        case 1:
            filterSelected = QueryParamters.category.rawValue
            break
        //show history view
        default:
            break;
        }
        filtersTableView.reloadData()
    }
    
    @IBAction func applyFilterAction(_ sender: UIButton) {
        guard let callBack = completionBlock else {return}
        let dic = ["sort": sortSelected, "filter": filterSelected, "filterName": filterName.lowercased()]
        callBack(dic)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filterSelected == QueryParamters.category.rawValue) {
            return listOfCategories.count
        } else {
            return listOfPlatforms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier,
                                                       for: indexPath as IndexPath) as? FilterTableViewCell else { return UITableViewCell()}
        if(filterSelected == QueryParamters.category.rawValue) {
            cell.title.text = listOfCategories[indexPath.row]
        } else {
            cell.title.text = listOfPlatforms[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(filterSelected == QueryParamters.category.rawValue) {
            filterName = listOfCategories[indexPath.row]
        } else {
            filterName = listOfPlatforms[indexPath.row]
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
