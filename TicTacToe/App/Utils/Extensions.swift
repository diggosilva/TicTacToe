//
//  Extensions.swift
//  TicTacToe
//
//  Created by Diggo Silva on 23/12/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }
}
