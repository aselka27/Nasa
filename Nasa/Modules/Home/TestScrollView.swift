//
//  TestScrollView.swift
//  Nasa
//
//  Created by саргашкаева on 3.07.2023.
//

import SwiftUI

struct TestScrollView: View {
    @State var text = ""
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(R.color.gradient1()!), Color(R.color.gradient2()!)], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack {
                    Text(StringConstants.homeViewTitle)
                        .font(.custom(AppFonts.openSansBold, size: 22))
                        .foregroundColor(.white)
                    SearchBar(searchText: $text)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

struct TestScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestScrollView()
    }
}
