//
//  ImageVC.swift
//  asd
//
//  Created by a on 2026/01/30.
//

import UIKit

class ImageVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图片背景页"
        view.backgroundColor = .systemGray6
        
        let label = UILabel()
        label.text = "导航栏使用渐变图片背景\n标题为白色\n状态栏为浅色模式"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override var navBarBackgroundImage: UIImage? {
        return createGradientImage()
    }
    
    override var navBarTitleColor: UIColor {
        return .white
    }
    
    override var navBarButtonColor: UIColor {
        return .white
    }
    
    override var isShadowHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func createGradientImage() -> UIImage? {
        let bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let colors = [
            UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0).cgColor,
            UIColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1.0).cgColor
        ]
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: colors as CFArray,
                                       locations: [0.0, 1.0]) else { return nil }
        
        context.drawLinearGradient(gradient,
                                  start: CGPoint(x: 0, y: 0),
                                  end: CGPoint(x: bounds.width, y: 0),
                                  options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
