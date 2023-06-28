//
//  Profile Decoders from tcl.swift
//  Decent Profile Editor
//
//  Created by bob on 12/07/2021.
//

import AppKit

extension Profile {
    
    init(fromTcl inputTcl: String, shotContainerPath: String, window: NSWindow) {
        self.init(fromTcl: inputTcl, window: window)
        self.shotContainerPath = shotContainerPath
    }
    
    init(fromTcl inputTcl: String, window: NSWindow) {
        // get Profile Parameters as array of steps, where
        // each step is a dict of parameters:
        let splitArray = inputTcl.components(separatedBy: "advanced_shot {{")
        guard splitArray.count == 2 else {exit(0)}
        
        // Discard splitArray[0] = tcl preceding "advanced_shot":
        // nil if .tcl;
        // realtime samples if .shot:
        var stepsTclStr = splitArray[1]
        let splitArray2 = stepsTclStr.components(separatedBy: "}}\n")
        stepsTclStr = splitArray2[0]
        
// Profile Global Params are between shot steps and machine params, so
// delete machine settings at end of .shot files.
// Also delete cosmetic tabs in .shot files.
// profileGlobalTcl must begin with \n cuz reqd as delimiter
// in func decodeProfileValue(forKey: fromTcl:)
        let profileGlobalTcl = "\n" + splitArray2[1].components(separatedBy: "\n}\nmachine {")[0].replacingOccurrences(of: "\t", with: "")

//
/// decode array of Shot Step objects from stepsTclStr:
//
        let stepsTclArray = stepsTclStr.components(separatedBy: "} {")
        
        var stepDictsArray : Array<[String:String]> = []
        for step in stepsTclArray {
            stepDictsArray.append(decodeStepTCLtoDict(kvTxt: step))
        }
        self.shotSteps = decodeShotStepObjects(from: stepDictsArray)
        
//
/// decode global properties of profile from profileGlobalTclStr:
//
        self.profileTitle = decodeProfileValue(forKey: "profile_title", fromTcl: profileGlobalTcl) ?? ""
        window.title = self.profileTitle // does nothing ????
        self.window = window // Enables profileTitle.didSet.
        
        self.volume_track_after_step = decodeProfileValue(forKey:"final_desired_shot_volume_advanced_count_start", fromTcl: profileGlobalTcl) ?? "0" // Preinfusion = step 2.
        self.profilePressureLimiterRange = decodeProfileValue(forKey:"maximum_pressure_range_advanced", fromTcl: profileGlobalTcl) ?? "0.0"
        self.profileFlowLimiterRange = decodeProfileValue(forKey:"maximum_flow_range_advanced", fromTcl: profileGlobalTcl) ?? "0.0"
        self.stopVolume = decodeProfileValue(forKey:"final_desired_shot_volume_advanced", fromTcl: profileGlobalTcl) ?? "0"
    }
    
    
    func decodeProfileValue(forKey key: String, fromTcl tcl: String) -> String? {
        let splitArray = tcl.components(separatedBy: "\n" + key + " ")
        guard splitArray.count == 2 else {return nil}
        var splitStr = splitArray[1]
        if splitStr.first != "{" {
            return splitStr.components(separatedBy: "\n")[0]
        } else {
            splitStr = String(splitStr.dropFirst(1))
            return splitStr.components(separatedBy: "}")[0]
        }
    }
    
    
    func decodeShotStepObjects(from stepDictsArray: Array<[String:String]>) -> Array<ShotStep> {
        
        var shotStepObjectArray = [ShotStep]()
        
        // stepN was used only for debugging:
        // for (stepN, stepDict) in stepDictsArray.enumerated() {
        for stepDict in stepDictsArray {
            var newStep = ShotStep(pumpType: PumpTypes(rawValue: stepDict["pump"]!)!)
            
            newStep.descrip = stepDict["name"] ?? ""
            newStep.temp = rnd( stepDict["temperature"]! )
            newStep.time = rnd( stepDict["seconds"]! )
            // print (newStep.temp + "   " + newStep.time)
            
            if stepDict["transition"]! != "fast" {
                newStep.ramp = .smooth
            }
            
//            print (stepDict)
            newStep.pumpVal = rnd(newStep.pumpVal)
            switch newStep.pumpType {
            case .pressure :
                newStep.pumpVal = stepDict["pressure"]!
            case .flow :
                newStep.pumpVal = stepDict["flow"]!
            }
            
            if stepDict["exit_if"] == "1" {
                newStep.exitOrLimitCondx = ExitOrLimitTypes(rawValue: stepDict["exit_type"]!)!
            }
            switch newStep.exitOrLimitCondx {
            case .zero :
                newStep.exitOrLimitVal = ""
            case .pressure_over :
                newStep.exitOrLimitVal = stepDict["exit_pressure_over"]!
            case.pressure_under :
                newStep.exitOrLimitVal = stepDict["exit_pressure_under"]!
            case .flow_over :
                newStep.exitOrLimitVal = stepDict["exit_flow_over"]!
            case.flow_under :
                newStep.exitOrLimitVal = stepDict["exit_flow_under"]!
            case .limit :
                print("Impossible: Limit key not decoded yet!")
            }
            
            // Absence of limit signified by absence of key OR value = 0.
            if let limitVal = stepDict["max_flow_or_pressure"], limitVal != "0" {
                newStep.exitOrLimitCondx = .limit
                newStep.exitOrLimitVal = limitVal
            }
            
            shotStepObjectArray.append(newStep)
            
            // print("Step \(stepN);  Pump: \(newStep.pumpDisplay);  Exit: \(newStep.exitDisplay)")
        }
        return shotStepObjectArray
    }
    
    
    func stepDictsArrayDecode(from inputTcl : String) -> Array<[String:String]> {
        // get Profile Parameters as array of steps, where
        // each step is a dict of parameters:
        var advanced_tcl = ""
        let advanced_tcl_Array = inputTcl.components(separatedBy: "advanced_shot {{")
        guard advanced_tcl_Array.count == 2 else {exit(0)}
        advanced_tcl = advanced_tcl_Array[1] // 0-based.
        let advanced_tcl_Array2 = advanced_tcl.components(separatedBy: "}}\n")
        advanced_tcl = advanced_tcl_Array2[0]
        
        let steps_tcl_Array = advanced_tcl.components(separatedBy: "} {")
        
        var tempStepDictsArray = Array<[String:String]>()
        for step in steps_tcl_Array {
            tempStepDictsArray.append(decodeStepTCLtoDict(kvTxt: step))
        }
        return tempStepDictsArray
    }
    
    
    func decodeStepTCLtoDict(kvTxt: String ) -> [String:String] {
        var idxAfter : String.Index
        var idxBefore : String.Index
        var key1 = ""
        var val1 = ""
        var kvDict = [String:String]()
        var word1 : String
        
        enum KeyVal { case ky, val }
        var keyVal = KeyVal.ky
        var kvRemains = kvTxt
        idxAfter = kvRemains.firstIndex(of: " ") ?? kvRemains.endIndex
        while true {
            word1 = String(kvRemains[..<idxAfter])
            
            switch keyVal {
            case .ky:
                keyVal = .val
                key1 = word1
                
            case .val:
                keyVal = .ky
                if kvRemains.first != "{" {
                    val1 = word1
                } else {
                    idxBefore = kvRemains.index(kvRemains.startIndex, offsetBy: 1)
                    idxAfter = kvRemains.firstIndex(of: "}") ?? kvRemains.endIndex
                    val1 = String(kvRemains[idxBefore ..< idxAfter])
                    idxAfter = kvRemains.index(after: idxAfter) // Space after }.
                }
                
                kvDict [key1] = val1
            }
            guard idxAfter < kvRemains.endIndex else { break }
            kvRemains = String( kvRemains.suffix(from: kvRemains.index(after: idxAfter) ))
            idxAfter = kvRemains.firstIndex(of: " ") ?? kvRemains.endIndex
        }
        return kvDict
    }
    
}
