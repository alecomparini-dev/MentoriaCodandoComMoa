//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

class ProfilePictureTableViewCell: UITableViewCell {
    static let identifier = String(describing: ProfilePictureTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ viewController: UIViewController, profilePresenterDTO: ProfilePresenterDTO) {
        configProfilePicture(viewController)
        userNameText.setText(profilePresenterDTO.name)
        if let imageProfile = profilePresenterDTO.imageProfile {
            profilePictureView.setImagePicture(imageProfile)
        }
    }
    
    
//  MARK: - LAZY AREA
    lazy var profilePictureView: ProfilePictureBuilder = {
        let comp = ProfilePictureBuilder(size: 112)
            .setBackgroundColor(hexColor: "#FFFFFF")
            .setTintColor("#282a36")
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
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
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        profilePictureView.add(insideTo: self.contentView)
        userNameText.add(insideTo: self.contentView)
        professionText.add(insideTo: self.contentView)
    }
    
    private func configConstraints() {
        profilePictureView.applyConstraint()
        userNameText.applyConstraint()
        professionText.applyConstraint()
    }
    
    private func configProfilePicture(_ viewController: UIViewController) {
        profilePictureView
            .setChooseSource(viewController: viewController, { build in
                build
                    .setTitle("Escolha:")
                    .setOpenCamera { _ in }
                    .setOpenGallery { _ in }
            })
    }
    
}
