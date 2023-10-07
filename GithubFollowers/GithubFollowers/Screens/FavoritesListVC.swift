//
//  FavoritesListVC.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
    // MARK: - Properties
    let tableView             = UITableView()
    var favorites: [Follower] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    // MARK: - UI Configuration
    func configureViewController() {
        view.backgroundColor  = .systemBlue
        title                 = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame       = view.bounds
        tableView.rowHeight   = 80
        tableView.delegate    = self
        tableView.dataSource  = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    // MARK: - Data Retrieval
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                //print("----->>>> DEBUG: \(favorites)")
                self.updateUI(with: favorites)
               
            case .failure(let error):
                //print("----->>>> DEBUG: \(error)")
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    // MARK: - UI Updates
    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
        }else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = favorites[indexPath.row]
        let destVC      = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self  = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unablo to remove", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}
