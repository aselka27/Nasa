//
//  SearchResultDetailView.swift
//  Nasa
//
//  Created by саргашкаева on 30.06.2023.
//

import SwiftUI
import Kingfisher


struct SearchResultDetailView: View {
    
    var item: Item
    @Environment(\.dismiss) var dismiss
    
    init(item: Item) {
        self.item = item
    }
   
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    topImageView
                    VStack(alignment: .leading, spacing: 10) {
                        titleView
                        detailView
                    }
                    .padding(.horizontal)
                    .background(LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .topLeading, endPoint: .topTrailing)
                        .clipShape(CustomShape())
                        .padding(.top, -50)
                    )
                }
            }
        .edgesIgnoringSafeArea(.top)
        .background(LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .topLeading, endPoint: .topTrailing))
        .navigationBarHidden(true)
    }
}


extension SearchResultDetailView {
    var topImageView: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: item.links?.first?.href ?? ""))
                .resizable()
                .onFailureImage(R.image.imagePlaceholder()!)
                .frame(height: 400)
                .frame(width: UIScreen.main.bounds.width)
                .aspectRatio(contentMode: .fit)
              
                .edgesIgnoringSafeArea(.top)
          CustomBackButton(action: {
              dismiss()
          })
        }
    }
    
    var titleView: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(item.data?.first?.title ?? StringConstants.notAvailable)
                .font(.custom(R.font.openSansBold, size: 25))
                .foregroundColor(.white)
            Divider()
                .frame(height: 3)
                .background(.gray)
        }
    }
    
    var detailView: some View {
        VStack {
            Text(StringConstants.about)
                .font(.custom(R.font.openSansBold, size: 19))
                .foregroundColor(.white)
            Text("Date publsihed: \(item.data?.first?.dateCreated ?? StringConstants.notAvailable)")
                .foregroundColor(.white)
                .font(.custom(R.font.openSansBold, size: 17))
                .padding(.bottom, 50)
            Text(item.data?.first?.description ?? StringConstants.notAvailable)
                .font(.custom(R.font.openSans, size: 17))
                .multilineTextAlignment(.leading)
                .lineSpacing(8)
                .foregroundColor(.white)
        }
    }
}
