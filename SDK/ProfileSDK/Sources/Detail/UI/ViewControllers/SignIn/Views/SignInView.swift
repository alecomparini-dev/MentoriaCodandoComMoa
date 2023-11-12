//  Created by Alessandro Comparini on 30/08/23.
//

import UIKit
import DesignerSystemSDKComponent
import CustomComponentsSDK


protocol SignInViewDelegate: AnyObject {
    func signInTapped()
    func signUpTapped()
    func forgotPasswordButtonTapped()
}

class SignInView: UIView {
    weak var delegate: SignInViewDelegate?
    
//    var skeleton: SkeletonBuilderAqui?
    
    init() {
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
    
    lazy var signInCustomTextTitle: CustomTextTitle = {
        let comp = CustomTextTitle()
            .setText("Entrada")
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(24)
                    .setLeading.setTrailing.equalToSafeArea(16)
            }
        return comp
    }()
    
    lazy var emailLoginView: EmailLoginTextFieldView = {
        let comp = EmailLoginTextFieldView()
            .setConstraints { build in
                build
                    .setTop.equalTo(signInCustomTextTitle.get, .bottom, 56)
                    .setLeading.setTrailing.equalTo(signInCustomTextTitle.get)
                    .setHeight.equalToConstant(80)
            }
        return comp
    }()
    
    lazy var passwordLoginView: PasswordLoginTextFieldView = {
        let comp = PasswordLoginTextFieldView()
            .setConstraints { build in
                build
                    .setTop.equalTo(emailLoginView.get, .bottom, 24)
                    .setLeading.setTrailing.equalTo(emailLoginView.get)
                    .setHeight.equalToConstant(80)
            }
        return comp
    }()
    
    lazy var rememberSwitch: CustomSwitchSecondary = {
        let comp = CustomSwitchSecondary()
            .setConstraints { build in
                build
                    .setTop.equalTo(passwordLoginView.get, .bottom, 24)
                    .setLeading.equalTo(passwordLoginView.get, .leading)
            }
        return comp
    }()

    lazy var rememberText: CustomTextSecondary = {
        let label = CustomTextSecondary()
            .setText("Lembrar")
            .setConstraints { build in
                build
                    .setLeading.equalTo(rememberSwitch.get, .trailing, 8)
                    .setVerticalAlignmentY.equalTo(rememberSwitch.get)
            }
        return label
    }()
    
