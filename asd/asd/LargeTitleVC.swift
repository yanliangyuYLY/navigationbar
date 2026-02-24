import UIKit
import SnapKit

class LargeTitleVC: BaseViewController {
    
    private lazy var homeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("跳转到首页", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("跳转到滚动渐变页", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(goToScroll), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "大标题模式"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupUI() {
        view.addSubview(homeButton)
        view.addSubview(scrollButton)
        
        homeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
        
        scrollButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(homeButton.snp.bottom).offset(20)
            make.width.equalTo(220)
            make.height.equalTo(50)
        }
    }
    
    @objc private func goToHome() {
        let home = HomeVC()
        navigationController?.pushViewController(home, animated: true)
    }
    
    @objc private func goToScroll() {
        let scroll = ScrollGradientVC()
        navigationController?.pushViewController(scroll, animated: true)
    }
    
    override var navBarBackgroundColor: UIColor {
        return .systemPurple
    }
    
    override var navBarTitleColor: UIColor {
        return .white
    }
    
    override var navBarButtonColor: UIColor {
        return .white
    }
}
