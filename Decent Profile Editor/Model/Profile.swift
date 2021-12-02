//  Shot struct.swift
//  Decent Shot - Export to Table
//  Bob Stern 2020-07-12

import Cocoa

struct Profile {
    private var stepDictsArray : Array<[String:String]> = [] // To Do: convert to computed var.
    var shotContainerPath = ""
//    var shotSteps : Array<ShotStep> = []
    var shotSteps = [ShotStep()] // init w one empty step.
    var stepsCount : Int {shotSteps.count}
//    var profileDict : [String:String] = [:]
    var profileTitle = ""
    var profileNotes = ""
    var author = ""  // Bob
    var volume_track_after_step = "0" // Preinfusion = 2. Key = final_desired_shot_volume_advanced_count_start.
    var press_dampen_range = "0.1" // key = maximum_pressure_range_advanced
    var flow_dampen_range = "0.1" // key = maximum_flow_range_advanced
    var tank_desired_water_temperature = "0"
    var stopVolume = "0"
    
    init() {
    }
    
    init(fromTcl inputTcl: String, shotContainerPath: String) {
        self.init(fromTcl: inputTcl)
        self.shotContainerPath = shotContainerPath
    }
    
    init(fromTcl inputTcl: String) {
        self.stepDictsArray = stepDictsArrayDecode(from: inputTcl)
        self.shotSteps = shotStepObjects(from: self.stepDictsArray)
        let profileDict = profileDictDecode(from: inputTcl)
        // print("PROFILE DEBUG " + self.profileDict.debugDescription)
        self.profileTitle = profileDict["profile_title"] ?? ""
        self.volume_track_after_step = profileDict["final_desired_shot_volume_advanced_count_start"] ?? "0" // Preinfusion = 2
        self.press_dampen_range = profileDict["maximum_pressure_range_advanced"] ?? "0.1"
        self.flow_dampen_range = profileDict["maximum_flow_range_advanced"] ?? "0.1"
        self.stopVolume = profileDict["final_desired_shot_volume_advanced"] ?? "0"
//        self.profileDict = profileDictDecode(from: inputTcl)
//        // print("PROFILE DEBUG " + self.profileDict.debugDescription)
//        self.profileTitle = self.profileDict["profile_title"] ?? ""
//        self.volume_track_after_step = self.profileDict["final_desired_shot_volume_advanced_count_start"] ?? "0" // Preinfusion = 2
//        self.press_dampen_range = self.profileDict["maximum_pressure_range_advanced"] ?? "0.1"
//        self.flow_dampen_range = self.profileDict["maximum_flow_range_advanced"] ?? "0.1"
//        self.stopVolume = self.profileDict["final_desired_shot_volume_advanced"] ?? "0"
    }
    
    
    func encodeTcl (toClipboard: Bool = false) -> String {
        var tcl = "advanced_shot {"
        var tclSteps : Array<String> = []
        for step in self.shotSteps {
            tclSteps.append(step.encodeTcl())
        }
        tcl += tclSteps.joined(separator: " ")  + "}\n"
        tcl += "profile_title {\(self.profileTitle)}\n"
        
        // TO DO: Add these as editable fields:
        tcl += "profile_notes {}\n"
        tcl += "author Bob\n"
        
        // Profile Limits page:
        tcl += "final_desired_shot_volume_advanced_count_start \(self.volume_track_after_step)\n"
        tcl += "final_desired_shot_volume_advanced \(self.stopVolume)\n"
        tcl += "maximum_pressure_range_advanced \(self.press_dampen_range)\n"
        tcl += "maximum_flow_range_advanced \(self.flow_dampen_range)\n"
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
}
    

