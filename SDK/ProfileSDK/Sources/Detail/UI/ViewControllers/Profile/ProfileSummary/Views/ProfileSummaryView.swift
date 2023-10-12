//  Created by Alessandro Comparini on 09/10/23.
//

import UIKit

import DesignerSystemSDKComponent
import CustomComponentsSDK

class ProfileSummaryView: UIView {
    
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
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
    
    lazy var perfilTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Perfil")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    
    lazy var tableViewScroll: TableViewBuilder = {
        let comp = TableViewBuilder()
            .setShowsScroll(false, .both)
            .setSeparatorStyle(.none)
            .setConstraints { build in
                build
                    .setTop.equalTo(perfilTextTitle.get, .bottom, 16)
                    .setPinBottom.equalToSafeArea
            }
        return comp
    }()
    
    
    
    lazy var profilePictureView: ProfilePictureBuilder = {
        let comp = ProfilePictureBuilder(size: 112)
            .setBackgroundColor(hexColor: "#FFFFFF")
            .setTintColor("#282a36")
            .setChooseSource(viewController: viewController, { build in
                build
                    .setTitle("Escolha:")
                    .setOpenCamera { _ in }
                    .setOpenGallery { _ in }
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(perfilTextTitle.get, .bottom, 24)
                    .setLeading.setTrailing.equalToSafeArea(24)
                    .setHeight.equalToConstant(120)
                    
            }
        return comp
    }()
    
    lazy var userNameText: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Marcelo Oliveira")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(profilePictureView.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var professionText: CustomText = {
        let comp = CustomText()
            .setText("Eletricista")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(userNameText.get, .bottom, 4)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var cpfLabelText: CustomText = {
        let comp = CustomText()
            .setText("CPF")
            .setConstraints { build in
                build
                    .setTop.equalTo(professionText.get, .bottom, 24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var cpfTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setText("625.003.820-00")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(cpfLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(48)
            }
        return comp
    }()
    
    lazy var dataOfBirthLabelText: CustomText = {
        let comp = CustomText()
            .setText("Data de nascimento")
            .setConstraints { build in
                build
                    .setTop.equalTo(cpfTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(cpfLabelText.get)
            }
        return comp
    }()
    
    lazy var dataOfBirthTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setText("26/06/1980")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(dataOfBirthLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(cpfTextField.get)
            }
        return comp
    }()
    
    
    lazy var phoneNumberLabelText: CustomText = {
        let comp = CustomText()
            .setText("Telefone")
            .setConstraints { build in
                build
                    .setTop.equalTo(dataOfBirthTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(cpfLabelText.get)
            }
        return comp
    }()
    
    lazy var phoneNumberTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setText("(53) 98262-0320")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(phoneNumberLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(cpfTextField.get)
            }
        return comp
    }()
    
    
    
    lazy var fieldOfWorkLabelText: CustomText = {
        let comp = CustomText()
            .setText("Ramo de atuação")
            .setConstraints { build in
                build
                    .setTop.equalTo(phoneNumberTextField.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(cpfLabelText.get)
            }
        return comp
    }()
    
    lazy var fieldOfWorkTextField: TextFieldBuilder = {
        let comp = TextFieldBuilder()
            .setReadOnly(true)
            .setBackgroundColor(hexColor: "#ffffff")
            .setPadding(8)
            .setText("Eletricista")
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(fieldOfWorkLabelText.get, .bottom, 8)
                    .setLeading.setTrailing.setHeight.equalTo(cpfTextField.get)
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        perfilTextTitle.add(insideTo: self)
        
        tableViewScroll.add(insideTo: self)
        
        userNameText.add(insideTo: self)
        professionText.add(insideTo: self)
        profilePictureView.add(insideTo: self)
        cpfLabelText.add(insideTo: self)
        cpfTextField.add(insideTo: self)
        dataOfBirthLabelText.add(insideTo: self)
        dataOfBirthTextField.add(insideTo: self)
        phoneNumberLabelText.add(insideTo: self)
        phoneNumberTextField.add(insideTo: self)
        fieldOfWorkLabelText.add(insideTo: self)
        fieldOfWorkTextField.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        perfilTextTitle.applyConstraint()
        
        tableViewScroll.applyConstraint()
        
        profilePictureView.applyConstraint()
        userNameText.applyConstraint()
        professionText.applyConstraint()
        cpfLabelText.applyConstraint()
        cpfTextField.applyConstraint()
        dataOfBirthLabelText.applyConstraint()
        dataOfBirthTextField.applyConstraint()
        phoneNumberLabelText.applyConstraint()
        phoneNumberTextField.applyConstraint()
        fieldOfWorkLabelText.applyConstraint()
        fieldOfWorkTextField.applyConstraint()
    }
}
