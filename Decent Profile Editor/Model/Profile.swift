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
    var profilePressureLimiterRange = "0.0" // key = maximum_pressure_range_advanced
    var profileFlowLimiterRange = "0.0" // key = maximum_flow_range_advanced
    var tank_desired_water_temperature = "0"
    var stopVolume = "0"
 }
