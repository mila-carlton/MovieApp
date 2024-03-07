//
//  Double + extension.swift
//  MovieApp
//
//  Created by PASGON TEXTILE on 13.02.24.
//

import Foundation

extension Double {
    func rounding () -> String {
        return String(format: "%.2f", abs(self))
    }
}
