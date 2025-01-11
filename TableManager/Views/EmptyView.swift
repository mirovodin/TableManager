//
//  Created by Dmitriy Mirovodin on 05.10.2024.
//

import UIKit

final class EmptyView: UIView {
    
    private var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var emptyImage: UIImageView = {
        let image = UIImage(systemName: "photo.on.rectangle.angled")?.withRenderingMode(.alwaysTemplate)
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
    
    func update(with model: String) {
        emptyLabel.text = model
    }
}

private extension EmptyView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(emptyLabel)
        addSubview(emptyImage)
    }
    
    func setupConstraints() {
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])

        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImage.widthAnchor.constraint(equalToConstant: 60),
            emptyImage.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 20)
        ])
    }
}

