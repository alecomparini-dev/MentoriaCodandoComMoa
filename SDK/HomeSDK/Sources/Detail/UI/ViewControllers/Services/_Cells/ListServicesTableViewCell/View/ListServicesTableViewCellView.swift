//  Created by Alessandro Comparini on 23/10/23.
//

import UIKit
import DesignerSystemSDKComponent
import CustomComponentsSDK

public protocol ListServicesTableViewCellViewDelegate: AnyObject {
    func editButtonTapped()
}
 
public class ListServicesTableViewCellView: ViewBuilder {
    public weak var delegate: ListServicesTableViewCellViewDelegate?
    
    public override init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//  MARK: - LAZY AREA
    lazy var cardServiceView: CardServiceView = {
        let card = CardServiceView()
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSafeArea(16)
                    .setLeading.equalToSafeArea(24)
                    .setTrailing.equalToSafeArea(-60)
            }
        return card
    }()
    
    lazy var editView: ViewBuilder = {
        let view = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSafeArea(16)
                    .setTrailing.equalToSafeArea
                    .setWidth.equalToConstant(60)
            }
        return view
    }()
    
    lazy var editButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: "pencil.circle")
            .setSize(26)
        let btn = ButtonImageBuilder()
            .setImageButton(img)
            .setImageWeight(.ultraLight)
            .setTintColor(color: .white)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        btn.get.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return btn
    }()
    @objc private func editButtonTapped(_ button: UIButton) {
        delegate?.editButtonTapped()
    }

    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configBackgroundColor()
        addElements()
        configConstraints()
    }
    
    private func configBackgroundColor() {
        self.setBackgroundColor(color: .clear)
    }
    
    private func addElements() {
        cardServiceView.add(insideTo: self.get)
        editView.add(insideTo: self.get)
        editButton.add(insideTo: editView.get)
    }
    
    private func configConstraints() {
        cardServiceView.applyConstraint()
        editView.applyConstraint()
        editButton.applyConstraint()
    }
    
    
}