    func shotStepObjects(from stepDictsArray: Array<[String:String]>) -> Array<ShotStep> {

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

            switch newStep.pumpType {
            case .pressure :
                newStep.pumpVal = stepDict["pressure"]!
            case .flow :
                newStep.pumpVal = stepDict["flow"]!
            }
            newStep.pumpVal = rnd(newStep.pumpVal)

            if stepDict["exit_if"] == "1" {
                newStep.exitType = ExitTypes(rawValue: stepDict["exit_type"]!)!
            }
            switch newStep.exitType {
            case .zero :
                break
            case .pressure_over :
                newStep.exitVal = stepDict["exit_pressure_over"]!
            case.pressure_under :
                newStep.exitVal = stepDict["exit_pressure_under"]!
            case .flow_over :
                newStep.exitVal = stepDict["exit_flow_over"]!
            case.flow_under :
                newStep.exitVal = stepDict["exit_flow_under"]!
            }
            newStep.exitVal = rnd(newStep.exitVal)

            shotStepObjectArray.append(newStep)
            // print("Step \(stepN);  Pump: \(newStep.pumpDisplay);  Exit: \(newStep.exitDisplay)")
        }
        // print(shotStepObjectArray)


        //
        // Export as tab-delimited (TSV) format:
        //

//        var tempShotTSV = "Description\tStep\tTran-sition\tTemp\tPump\tTime\tExit\n"
//        for (stepN, shotStep) in shotStepObjectArray.enumerated() {
//            tempShotTSV += "\(shotStep.descrip)\t\(String(stepN+1))\t\(shotStep.ramp.rawValue)\t\(shotStep.temp)\t\(shotStep.pumpDisplay)\t\(shotStep.time)\t\(shotStep.exitDisplay)\n"
//        }
//        tempShotTSV += "\n" // 2 newlines delimit end of table for Nisus macro.
//        return tempShotTSV
        return shotStepObjectArray
    }


func profileTitleDecode(from inputTcl: String) -> String {
    var titleDelimiter1 : String // components delimiter.
    var titleDelimiter2 : Character // split delimiter.
    if inputTcl.contains(Character("\t")) {
        titleDelimiter1 = "\tprofile_title " // Shot file.
        } else {
        titleDelimiter1 = "\nprofile_title "  // tcl Profile file.
    }
    let titleDelimitedArray = inputTcl.components(separatedBy: titleDelimiter1)
    guard titleDelimitedArray.count == 2 else {
        print("Empty Title for shot or profile.")
        return ""
        
    }
    var titlePrefix = titleDelimitedArray[1] // 0-based; retains text after delimiter.
    if titlePrefix.hasPrefix("{") {
        titlePrefix.removeFirst()
        titleDelimiter2 = "}"
    } else {
        titleDelimiter2 = "\n"
    }
    let titlePrefixArray = titlePrefix.split(separator: titleDelimiter2)
    return String(titlePrefixArray[0])
    // print ("Title = \(ShotInputFile.profileTitle)")
} // end profileTitle()

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
        tempStepDictsArray.append(decodeTCLtoDict(kvTxt: step))
    }
    return tempStepDictsArray
}


func decodeTCLtoDict(kvTxt: String ) -> [String:String] {
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

func profileDictDecode(from inputTcl : String) -> [String:String] {
    let emptyDict = [String:String]()
    var profileDict  = [String:String]()
    var tempArr : [String] = []
    var multiWordVal = ""
    
    // Shot param lines begin w tab; ignored in profile:
    let tempStr = inputTcl.replacingOccurrences(of: "\t", with: "")
    
    // Delete suffix from shot; ignored in profile:
    tempArr = tempStr.components(separatedBy: "\n}\nmachine {")
    // print("AA " + tempArr.debugDescription)
    // keep prefix:
    tempArr = tempArr[0].components(separatedBy: "advanced_shot {{")
    // print("BB " + tempArr.debugDescription)
    if tempArr.count != 2 {return emptyDict}
    // keep suffix:
    tempArr = tempArr[1].components(separatedBy: "}}\n")
    // print("CC " + tempArr.debugDescription)
    if tempArr.count < 2  {return emptyDict}
    
    // keep suffix:
    // \n delimits dict elements:
    let dictArr = tempArr[1].components(separatedBy: "\n")
    for dictStr in dictArr {
        var dictWords = dictStr.components(separatedBy: " ")
        if dictWords.count < 2 {break}
        
        if dictWords.count == 2 {
            profileDict[dictWords[0] ] = dictWords[1]
        } else {
            let dictKey = dictWords[0]
            dictWords = dictStr.components(separatedBy: "{")
            if dictWords.count != 2 {break}
            multiWordVal = dictWords[1]
            guard multiWordVal.popLast() == "}" else {break}
            profileDict[dictKey] = multiWordVal
        }
    }
    return profileDict
}
