//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    // MARK: - Properties
    let scrollView          = UIScrollView()
    let contenView          = UIView()
    
    var username: String!
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()

    var itemViews: [UIView] = []
    let dateLabel      = GFBodyLabel(textAlignment: .center)
    weak var delegate: UserInfoVCDelegate!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
  
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    // MARK: - Configuration
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        
        scrollView.pinToEdges(of: view)
        contenView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contenView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contenView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    // MARK: - Network
    func getUserInfo() {
        
        Task{
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: "Something Went Wrong !", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefualtError()
                }
            }
        }
    }
    
    // MARK: - UI Configuration
    func configureUIElements(with user: User) {
        self.add(childeVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childeVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childeVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Created At: \(user.createdAt.convertToMonthYearFormat())"
    }
    
    // MARK: - Layout
    func layoutUI() {
        
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contenView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -padding)
            ])
        }
    
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contenView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
        
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childeVC: UIViewController, to containerView: UIView) {
        addChild(childeVC)
        containerView.addSubview(childeVC.view)
        childeVC.view.frame = containerView.bounds
        childeVC.didMove(toParent: self)
    }
    
    // MARK: - Actions
    @objc func dismssVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(title: "Invalid URL", message: "the url attached to this url is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }

}

// MARK: - Extensions
extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlert(title: "No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dismssVC()
    }
}





















































