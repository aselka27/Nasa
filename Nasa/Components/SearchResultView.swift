//
//  SearchResultView.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI

struct SearchResultView: View {
    var item: Item
    
    var body: some View {
        HStack {
            VStack {
                Image("earth")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(item.data?.first?.title ?? "N/A")
                    .font(.custom(AppFonts.openSansBold, size: 34.59))
                    .lineLimit(1)
                Text(item.data?.first?.dateCreated?.formatDateString() ?? "N/A")
                    .font(.custom(AppFonts.openSansBold, size: 14))
            }
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.white)
            }
            .frame(height: 25)
            .padding(10)
            .padding(.horizontal, 5)
            .background(.black)
            .cornerRadius(12)

          
           
        }
        .padding(.horizontal)
      
    }
    
    func printFonts() {
      
    }
}

//struct SearchResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultView(item: <#Item#>)
//    }
//}
