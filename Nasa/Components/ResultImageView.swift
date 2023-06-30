//
//  ResultImageView.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import SwiftUI
import Kingfisher

struct ResultImageView: View {
    var url = URL(string: "https://images-assets.nasa.gov/image/PIA00342/PIA00342~thumb.jpg") 
    var body: some View {
        KFImage.url(url)
            .resizable()
            .frame(maxWidth: .infinity)
            .frame(height: 400)
    }
}

struct ResultImageView_Previews: PreviewProvider {
    static var previews: some View {
        ResultImageView()
    }
}
