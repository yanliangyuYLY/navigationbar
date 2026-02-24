//
//  ScrollGradientVC.swift
//  asd
//
//  Created by a on 2026/01/30.
//

import UIKit
import SnapKit

class ScrollGradientVC: BaseViewController {
    
    private var currentAlpha: CGFloat = 0.0
    
    private let gradientLayer = CAGradientLayer()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "滚动渐变页"
        setupUI()
        setupContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    private func setupUI() {
        gradientLayer.colors = [
            UIColor(red: 0.9, green: 0.5, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 0.9, green: 0.7, blue: 0.4, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(scrollView)
        if #available(iOS 26.0, *) {
            scrollView.topEdgeEffect.isHidden = true
        }
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view)
        }
    }
    
    private func setupContent() {
        let label = UILabel()
        label.text = "向上滚动查看导航栏渐变效果\n\n导航栏会从透明变为白色\n标题会从白色变为黑色\n状态栏样式也会动态切换"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        
        var lastView: UIView = label
        
        for i in 1...10 {
            let box = UIView()
            box.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            box.layer.cornerRadius = 12
            
            let boxLabel = UILabel()
            boxLabel.text = "内容区域 \(i)"
            boxLabel.textAlignment = .center
            boxLabel.textColor = .white
            boxLabel.font = .systemFont(ofSize: 16, weight: .medium)
            
            box.addSubview(boxLabel)
            contentView.addSubview(box)
            
            box.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(lastView.snp.bottom).offset(100)
                make.height.equalTo(80)
            }
            
            boxLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            lastView = box
        }
        
        lastView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    
    override var navBarBackgroundColor: UIColor {
        return .white
    }

    override var navBarAlpha: CGFloat {
        return currentAlpha
    }

    override var navBarTitleColor: UIColor {
        return UIColor(
            red: 1 - currentAlpha,
            green: 1 - currentAlpha,
            blue: 1 - currentAlpha,
            alpha: 1.0
        )
    }
    
    override var navBarButtonColor: UIColor {
//        if #available(iOS 26.0, *) {
//            return .black
//        }
//        return currentAlpha > 0.5 ? .black : .white
        
        return UIColor(
            red: 1 - currentAlpha,
            green: 1 - currentAlpha,
            blue: 1 - currentAlpha,
            alpha: 1.0
        )
    }

    override var isShadowHidden: Bool {
        return true
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentAlpha > 0.5 ? .darkContent : .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if gradientLayer.frame != view.bounds {
            gradientLayer.frame = view.bounds
        }
    }
}

extension ScrollGradientVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let maxOffset: CGFloat = 100.0
        
        let alpha = min(max(offsetY / maxOffset, 0), 1)
        
        currentAlpha = alpha
        
        refreshNavigationBarAppearance()
        setNeedsStatusBarAppearanceUpdate()
    }
}
