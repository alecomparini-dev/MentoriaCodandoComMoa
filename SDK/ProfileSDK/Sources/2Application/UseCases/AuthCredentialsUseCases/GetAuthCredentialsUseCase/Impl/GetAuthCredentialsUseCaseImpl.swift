//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public class GetAuthCredentialsUseCaseImpl: GetAuthCredentialsUseCase {
    private let getAuthCredentialsGateway: GetKeyChainUseCaseGateway
    
    public init(getAuthCredentialsGateway: GetKeyChainUseCaseGateway) {
        self.getAuthCredentialsGateway = getAuthCredentialsGateway
    }
    
    public func getCredentials(_ userEmail: String) throws -> BiometricPreference {
        
        guard let credentials: [String] = try getAuthCredentialsGateway.get(ProfileUseCasesConstants.credentials) as? [String] else {
            return BiometricPreference.notResponded
        }
        
        if !isSameUser(userEmail: userEmail, credentials) { return BiometricPreference.notSameUser }
        
        if hasInconsistencyInCredentials(credentials) { return BiometricPreference.notResponded}
        
        if didNotAcceptUseBiometrics(credentials) { return BiometricPreference.notAccepted }
        
        return BiometricPreference.accepted(credentials: (email: credentials[0], password: credentials[1]) )
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func isSameUser(userEmail: String, _ credentials: [String]) -> Bool {
        return userEmail == credentials[0]
    }
    
    private func didNotAcceptUseBiometrics(_ credentials: [String]) -> Bool {
        return credentials[1].isEmpty
    }
    
    private func hasInconsistencyInCredentials(_ credentials: [String]) -> Bool {
        if credentials.isEmpty { return true }
        if credentials.count == 1 || credentials.count > 2 { return true }
        return false
    }
    
}
