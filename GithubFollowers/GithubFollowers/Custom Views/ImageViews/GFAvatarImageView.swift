//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    // MARK: - Properties
    let cache            = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Image Download
    func downloadImage(fromURL url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }    
}
