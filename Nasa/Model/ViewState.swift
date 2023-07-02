//
//  ViewState.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


enum ViewState<T> {
    case loading
    case success(T)
    case error(Error)
   
}
