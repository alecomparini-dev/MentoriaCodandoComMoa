//  Created by Alessandro Comparini on 14/09/23.
//

import Foundation

import ProfileUseCases


public protocol SignInPresenterOutput: AnyObject {
    func errorSignIn(_ error: String)
    func successSignIn(_ userId: String)
    func errorSignByBiometry()
    func successSignByBiometry()
    func loadingLogin(_ isLoading: Bool)
    func askIfWantToUseBiometrics(title: String, message: String, completion: @escaping (_ acceptUseBiometry: Bool) -> Void )

}

public class SignInPresenterImpl: SignInPresenter  {
    public weak var outputDelegate: SignInPresenterOutput?
    
    private var userIDAuth: String?
    private var email: String = ""
    private var password: String = ""
    
    
    private let authUseCase: AuthenticateUseCase
    private let saveKeyChainEmailUseCase: SaveKeyChainRememberEmailUseCase
    private let getKeyChainEmailUseCase: GetKeyChainRememberEmailUseCase
    private let delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase
    private let getAuthCredentialsUseCase: GetAuthCredentialsUseCase
    private let saveAuthCredentialsUseCase: SaveAuthCredentialsUseCase
    private let checkBiometryUseCase: CheckBiometryUseCase
    private let authenticateWithBiometricsUseCase: AuthenticateWithBiometricsUseCase
    private let emailValidator: EmailValidations
    
