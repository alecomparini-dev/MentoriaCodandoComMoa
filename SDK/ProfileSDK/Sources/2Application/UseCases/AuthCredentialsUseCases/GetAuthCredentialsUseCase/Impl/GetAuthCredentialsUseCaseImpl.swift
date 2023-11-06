//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public class GetAuthCredentialsUseCaseImpl: GetAuthCredentialsUseCase {
    typealias credentialsAlias = (email: String, password: String)
    
    private struct BiometricPreference {
        static let notResponded: credentialsAlias? = nil
        static let notAccepted: credentialsAlias = (email: "", password: "")
        static var accepted: credentialsAlias?
    }
    
    private let getAuthCredentialsGateway: GetKeyChainUseCaseGateway
    
    public init(getAuthCredentialsGateway: GetKeyChainUseCaseGateway) {
        self.getAuthCredentialsGateway = getAuthCredentialsGateway
    }
    
    public func getCredentials() throws -> (email: String, password: String)? {
        guard let credentials: [String] = try getAuthCredentialsGateway.get(ProfileUseCasesConstants.credentials) as? [String] else {
            return BiometricPreference.notResponded
        }
        
        if didNotAcceptUseBiometrics(credentials) { return BiometricPreference.notAccepted }
        
        if hasInconsistencyInCredentials(credentials) { return BiometricPreference.notResponded}
        
        BiometricPreference.accepted = (email: credentials[0], password: credentials[1])
        
        return BiometricPreference.accepted
    }
    
    
//  MARK: - PRIVATE AREA
    private func didNotAcceptUseBiometrics(_ credentials: [String]) -> Bool {
        if credentials.isEmpty {
            return true
        }
        return false
    }
    
    private func hasInconsistencyInCredentials(_ credentials: [String]) -> Bool {
        if credentials.count == 1 || credentials.count > 2  { return true }
        return false
    }
    
}