    lazy var forgotPasswordButton: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Esqueceu a senha?")
            .setTitleSize(13)
            .setAlpha(0.8)
            .setBorder({ build in
                build.setWidth(0)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(rememberText.get)
                    .setTrailing.equalTo(passwordLoginView.passwordTextField.get, .trailing, -4)
                    .setHeight.equalToConstant(25)
            }
        comp.get.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func forgotPasswordButtonTapped() {
        delegate?.forgotPasswordButtonTapped()
    }
    
    lazy var signInButton: CustomButtonPrimary = {
        let comp = CustomButtonPrimary("Entrar")
            .setConstraints { build in
                build
                    .setTop.equalTo(rememberSwitch.get, .bottom, 48)
                    .setLeading.setTrailing.equalToSafeArea(44)
                    .setHeight.equalToConstant(48)
            }
        comp.get.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func signInTapped() {
        delegate?.signInTapped()
    }
    
    lazy var signUpButton: CustomButtonSecondary = {
        let comp = CustomButtonSecondary("Cadastra-se")
            .setConstraints { build in
                build
                    .setTop.equalTo(signInButton.get, .bottom, 16)
                    .setLeading.setTrailing.setHeight.equalTo(signInButton.get)
            }
        comp.get.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return comp
    }()
    @objc private func signUpTapped() {
        delegate?.signUpTapped()
    }
    

//  MARK: - PRIVATE AREA
    public func configure() {
        setBackgroundColor(hexColor: "#282A35")
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        signInCustomTextTitle.add(insideTo: self)
        emailLoginView.add(insideTo: self)
        passwordLoginView.add(insideTo: self)
        rememberSwitch.add(insideTo: self)
        rememberText.add(insideTo: self)
        forgotPasswordButton.add(insideTo: self)
        signInButton.add(insideTo: self)
        signUpButton.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        signInCustomTextTitle.applyConstraint()
        emailLoginView.applyConstraint()
        passwordLoginView.applyConstraint()
        rememberSwitch.applyConstraint()
        rememberText.applyConstraint()
        forgotPasswordButton.applyConstraint()
        signInButton.applyConstraint()
        signUpButton.applyConstraint()
    }
    
    
}








//
//
//
//
//
//open class SkeletonBuilderAqui {
//    
//    private var skeletonGradient: GradientBuilder?
//    private var skeletonLayerGradient: GradientBuilder?
//    
//    private var transitionDuration: CGFloat?
//    private var speed: K.Skeleton.SpeedAnimation?
//    private var color: UIColor?
//    private var radius: CGFloat?
//    private var widthComponent: CGFloat?
//    
//    private weak var component: UIView?
//    
//    public init(component: UIView) {
//        self.component = component
//        configure()
//    }
//    
//    private lazy var skeletonView: ViewBuilder = {
//        let comp = ViewBuilder()
//            .setConstraints { build in
//                build
////                    .setPin.equalTo(component ?? UIView())
//                    .setTop.setLeading.equalTo(component ?? UIView())
//                    .setHeight.setWidth.equalTo(component ?? UIView())
//            }
//        return comp
//    }()
//    
//    lazy var skeletonLayer: UIView = {
//        let comp = UIView()
//        comp.translatesAutoresizingMaskIntoConstraints = false
//        return comp
//    }()
//    
//    
//    //  MARK: - SET PROPERTIES
//    
//    @discardableResult
//    public func setSpeedAnimation(_ speed: K.Skeleton.SpeedAnimation) -> Self {
//        self.speed = speed
//        return self
//    }
//    
//    @discardableResult
//    public func setTransition(_ duration: CGFloat) -> Self {
//        transitionDuration = duration
//        return self
//    }
//    
//    @discardableResult
//    public func setColorSkeleton(color: UIColor?) -> Self {
//        self.color = color
//        return self
//    }
//    
//    @discardableResult
//    public func setCornerRadius(_ radius: CGFloat) -> Self {
//        self.radius = radius
//        return self
//    }
//    
//    public func hideSkeleton() {
//        stopAnimation()
//    }
//
//
////  MARK: - APPLY SKELETON
//    @discardableResult
//    public func apply() -> Self {
//        addSkeleton()
//        configClipsToBoundsSkeletonView()
//        configCustomCornerRadiusSkeletonView()
//        configFrameSkeletonLayer()
//        configGradient()
//        startAnimation()
//        return self
//    }
//
//    
////  MARK: - PRIVATE AREA
//    private func configure() {
//        setTransition(0.5)
//    }
//
//    private func configClipsToBoundsSkeletonView() {
//        skeletonView.get.layer.masksToBounds = true
//        skeletonView.get.clipsToBounds = true
//    }
//    
//    private func addSkeleton() {
//        addSkeletonView()
//        addSkeletonLayer()
//    }
//    
//    private func addSkeletonView() {
//        guard let component else {return}
//        skeletonView.add(insideTo: component.superview ?? UIView())
//        skeletonView.applyConstraint()
//    }
//    
//    private func addSkeletonLayer() {
//        skeletonView.get.addSubview(skeletonLayer)
//    }
//    
//    private func configCustomCornerRadiusSkeletonView() {
//        guard let component else {return}
//        skeletonView.get.layer.cornerRadius = component.layer.cornerRadius
//        if let radius {
//            skeletonView.setBorder { build in
//                build.setCornerRadius(radius)
//            }
//        }
//    }
//    
//    private func configGradient() {
//        configGradientSkeletonView()
//        configGradientSkeletonLayer()
//    }
//    
//    private func configGradientSkeletonView() {
//        let color: UIColor = color ?? .lightGray
//        skeletonGradient = GradientBuilder(skeletonView.get)
//            .setReferenceColor(color, percentageGradient: 10)
//            .setOpacity(1)
//            .apply()
//    }
//    
//    private func configFrameSkeletonLayer() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else {return}
//            let widthLayer = calculateWidthSkeletonLayer()
//            skeletonLayer.frame = CGRect(
//                origin: CGPoint(x: -widthLayer, y: .zero),
//                size: CGSize(width: widthLayer, height: skeletonView.get.bounds.height)
//            )
//        }
//    }
//
//    private func calculateWidthSkeletonLayer() -> CGFloat {
//        let sixtySixPercent = 0.66
//        return skeletonView.get.bounds.width * sixtySixPercent
//    }
//    
//    private func configGradientSkeletonLayer() {
//        skeletonLayerGradient = GradientBuilder(skeletonLayer)
//            .setGradientColors(configColorsGradientSkeleton())
//            .setOpacity(0.8)
//            .apply()
//    }
//    
//    private func configColorsGradientSkeleton() -> [UIColor] {
//        let color: UIColor = color ?? .lightGray
//        let color1 = color.adjustBrightness(5).withAlphaComponent(0.8)
//        let color2 = color.adjustBrightness(15)
//        let color3 = color.adjustBrightness(25)
//        let color4 = color.adjustBrightness(25)
//        let color5 = color.adjustBrightness(15)
//        let color6 = color.adjustBrightness(5).withAlphaComponent(0.8)
//        return [color1, color2, color3, color4, color5, color6 ]
//    }
//    
//    private func startAnimation() {
//        component?.setHidden(true)
//        let duration = TimeInterval(getDuration())
//        DispatchQueue.main.async { [weak self] in
//            guard let self else {return}
//            UIView.animate(withDuration: duration, delay: .zero, options: [.curveEaseInOut, .repeat], animations: { [weak self] in
//                guard let self else {return}
//                skeletonLayer.frame.origin.x = component?.layer.bounds.width ?? 100
//            }, completion: nil)
//        }
//    }
//    
//    private func stopAnimation() {
//        component?.setHidden(false)
//        configWidthSkeletonView()
//        if let transitionDuration {
//            transitionDissolve(transitionDuration)
//            return
//        }
//        hide()
//    }
//    
//    private func configWidthSkeletonView() {
//        guard let component else {return}
//        component.layoutIfNeeded()
//        skeletonView.get.layer.frame = CGRect(
//            origin: CGPoint(
//                x: skeletonView.get.layer.frame.origin.x,
//                y: skeletonView.get.layer.frame.origin.y),
//            size: CGSize(
//                width: component.layer.frame.width,
//                height: skeletonView.get.layer.frame.height))
//
//        skeletonView.get.layersResizeIfNeeded()
//    }
//    
//    private func transitionDissolve(_ transitionDuration: CGFloat) {
//        UIView.animate(withDuration: transitionDuration, delay: .zero, animations: { [weak self] in
//            self?.skeletonView.get.alpha = 0
//        }, completion: { [weak self] _ in
//            guard let self else {return}
//            hide()
//        })
//    }
//
//    private func getDuration() -> Float {
//        switch speed {
//            case .slow:
//                return 2.5
//            case .medium:
//                return 1.5
//            case .fast:
//                return 1
//            case nil:
//                return 1.5
//        }
//    }
//
//    private func hide() {
//        skeletonLayer.layer.removeAllAnimations()
//        skeletonView.get.layer.removeAllAnimations()
//        skeletonView.get.removeFromSuperview()
//
//    }
//    
//}
