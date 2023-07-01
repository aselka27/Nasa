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
                    })
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    
            }
            VStack(alignment: .leading) {
                Text(item.data?.first?.title ?? "N/A")
                    .font(.custom(AppFonts.openSansBold, size: 34.59))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(item.data?.first?.dateCreated?.formatDateString() ?? "N/A")
                    .foregroundColor(.white)
                    .font(.custom(AppFonts.openSansBold, size: 14))
            }
            Spacer()
        }
        .padding(.horizontal)
       
      
    }
  
}

//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView(item: <#Item#>)
//    }
//}
