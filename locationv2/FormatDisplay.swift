//
//  FormatDisplay.swift
//  locationv2
//
//  Created by Samantha 2 on 8/30/20.
//  Copyright © 2020 Samantha 2. All rights reserved.
//

import Foundation
import UIKit

struct FormatDisplay {
  static func distance(_ distance: Double) -> String {
    let distanceMeasurement = Measurement(value: distance, unit: UnitLength.meters)
    return FormatDisplay.distance(distanceMeasurement)
  }
  
  static func distance(_ distance: Measurement<UnitLength>) -> String {
    let formatter = MeasurementFormatter()
    return formatter.string(from: distance)
  }
  
  static func pace(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
    let formatter = MeasurementFormatter()
    formatter.unitOptions = [.providedUnit] // 1
    let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
    let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
    return formatter.string(from: speed.converted(to: outputUnit))
  }
    
    static func time(_ seconds: Int) -> String {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute, .second]
      formatter.unitsStyle = .positional
      formatter.zeroFormattingBehavior = .pad
      return formatter.string(from: TimeInterval(seconds))!
    }
  
}
