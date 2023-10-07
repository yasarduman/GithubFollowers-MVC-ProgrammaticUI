//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import Foundation
// MARK: - Follower Item View Controller Delegate
protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    // MARK: - Properties
    weak var delegate: GFFollowerItemVCDelegate!
    
    // MARK: - Initialization
    init(user: User, delegate: GFFollowerItemVCDelegate){
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
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }
    
    // MARK: - Action Handling
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
