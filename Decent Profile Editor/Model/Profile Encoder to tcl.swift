//
//  Profile Encode to Tcl.swift
//  Decent Profile Editor
//
//  Created by bob on 12/06/2021.
//

import Cocoa

extension Profile {
    
    func encodeTcl (toClipboard: Bool = false) -> String {
        var tcl = "advanced_shot {"
        var tclSteps : Array<String> = []
        for step in self.shotSteps {
            tclSteps.append(encodeStepTcl(step))
        }
        tcl += tclSteps.joined(separator: " ")  + "}\n"
        tcl += "profile_title {\(self.profileTitle)}\n"
        
        // TO DO: Add these as editable fields:
        tcl += "profile_notes {}\n"
        tcl += "author Bob\n"
        
        // Profile Limits page:
        tcl += "final_desired_shot_volume_advanced_count_start \(self.volume_track_after_step)\n"
        tcl += "final_desired_shot_volume_advanced \(self.stopVolume)\n"
        tcl += "maximum_pressure_range_advanced \(self.profilePressureLimiterRange)\n"
        tcl += "maximum_flow_range_advanced \(self.profileFlowLimiterRange)\n"
        tcl += "tank_desired_water_temperature 0\n"
        
        // Hidden from GUI:
        tcl += "espresso_temperature_steps_enabled 1\n"
        tcl += "settings_profile_type settings_2c\n"
        tcl += "profile_hide 0\n"
        
        if toClipboard {
            //            let clipboard = NSPasteboard.general
            //            clipboard.clearContents()
            NSPasteboard.general.setString(tcl, forType: .string)
        }
        return tcl
    }
    
    
    func encodeStepTcl(_ step: ShotStep) -> String {
        var tcl = "{"
        tcl += "name {\(step.descrip)} "
        tcl += "transition \(step.ramp.rawValue) "
        tcl += "temperature \(step.temp) "
        tcl += "pump \(step.pumpType.rawValue) \(step.pumpType.rawValue) \(step.pumpVal) "
        tcl += "transition \(step.ramp) "
        tcl += "seconds \(step.time) "
        
        switch step.exitOrLimitCondx {
        case .zero:
            tcl += "exit_if 0 "
        case .limit:
            tcl += "exit_if 0 "
            tcl += "max_flow_or_pressure \(step.exitOrLimitVal) "
            tcl += "max_flow_or_pressure_range "
            if step.pumpType == .flow {
                tcl += profilePressureLimiterRange + " "
            } else {
                tcl += profileFlowLimiterRange + " "
            }
        case .flow_over, .flow_under, .pressure_over, .pressure_under:
            tcl += "exit_if 1 "
            tcl += "exit_type \(step.exitOrLimitCondx.rawValue) "
            tcl += "exit_\(step.exitOrLimitCondx.rawValue) \(step.exitOrLimitVal) "
        }
        
        /*
         // Old version before case .limit added:
         if self.exitOrLimitCondx == .zero {
         tcl += "exit_if 0 " // exit_type 0 "
         } else {
         tcl += "exit_if 1 "
         tcl += "exit_type \(self.exitOrLimitCondx.rawValue) "
         tcl += "exit_\(self.exitOrLimitCondx.rawValue) \(self.exitOrLimitVal) "
         }
         */
        
        
        tcl += "volume 999 sensor coffee}"
        return tcl
    }
    
}
