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
    var exitType = ExitTypes.zero
    var exitVal = ""
    // var exitDisplay:String {return (exitType.display + exitVal)}
    
    func encodeTcl() -> String {
        var tcl = "{"
        tcl += "name {\(self.descrip)} "
        tcl += "transition \(self.ramp.rawValue) "
        tcl += "temperature \(self.temp) "
        tcl += "pump \(self.pumpType.rawValue) \(self.pumpType.rawValue) \(self.pumpVal) "
        tcl += "transition \(self.ramp) "
        tcl += "seconds \(self.time) "
        if self.exitType == .zero {
            tcl += "exit_if 0 " // exit_type 0 "
        } else {
            tcl += "exit_if 1 "
            tcl += "exit_type \(self.exitType.rawValue) "
            tcl += "exit_\(self.exitType.rawValue) \(self.exitVal) "
        }
        tcl += "volume 999 sensor coffee}"
        return tcl
    }
}

enum PumpTypes : String, CaseIterable {case pressure, flow}

// display = computed property:
enum ExitTypes : String, CaseIterable {
    case pressure_over, pressure_under, flow_over, flow_under
    case zero = "0"
    var display : String {
        switch self {
        case .zero :
            return "      n/a"
        case .pressure_over :
            return "pressure > "
        case.pressure_under :
            return "pressure < "
        case .flow_over :
            return "   flow > "
        case.flow_under :
           return "   flow < "
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
