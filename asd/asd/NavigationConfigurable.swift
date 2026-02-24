//
//  NavigationConfigurable.swift
//  asd
//
//  Created by a on 2026/01/30.
//

import UIKit

protocol NavigationConfigurable {
    var navBarBackgroundColor: UIColor { get }

    var navBarBackgroundImage: UIImage? { get }
    
    var navBarTitleColor: UIColor { get }
    
    var navBarButtonColor: UIColor { get }
    
    var navBarAlpha: CGFloat { get }
    
    var isNavBarHidden: Bool { get }
    
    var isShadowHidden: Bool { get }
}
