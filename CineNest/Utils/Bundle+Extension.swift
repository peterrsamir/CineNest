//
//  Bundle+Extension.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import Foundation

extension Bundle {
    func value<T>(for key: String) -> T? {
        object(forInfoDictionaryKey: key) as? T
    }
    
    var TMDBKey: String {
        value(for: "TMDBKey") ?? ""
    }
}
