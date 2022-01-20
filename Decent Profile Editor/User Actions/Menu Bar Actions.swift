//
//  Menu Actions.swift
//  HQP Mac
//
//  Created by bob on 11/21/2021.
//

import Foundation
import AppKit

// Menu action calls closure in .onCommand view modifier in whichever view is active.
// .onCommand must specify #selector identifying this class name and one of its functions.
// eg: .onCommand( #selector(MenuActions.playMenu) ) { }

// Cntl-drag from Storyboard menu item to this class
// and specify target object as First Responder.
// Circle is never filled black.


// This class is only for menu actions that call .onCommand view modifiers.
// To call an application method that's not tied to a specific view, ie, a specific profile instance,
// connect Storyboard menu item to an @IBAction func in AppDelegate.

class MenuActions {

    @IBAction func deleteMenu (_ sender: Any) {
        print("DELETE MENU ITEM PRESSED")
    }
    
    @IBAction func copyTclMenu(_ sender: Any) {
        print("COPY TCL MENU ITEM PRESSED")
    }
    
    @IBAction func saveTclMenu(_ sender: Any) {
        print("SAVE MENU ITEM PRESSED")
    }
    
    @IBAction func copyTclMenu2(_ sender: Any) {
        print("PLAY MENU ITEM PRESSED")
    }
}
