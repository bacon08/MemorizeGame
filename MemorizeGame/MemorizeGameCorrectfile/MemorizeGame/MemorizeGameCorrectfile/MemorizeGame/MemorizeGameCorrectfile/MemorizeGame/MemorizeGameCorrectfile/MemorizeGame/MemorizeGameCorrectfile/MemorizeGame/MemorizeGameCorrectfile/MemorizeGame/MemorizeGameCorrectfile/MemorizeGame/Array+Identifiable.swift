//
//  Array+Identifiable.swift
//  MemorizeGame
//  optional finds the first mathc of identifiables
//  Created by Dawn Bacon on 1/30/21.
//

import Foundation
extension Array where Element: Identifiable {
    
     func firstindex(matching: Element) -> Int? {
        //optional
        for index in 0..<self.count {
            if self[index].id == matching.id {
                //return index
            }
            
            
        }
        
        return nil
     }
}
