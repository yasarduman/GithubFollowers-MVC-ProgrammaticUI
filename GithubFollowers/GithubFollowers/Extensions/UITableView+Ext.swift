//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 6.10.2023.
//

import UIKit

extension UITableView {
    // MARK: - Reload Data on Main Thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    // MARK: - Remove Excess Cells
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
