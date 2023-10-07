//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import Foundation

protocol GFRepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemVC: GFItemInfoVC {
    // MARK: - Properties
    weak var delegate: GFRepoItemVCDelegate!
    
    // MARK: - Initialization
    init(user: User, delegate: GFRepoItemVCDelegate){
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - UI Configuration
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person")
    }
    
    // MARK: - Action Handling
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
      
    }
}
