//
//  BaseViewController.swift
//  asd
//
//  Created by a on 2026/01/30.
//

import UIKit

class BaseViewController: UIViewController, NavigationConfigurable {
    
    var navBarBackgroundColor: UIColor {
        return .white
    }
    
    var navBarBackgroundImage: UIImage? {
        return nil
    }
    
    var navBarTitleColor: UIColor {
        return .black
    }
    
    var navBarButtonColor: UIColor {
        return .black
    }

    var navBarAlpha: CGFloat {
        return 1.0
    }
    
    var isNavBarHidden: Bool {
        return false
    }
    
    var isShadowHidden: Bool {
        return false
    }
    
    private lazy var customNavBarBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var navBarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.separator
        return view
    }()
    
    private var backgroundHeightConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBarBackground()
        setupCustomBackButton()
        

        let barItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(rightButtonTapped))

        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func rightButtonTapped() {
        print("右侧按钮被点击")
    }
    
    private func setupCustomBackButton() {
        guard let navigationController = navigationController,
              navigationController.viewControllers.count > 1,
              navigationController.viewControllers.first != self else {
            return
        }
        
        navigationItem.hidesBackButton = true
        
        let backButton = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        let backImage = UIImage(systemName: "chevron.backward", withConfiguration: config)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = navBarButtonColor
        
        backButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNavBarBackground() {

        view.addSubview(customNavBarBackgroundView)
        customNavBarBackgroundView.addSubview(navBarImageView)
        customNavBarBackgroundView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            customNavBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            navBarImageView.topAnchor.constraint(equalTo: customNavBarBackgroundView.topAnchor),
            navBarImageView.bottomAnchor.constraint(equalTo: customNavBarBackgroundView.bottomAnchor),
            navBarImageView.leadingAnchor.constraint(equalTo: customNavBarBackgroundView.leadingAnchor),
            navBarImageView.trailingAnchor.constraint(equalTo: customNavBarBackgroundView.trailingAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: customNavBarBackgroundView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: customNavBarBackgroundView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: customNavBarBackgroundView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
        ])
        
        backgroundHeightConstraint = customNavBarBackgroundView.heightAnchor.constraint(equalToConstant: 0)
        backgroundHeightConstraint?.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(isNavBarHidden, animated: animated)
        
        view.bringSubviewToFront(customNavBarBackgroundView)
        
        updateNavigationBarAppearance()
        
        if let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.updateNavigationBarAppearance()
            }, completion: { [weak self] context in
                if !context.isCancelled {
                    self?.updateNavigationBarAppearance()
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(customNavBarBackgroundView)
        
        if let navBar = navigationController?.navigationBar {
            let navBarFrame = navBar.convert(navBar.bounds, to: view)
            if backgroundHeightConstraint?.constant != navBarFrame.maxY {
                backgroundHeightConstraint?.constant = navBarFrame.maxY
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateNavigationBarAppearance()
    }

    private func updateNavigationBarAppearance() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        if let backgroundImage = navBarBackgroundImage {
            navBarImageView.image = backgroundImage
            navBarImageView.isHidden = false
            customNavBarBackgroundView.backgroundColor = .clear
        } else {
            navBarImageView.isHidden = true
            customNavBarBackgroundView.backgroundColor = navBarBackgroundColor.withAlphaComponent(navBarAlpha)
            customNavBarBackgroundView.isHidden = isNavBarHidden
        }
        
        separatorView.isHidden = isShadowHidden
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundImage = UIImage()
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        appearance.titleTextAttributes = [.foregroundColor: navBarTitleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: navBarTitleColor]
        
        navigationBar.tintColor = navBarButtonColor
        
        let barButtonAppearance = UIBarButtonItemAppearance()
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: navBarButtonColor]
        barButtonAppearance.normal.titleTextAttributes = textAttributes
        barButtonAppearance.highlighted.titleTextAttributes = textAttributes
        
        appearance.buttonAppearance = barButtonAppearance
        appearance.doneButtonAppearance = barButtonAppearance
        
        let backAppearance = UIBarButtonItemAppearance()
        backAppearance.normal.titleTextAttributes = textAttributes
        backAppearance.highlighted.titleTextAttributes = textAttributes
        appearance.backButtonAppearance = backAppearance

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
        
        if let leftBarButtonItem = navigationItem.leftBarButtonItem,
           let customButton = leftBarButtonItem.customView as? UIButton {
            customButton.tintColor = navBarButtonColor
        }
    }

    func refreshNavigationBarAppearance() {
        updateNavigationBarAppearance()
    }
}
