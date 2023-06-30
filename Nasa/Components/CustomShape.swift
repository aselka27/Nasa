//
//  CustomShape.swift
//  Nasa
//
//  Created by саргашкаева on 30.06.2023.
//

import SwiftUI


struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
