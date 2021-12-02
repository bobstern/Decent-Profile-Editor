//  Shot Step model.swift
//  Decent Shot - Export to Table
//  Bob Stern 2020-07-12

import Cocoa

struct ShotStep : Identifiable, Hashable {
    var id = UUID() // Hashable reqd by ForEach(Array( .enumerated
    var descrip = ""
    var ramp = Ramp.fast
    var temp = ""
    var pumpType = PumpTypes.pressure
    var pumpVal = ""
    // var pumpDisplay : String {return pumpType.rawValue + " " + pumpVal}
    var time = ""
    var exitOrLimitCondx = ExitOrLimitTypes.zero
    var exitOrLimitVal = ""
    // var exitDisplay:String {return (exitType.display + exitVal)}
    
    func encodeTcl() -> String {
        var tcl = "{"
        tcl += "name {\(self.descrip)} "
        tcl += "transition \(self.ramp.rawValue) "
        tcl += "temperature \(self.temp) "
        tcl += "pump \(self.pumpType.rawValue) \(self.pumpType.rawValue) \(self.pumpVal) "
        tcl += "transition \(self.ramp) "
        tcl += "seconds \(self.time) "
        if self.exitOrLimitCondx == .zero {
            tcl += "exit_if 0 " // exit_type 0 "
        } else {
            tcl += "exit_if 1 "
            tcl += "exit_type \(self.exitOrLimitCondx.rawValue) "
            tcl += "exit_\(self.exitOrLimitCondx.rawValue) \(self.exitOrLimitVal) "
        }
        tcl += "volume 999 sensor coffee}"
        return tcl
    }
}

enum PumpTypes : String, CaseIterable {case pressure, flow}

// display = computed property:
enum ExitOrLimitTypes : String, CaseIterable {
    // popup displays in this order:
    case pressure_limit, pressure_over, pressure_under, flow_limit, flow_over, flow_under
    case zero = "0"
    var display : String {
        switch self {
        case .zero :
            return "      n/a"
        case .pressure_limit :
            return "pressure limit "
        case .flow_limit :
            return "    flow limit "
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
