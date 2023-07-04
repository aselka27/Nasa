//
//  SearchResultView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI
import Kingfisher

struct SearchResultView: View {
    var item: Item
    
    var body: some View {
        HStack {
            VStack {
                KFImage.url(URL(string: item.links?.first?.href ?? ""))
                    .placeholder({
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .imageScale(.large)
                    })
                    .onFailureImage(R.image.imagePlaceholder()!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(item.data?.first?.title ?? StringConstants.notAvailable)
                    .font(.custom(R.font.openSansBold, size: 24))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(item.data?.first?.dateCreated?.formatDateString() ?? StringConstants.notAvailable)
                    .foregroundColor(.white)
                    .font(.custom(R.font.openSansBold, size: 14))
                   
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
