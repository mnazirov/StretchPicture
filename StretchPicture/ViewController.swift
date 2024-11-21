//
//  Created by Marat Nazirov on 19.11.2024.
//

import UIKit

final class ViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollIndicatorInsets = UIEdgeInsets(
            top: Appearance.headerHeight + Appearance.indicatorPadding,
            left: 0,
            bottom: 0,
            right: 0
        )
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var headerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "building")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var headerViewHeightAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        headerViewHeightAnchor?.constant = Appearance.headerHeight - offsetY
        
        let indicatorTopInset = headerView.frame.height + Appearance.indicatorPadding - view.safeAreaInsets.top
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: indicatorTopInset, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Private methods

private extension ViewController {
    func commonInit() { 
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() { 
        view.addSubview(scrollView)
        view.addSubview(headerView)
        scrollView.addSubview(contentView)
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Appearance.headerHeight),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 2)
        ])
        
        headerViewHeightAnchor = headerView.heightAnchor.constraint(equalToConstant: Appearance.headerHeight)
        headerViewHeightAnchor?.isActive = true
    }
}

private extension ViewController {
    enum Appearance{
        static let headerHeight: CGFloat = 270
        static let indicatorPadding: CGFloat = 5
    }
}
