//
//  OSLog+Extension.swift
//  Nasa
//
//  Created by саргашкаева on 3.07.2023.
//

import Foundation
import os

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "APIService")
}
