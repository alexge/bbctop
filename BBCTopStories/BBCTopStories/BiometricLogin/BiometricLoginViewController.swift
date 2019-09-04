//
//  BiometricLoginViewController.swift
//  BBCTopStories
//
//  Created by Alexander Ge on 04/09/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import LocalAuthentication
import UIKit

final class BiometricLoginViewController: UIViewController {
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    var successHandler: (() -> Void)?
    
    private var context = LAContext()
    
    override func viewDidAppear(_ animated: Bool) {
        if canEvaluatePolicy() {
            authenticateUser()
        } else {
            successHandler?()
        }
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func biometricType() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
    
    func authenticateUser() {
        let loginReason = "Logging in with Biometrics"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: loginReason) { [weak self] (success, evaluateError) in
                                if success {
                                    self?.successHandler?()
                                } else if let error = evaluateError {
                                    DispatchQueue.main.async {
                                        let alert = UIAlertController(title: "Failed", message: "Try again?", preferredStyle: .alert)
                                        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
                                            alert.dismiss(animated: true) {
                                                self?.authenticateUser()
                                            }
                                        }
                                        let no = UIAlertAction(title: "No", style: .cancel) { _ in
                                            alert.dismiss(animated: true)
                                        }
                                        alert.addAction(yes)
                                        alert.addAction(no)
                                        self?.present(alert, animated: true)
                                    }
                                }
        }
    }
}