    public init(authUseCase: AuthenticateUseCase,
                saveKeyChainEmailUseCase: SaveKeyChainRememberEmailUseCase,
                getKeyChainEmailUseCase: GetKeyChainRememberEmailUseCase,
                delKeyChainEmailUseCase: DeleteKeyChainRememberEmailUseCase,
                getAuthCredentialsUseCase: GetAuthCredentialsUseCase,
                saveAuthCredentialsUseCase: SaveAuthCredentialsUseCase,
                checkBiometryUseCase: CheckBiometryUseCase,
                authenticateWithBiometricsUseCase: AuthenticateWithBiometricsUseCase,
                emailValidator: EmailValidations) {
        self.authUseCase = authUseCase
        self.saveKeyChainEmailUseCase = saveKeyChainEmailUseCase
        self.getKeyChainEmailUseCase = getKeyChainEmailUseCase
        self.delKeyChainEmailUseCase = delKeyChainEmailUseCase
        self.getAuthCredentialsUseCase = getAuthCredentialsUseCase
        self.saveAuthCredentialsUseCase = saveAuthCredentialsUseCase
        self.checkBiometryUseCase = checkBiometryUseCase
        self.authenticateWithBiometricsUseCase = authenticateWithBiometricsUseCase
        self.emailValidator = emailValidator
    }
    
    
//  MARK: - PUBLIC AREA
    public func getEmailKeyChain() -> String? {
        do {
            return try getKeyChainEmailUseCase.getEmail()
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    
    public func login(email: String, password: String, rememberEmail: Bool = false) {
        self.email = email
        self.password = password
        
        if let msgInvalid = validations() {
            outputDelegate?.errorSignIn(msgInvalid)
            return
        }
        
        Task {
            do {
                try await performAuthEmailPassword(email: email, password: password)
                
                try configRememberEmail(email: email, rememberEmail)
                
                if let biometricPreference: BiometricPreference = getBiometricPreference() {
                    if biometricPreference == .notResponded {
                        askIfWantToUseBiometrics()
                        return
                    }
                }
                successSingIn()
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.outputDelegate?.errorSignIn("Email ou Senha inválidos")
                }
            }
        }
        
    }
    
    public func loginByBiometry() {
        Task {
            if let biometricPreference: BiometricPreference = getBiometricPreference() {
                switch biometricPreference {
                    case .accepted(let credentials):
                        outputLoadingLogin(true)
                        Task {
                            if await !performAuthBiometric() { return outputLoadingLogin(false) }
                            try await performAuthEmailPassword(email: credentials.email, password: credentials.password)
                            try configRememberEmail(email: credentials.email, true)
                            successSingIn()
                        }
                        return
                    
                    default:
                        return
                }
                
            }
        }
    }
    
//  MARK: - PRIVATE AREA
    private func saveRememberEmail(_ email: String) {
        do {
            try saveKeyChainEmailUseCase.save(email)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func validations() -> String? {
        if let failMsg = isValidRequiredFields() {
            return failMsg
        }
        
        return isValidEmail()
    }
    
    private func isValidEmail() -> String? {
        if !emailValidator.validate(email: self.email) {
            return "\nO email está fora do padrão \n"
        }
        return nil
    }
    
    private func isValidRequiredFields() -> String? {
        var fieldFails = [String]()
        
        if email.isEmpty {fieldFails.append("E-mail") }
        
        if password.isEmpty { fieldFails.append("Senha") }
        
        var failMsg: String?
        if (fieldFails.count > 1) {
            failMsg = "Os campos: \(fieldFails.description), devem estar preenchidos"
        }
        if (fieldFails.count == 1) {
            failMsg = "O campo: \(fieldFails.description), deve estar preenchido"
        }
        
        return failMsg
    }
    
    private func configRememberEmail(email: String, _ rememberPassword: Bool) throws {
        try delKeyChainEmailUseCase.delete()
        if rememberPassword {
            saveRememberEmail(email)
        }
    }
    
    private func performAuthEmailPassword(email: String, password: String) async throws {
        self.userIDAuth = try await authUseCase.emailPasswordAuth(email: email, password: password)
    }
    
    private func outputLoadingLogin(_ flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.outputDelegate?.loadingLogin(flag)
        }
    }
    
    private func successSingIn() {
        if let userIDAuth {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                outputDelegate?.successSignIn(userIDAuth)
            }
        }
    }
    
    
//  MARK: - BIOMETRICS FLOW
    
    @discardableResult
    private func getBiometricPreference() -> BiometricPreference? {
        do {
            return try getAuthCredentialsUseCase.getCredentials()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    
    
//    private func performLoginProvider(_ credentials: CredentialsAlias) {
//        Task {
//            do {
//                try await performAuthEmailPassword(email: email, password: password)
//                try configRememberEmail(email: email, true)
//                successSingIn()
//            } catch {
//                DispatchQueue.main.async { [weak self] in
//                    self?.outputDelegate?.errorSingIn("Email ou Senha inválidos")
//                }
//            }
//        }
//    }
    
    
    private func continueAcceptedBiometricFlow(_ credentials: CredentialsAlias) {
        outputLoadingLogin(true)
        
        Task {
            if await !performAuthBiometric() { return outputLoadingLogin(false) }
//            performLoginProvider(credentials)
        }
    }
    
    private func performAuthBiometric() async -> Bool {
        let authenticateBiometricsDTO = await authenticateWithBiometricsUseCase.authenticate(reason: "Use a biometria para se logar", cancelTitle: "Usar email/senha?")
        
        if !authenticateBiometricsDTO.isAuthenticated! { return false }
        
        return true
    }
    
    
    
    private func completionAskIfWantToUseBiometrics(_ acceptUseBiometry: Bool) {
        if acceptUseBiometry {
            saveCredentials(email: self.email, password: self.password)
        } else {
            saveCredentials(email: "", password: "")
        }
        successSingIn()
    }
    
    private func askIfWantToUseBiometrics() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            outputDelegate?.askIfWantToUseBiometrics(title: "Cadastrar Biometria",
                                                     message: "Deseja cadastrar a Biometria?",
                                                     completion: completionAskIfWantToUseBiometrics)
        }
    }
    
    private func saveCredentials(email: String, password: String) {
        do {
            if try saveAuthCredentialsUseCase.save(email: email, password: password) {
                successSingIn()
                return
            }
            //TODO: FLUXO DE EXEÇÃO PARA QUANDO NAO SALVA AS CREDENCIAIS
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return
    }

    
}
