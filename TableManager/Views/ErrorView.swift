//
//  Created by Dmitriy Mirovodin on 05.10.2024.
//

import UIKit

final class ErrorView: UIView {
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "An error occurred, please try again"
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        errorLabel.textColor = .label
        return errorLabel
    }()
    
    private lazy var errorImage: UIImageView = {
        let image = UIImage(systemName: "cloud.bolt.fill")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.tintColor = .secondarySystemBackground
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(errorLabel)
        addSubview(errorImage)
    }
    
    func setupConstraints() {        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImage.widthAnchor.constraint(equalToConstant: 60),
            errorImage.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20)
        ])
    }
}

