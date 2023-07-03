//
//  ErrorView.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
          Text("Oops...Something went wrong. Try searching again.")
                .font(.custom(AppFonts.openSansBold, size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
