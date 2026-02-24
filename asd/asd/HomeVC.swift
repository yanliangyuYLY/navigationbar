//
//  HomeVC.swift
//  asd
//
//  Created by a on 2026/01/30.
//

import UIKit

class HomeVC: BaseViewController {
    
    private lazy var imageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("图片背景页", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToImageVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("滚动渐变页", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToScrollVC), for: .touchUpInside)
        return button
    }()

    private lazy var largeTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("大标题演示页", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToLargeTitle), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupUI() {
        view.addSubview(imageButton)
        view.addSubview(scrollButton)
        view.addSubview(largeTitleButton)
        
        NSLayoutConstraint.activate([
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imageButton.widthAnchor.constraint(equalToConstant: 200),
            imageButton.heightAnchor.constraint(equalToConstant: 50),
            
            scrollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollButton.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 30),
            scrollButton.widthAnchor.constraint(equalToConstant: 200),
            scrollButton.heightAnchor.constraint(equalToConstant: 50),
            
            largeTitleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            largeTitleButton.topAnchor.constraint(equalTo: scrollButton.bottomAnchor, constant: 30),
            largeTitleButton.widthAnchor.constraint(equalToConstant: 200),
            largeTitleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var navBarBackgroundColor: UIColor {
        return .systemYellow
    }

    @objc private func goToImageVC() {
        let imageVC = ImageVC()
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    @objc private func goToScrollVC() {
        let scrollVC = ScrollGradientVC()
        navigationController?.pushViewController(scrollVC, animated: true)
    }
    
    @objc private func goToLargeTitle() {
        let largeVC = LargeTitleVC()
        navigationController?.pushViewController(largeVC, animated: true)
    }
}
