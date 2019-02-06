//
//  StringLength.swift
//  HutchDecor
//
//  Created by Aseem 13 on 12/09/16.
//  Copyright © 2016 Taran. All rights reserved.
//

import UIKit

extension String {
    
    func StringByEscapingCharacters() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
