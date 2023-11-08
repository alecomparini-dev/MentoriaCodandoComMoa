//  Created by Alessandro Comparini on 06/11/23.
//

import Foundation

public class GetAuthCredentialsUseCaseImpl: GetAuthCredentialsUseCase {
    
    private let getAuthCredentialsGateway: GetKeyChainUseCaseGateway
    
    public init(getAuthCredentialsGateway: GetKeyChainUseCaseGateway) {
        self.getAuthCredentialsGateway = getAuthCredentialsGateway
    }
    
    public func getCredentials(_ userEmail: String) throws -> BiometricPreference {
        guard let credentials: [String] = try getAuthCredentialsGateway.get(userEmail) as? [String] else {
            return BiometricPreference.notResponded
        }
        
        if didNotAcceptUseBiometrics(credentials) { return BiometricPreference.notAccepted }
        
        if hasInconsistencyInCredentials(credentials) { return BiometricPreference.notResponded}
        
        return BiometricPreference.accepted(credentials: (email: credentials[0], password: credentials[1]) )
    }
    
    
//  MARK: - PRIVATE AREA
    private func didNotAcceptUseBiometrics(_ credentials: [String]) -> Bool {
        if credentials.isEmpty { return true }
        
        if credentials[0].isEmpty {return true}
        
        return false
    }
    
    private func hasInconsistencyInCredentials(_ credentials: [String]) -> Bool {
        if credentials.count == 1 || credentials.count > 2 { return true }
        return false
    }
    
}
