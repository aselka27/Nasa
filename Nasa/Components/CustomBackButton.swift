//
//  CustomBackButton.swift
//  Nasa
//
//  Created by саргашкаева on 2.07.2023.
//

import SwiftUI

struct CustomBackButton: View {
    var action: (()->())
    var body: some View {
        Button(action: {
            action()
        }){
            Image(uiImage: .chevronLeft)
                .resizable()
                .frame(width: 15, height: 15)
                .padding()
        }
        .frame(width: 40, height: 40)
        .background(Color(R.color.orange()!))
        .cornerRadius(12)
        .padding(.top, 50)
        .padding(.leading)
        .buttonStyle(PlainButtonStyle())
        
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton(action: {
            
        })
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
