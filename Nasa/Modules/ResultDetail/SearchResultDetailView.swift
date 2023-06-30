//
//  SearchResultDetailView.swift
//  Nasa
//
//  Created by саргашкаева on 30.06.2023.
//

import SwiftUI
import Kingfisher


struct SearchResultDetailView: View {
    var url = URL(string: "https://images-assets.nasa.gov/image/PIA00342/PIA00342~thumb.jpg")
    var item: Item
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(.vertical) {
            VStack {
               
                KFImage(url)
                    .resizable()
                    .frame(height: 400)
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)
        
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .center, spacing: 20) {
                        Text(item.data?.first?.title ?? "N/A")
                            .font(.custom(AppFonts.openSansBold, size: 25))
                            .foregroundColor(.white)
                        Divider()
                            .frame(height: 3)
                            .background(.gray)
                    }
                    Text("About")
                        .font(.custom(AppFonts.openSansBold, size: 19))
                        .foregroundColor(.white)
                    Spacer()
                    Text(item.data?.first?.description ?? "N/A")
                        .font(.custom(AppFonts.openSansRegular, size: 17))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal)
            
                .background(LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .topLeading, endPoint: .topTrailing)
                    .clipShape(CustomShape())
                    .padding(.top, -50)
                   
                )
            }
           
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundColor(.white)
                    }
                    .frame(height: 25)
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color("orange"))
                    .cornerRadius(12)

                }
            })
           
        
        }
        .ignoresSafeArea(.all, edges: .all)
        .background(LinearGradient(colors: [Color("gradient1"), Color("gradient2")], startPoint: .topLeading, endPoint: .topTrailing))
       
        .navigationBarBackButtonHidden(true)
    }
}

//struct SearchResultDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultDetailView()
//    }
//}
