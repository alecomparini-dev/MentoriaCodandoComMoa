//  Created by Alessandro Comparini on 24/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent

public class AddServiceView: UIView {
    
    
    public init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - LAZY AREA
    lazy var backgroundView: CustomView = {
        let comp = CustomView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var textTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Cadastrar Serviço")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        textTitle.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        textTitle.applyConstraint()
    }
    
    
}
