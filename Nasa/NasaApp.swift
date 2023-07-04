//
//  NasaApp.swift
//  Nasa
//
//  Created by саргашкаева on 28.06.2023.
//

import SwiftUI

@main
struct NasaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(dataService: SearchServiceImpl(service: APIServiceImpl()))
            }
        }
    }
}
