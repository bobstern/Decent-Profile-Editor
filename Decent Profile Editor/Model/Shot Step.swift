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
    
    
    enum PumpTypes : String, CaseIterable {
        case pressure, flow
        var obverse: String {
            switch self {
            case .pressure:
                return "    flow"
            case .flow:
                return "pressure"
            }
        }
    }
    
    //// display = computed property:
    //enum ExitOrLimit : String, CaseIterable {
    //    // popup displays in this order:
    //    case limit, exitOver, exitUnder
    //    case zero = "0"
    //    var display : String {
    //        switch self {
    //        case .zero :
    //            return "      n/a"
    //        case .limit :
    //            return "limit "
    //        case .exitOver :
    //            return "exit > "
    //        case.exitUnder :
    //            return "exit < "
    //        }
    //    }
    //}
    
    // display = computed property:
    enum ExitOrLimitTypes : String, CaseIterable {
        // popup displays in this order:
        case zero = "0"
        case limit, pressure_over, pressure_under, flow_over, flow_under //pressure_limit,flow_limit
        var display : String {
            switch self {
            case .zero :
                return " " // alternately "      n/a"
            case .limit:
                return "    limit "
            //        case .pressure_limit :
            //            return "pressure limit "
            //        case .flow_limit :
            //            return "    flow limit "
            case .pressure_over :
                return "pressure exit > "
            case.pressure_under :
                return "pressure exit < "
            case .flow_over :
                return "    flow exit > "
            case.flow_under :
                return "    flow exit < "
            }
        }
    }
    
    enum Ramp : String, CaseIterable {
        case fast, smooth
        var display : String {
            switch self {
            case .fast :
                return ""
            case .smooth :
                return "slow"
            }
        }
    }
    
} // end ShotStep struct
