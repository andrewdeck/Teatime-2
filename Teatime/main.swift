//
//  main.swift
//  Teatime
//
//  Created by andrew deck on 7/20/16.
//  Copyright © 2016 Andrew Deck. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

func flashScreen(_ times:Int) {
    let duration: CGDisplayFadeInterval = 0.75
    
    var fadeToken: CGDisplayFadeReservationToken = 0
    let err = CGAcquireDisplayFadeReservation(15, &fadeToken)
    if Int(err.rawValue) != Int(0) {
        NSLog("Error acquiring fade reservation")
        return
    }
    
    for _ in 1...times {
        CGDisplayFade(fadeToken, duration/2,
                      0.0 as CGDisplayBlendFraction, 0.8 as CGDisplayBlendFraction,
                      0.0, 0.0, 0.0,
                      boolean_t(1))
        CGDisplayFade(fadeToken, duration/2,
                      0.8 as CGDisplayBlendFraction, 0.0 as CGDisplayBlendFraction,
                      0.0, 0.0, 0.0,
                      boolean_t(1))
    }
    CGReleaseDisplayFadeReservation(fadeToken)
}



if CommandLine.arguments.count < 2 {
    print("Usage: teatime <number of minutes to steep>")
    exit(EXIT_FAILURE)
} else {
    let steepTime = CommandLine.arguments[1]
    let intSteepTime = UInt32(steepTime)!
    
    sleep(intSteepTime*60)
    flashScreen(3)
}

