//
//  Shot Step.swift
//  Decent Profile Editor
//
//  Created by bob on 1/19/2022.
//

import Foundation

struct ShotStep : Identifiable, Hashable {
    var id = UUID() // Hashable reqd by ForEach(Array( .enumerated
    var descrip = ""
    var ramp = Ramp.fast
    var temp = ""
    var pumpType = PumpTypes.pressure {
        didSet {
            if self.pumpType != oldValue, self.exitOrLimitCondx == .limit {
                self.exitOrLimitCondx = .zero
                self.exitOrLimitVal = "0"
            }
        }
    }
    var pumpVal = ""
    // var pumpDisplay : String {return pumpType.rawValue + " " + pumpVal}
    var time = ""
    var exitOrLimitCondx = ExitOrLimitTypes.zero
    var exitOrLimitVal = ""
    // var exitDisplay:String {return (exitType.display + exitVal)}
    
}
