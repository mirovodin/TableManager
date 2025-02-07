//
//  Created by Dmitriy Mirovodin on 04.10.2024.
//

import UIKit

final class ModuleAlphaTableViewCell: UITableViewCell {

    static let id = "ModuleAlphaTableViewCell" // ID для регистрации
    
    struct Model {
        let title: String
        let value: String
        let isChecked: Bool
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
  
    private var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 2.0
        return view
    }()
    
    private var line: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        selectionStyle = .none
        tintColor = .systemRed
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: Model) {
        titleLabel.text = model.title
        valueLabel.text = model.value
        accessoryType = model.isChecked ? .checkmark : .none
    }
}

private extension ModuleAlphaTableViewCell {
    
    func setupSubviews() {
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
        contentView.addSubview(stack)
        contentView.addSubview(line)
        setupConstraints()
    }
    
    func setupConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            line.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 2.0),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale)
        ])
    }
}
