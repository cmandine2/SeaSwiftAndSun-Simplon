//
//  SwiftUIView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Christophe LEHOUSSINE on 14/12/2023.
//

import SwiftUI

struct MonUIViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewControllerList = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ListCells")
        return viewControllerList
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
#Preview {
    MonUIViewControllerWrapper()
}
