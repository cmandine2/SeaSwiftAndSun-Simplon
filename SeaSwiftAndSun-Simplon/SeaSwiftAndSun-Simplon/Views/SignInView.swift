//
//  SignInView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Christophe LEHOUSSINE on 14/12/2023.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @State private var isLoginValidated = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if !isLoginValidated {
            ZStack {
                Color.accentColor.ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("wave")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150)
                    Text("Wave Safari")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    
                    if colorScheme.self == .dark {
                        SignInButton(SignInWithAppleButton.Style.whiteOutline)
                    } else {
                        SignInButton(SignInWithAppleButton.Style.black)
                    }
                }
                .padding(.bottom, 50)
            }
        } else {
      
             MonUIViewControllerWrapper()
           
            }
            
   }
    
    func SignInButton(_ type: SignInWithAppleButton.Style) -> some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorization successful: \(authResults)")
                isLoginValidated = true
            case .failure(let error):
                print("Authorization failed: \(error.localizedDescription)")
            }
        }
        .frame(width: 280, height: 60, alignment: .center)
        .signInWithAppleButtonStyle(type)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
