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
                    ZStack(alignment: .topLeading) {
                        KFImage(URL(string: item.links?.first?.href ?? ""))
                            .resizable()
                            .frame(height: 400)
                            .aspectRatio(contentMode: .fit)
                            .edgesIgnoringSafeArea(.top)
                      CustomBackButton(action: {
                          dismiss()
                      })
                    }
                     
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .center, spacing: 20) {
                            Text(item.data?.first?.title ?? StringConstants.notAvailable)
                                .font(.custom(AppFonts.openSansBold, size: 25))
                                .foregroundColor(.white)
                            Divider()
                                .frame(height: 3)
                                .background(.gray)
                        }
                        Text(StringConstants.about)
                            .font(.custom(AppFonts.openSansBold, size: 19))
                            .foregroundColor(.white)
                        Text("Date publsihed: \(item.data?.first?.dateCreated ?? StringConstants.notAvailable)")
                            .foregroundColor(.white)
                            .font(.custom(AppFonts.openSansRegular, size: 17))
                            .padding(.bottom, 50)
                        Spacer()
                        Text(item.data?.first?.description ?? StringConstants.notAvailable)
                            .font(.custom(AppFonts.openSansRegular, size: 17))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(8)
                            .foregroundColor(.white)
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
