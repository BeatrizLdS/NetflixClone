//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 07/10/22.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
