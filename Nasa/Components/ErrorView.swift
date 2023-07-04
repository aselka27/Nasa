//
//  ErrorView.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import SwiftUI

struct ErrorView: View {
    var error: APIError
    
    var body: some View {
        VStack {
            switch error {
            default:
              Text("Oops...Something went wrong. Try searching again.")
                    .font(.custom(R.font.openSansBold, size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: .unknownError)
    }
}
