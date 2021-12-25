//  Profile & Shot models.swift
//  Bob Stern 2021-12-07

import Cocoa

struct Profile {
    weak var window: NSWindow? // window retains vm which retains profile.
    var stepDictsArray : Array<[String:String]> = [] // TO TO: convert to computed var.
    var shotContainerPath = ""
    //    var shotSteps : Array<ShotStep> = []
    var shotSteps = [ShotStep()] // init w one empty step.
    var stepsCount : Int {shotSteps.count}
    //    var profileDict : [String:String] = [:]
    var profileTitle = "" {
        didSet {
            window?.title = profileTitle // Ignored if window nil.
        }
    }
    var profileNotes = ""
    var author = ""  // Bob
    var volume_track_after_step = "0" // Preinfusion = 2. Key = final_desired_shot_volume_advanced_count_start.
    var profilePressureLimiterRange = "0.1" // key = maximum_pressure_range_advanced
    var profileFlowLimiterRange = "0.1" // key = maximum_flow_range_advanced
    var tank_desired_water_temperature = "0"
    var stopVolume = "0"
    
    init() {}
    
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
} // end Profile struct
