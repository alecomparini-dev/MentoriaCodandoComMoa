//  Created by Alessandro Comparini on 12/10/23.
//

import UIKit

import CustomComponentsSDK
import DesignerSystemSDKComponent
import ProfilePresenters

protocol ProfilePictureTableViewCellDelegate: AnyObject {
    func saveProfileImage(_ image: UIImage)
}

class ProfilePictureTableViewCell: UITableViewCell {
    static let identifier = String(describing: ProfilePictureTableViewCell.self)
    weak var delegate: ProfilePictureTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SETUP CELL
    public func setupCell(_ viewController: UIViewController, profilePresenterDTO: ProfilePresenterDTO?, profileImage: Data?) {
        guard let profilePresenterDTO else {return}
        configProfilePicture(viewController)
        resetSkeleton()
        userNameText.setText(profilePresenterDTO.name)
        professionText.setText(profilePresenterDTO.fieldOfWork)
        if let profileImage {
            profilePictureView.setImagePicture(profileImage)
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
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(profilePictureView.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(30)
            }
        return comp
    }()
    
    lazy var professionText: CustomTextSecondary = {
        let comp = CustomTextSecondary()
            .setSize(20)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(userNameText.get, .bottom, 8)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setHeight.equalToConstant(20)
            }
        return comp
    }()
    
    
//  MARK: - PUBLIC AREA
    public func configSkeleton() {
        profilePictureView.profileImage.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        userNameText.setSkeleton { build in
            build.showSkeleton(.gradientAnimated)
        }
        professionText.setSkeleton { build in
            build.setColorSkeleton(hexColor: "#aacff9")
                .showSkeleton(.gradientAnimated)
        }
    }
    
    
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
                    .setOpenCamera { [weak self] image in
                        guard let self, let image, let imageProfile = image.get.image else {return}
                        delegate?.saveProfileImage(imageProfile)
                    }
                    .setOpenGallery { [weak self] image in
                        guard let self, let image, let imageProfile = image.get.image else {return}
                        delegate?.saveProfileImage(imageProfile)
                    }
            })
    }
    
    private func resetSkeleton() {
        profilePictureView.profileImage.get.hideSkeleton()
        userNameText.get.hideSkeleton()
        professionText.get.hideSkeleton()
    }
    
    
}
