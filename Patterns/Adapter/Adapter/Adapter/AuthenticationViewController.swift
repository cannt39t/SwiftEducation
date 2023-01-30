//
//  AuthenticationViewController.swift
//  Adapter
//
//  Created by Илья Казначеев on 25.01.2023.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class AuthenticationViewController: UIViewController {
    var authenticationService: AuthenticationServiceProtocol
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gmailButton = UIButton()
        gmailButton.setTitle("Sign in with Gmail", for: .normal)
        gmailButton.addTarget(self, action: #selector(gmailSignIn), for: .touchUpInside)
        view.addSubview(gmailButton)
        
        let appleIDButton = UIButton()
        appleIDButton.setTitle("Sign in with Apple ID", for: .normal)
        appleIDButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
        view.addSubview(appleIDButton)
    }
    
    @objc func gmailSignIn() {
        authenticationService.signIn(with: .gmail)
    }
    
    @objc func appleSignIn() {
        authenticationService.signIn(with: .appleID)
    }
}

protocol AuthenticationServiceProtocol {
    func signIn(with provider: Provider)
}

enum Provider {
    case gmail, appleID
}

class GmailAuthenticationService: AuthenticationServiceProtocol, GIDSignInDelegate {
    func signIn(with provider: Provider) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // Handle error
            print("Error signing in with Gmail: \(error.localizedDescription)")
        } else {
            // Successful sign in
            print("Signed in with Gmail: \(user.userID)")
        }
    }
}

class AppleIDAuthenticationService: AuthenticationServiceProtocol, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func signIn(with provider: Provider) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Successful sign in
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("Signed in with Apple ID: \(userIdentifier), full name: \(fullName?.description ?? ""), email: \(email ?? "")")
        } else {
            // Handle other types of ASAuthorizationCredentials
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error
        print("Error signing in with Apple ID: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

class AuthenticationServiceAdapter: AuthenticationServiceProtocol {
    let gmailService = GmailAuthenticationService()
    let appleIDService = AppleIDAuthenticationService()
    
    func signIn(with provider: Provider) {
        switch provider {
        case .gmail:
            gmailService.signIn(with: provider)
        case .appleID:
            appleIDService.signIn(with: provider)
        }
    }
}
