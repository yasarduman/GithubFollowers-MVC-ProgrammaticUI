//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit

enum UIHelper {
    // MARK: - Three Column Flow Layout
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let avaibleWidth                = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = avaibleWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
