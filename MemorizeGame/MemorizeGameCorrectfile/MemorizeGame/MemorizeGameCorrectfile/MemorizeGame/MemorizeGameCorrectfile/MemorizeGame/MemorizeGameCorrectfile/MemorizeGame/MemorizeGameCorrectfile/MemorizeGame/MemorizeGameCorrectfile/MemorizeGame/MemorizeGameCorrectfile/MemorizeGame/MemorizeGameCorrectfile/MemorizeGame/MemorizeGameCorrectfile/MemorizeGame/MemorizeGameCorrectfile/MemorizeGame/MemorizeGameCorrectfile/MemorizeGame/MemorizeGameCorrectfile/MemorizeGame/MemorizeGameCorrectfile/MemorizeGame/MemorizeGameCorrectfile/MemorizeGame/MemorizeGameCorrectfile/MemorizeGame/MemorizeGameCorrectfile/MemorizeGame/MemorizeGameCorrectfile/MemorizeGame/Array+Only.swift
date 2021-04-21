//
//  Array+Only.swift
//  MemorizeGame
//  return the only thing in an array
//  Created by Dawn Bacon on 1/30/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
