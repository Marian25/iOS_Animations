//
//  FlightData.swift
//  FlightAnimations
//
//  Created by Marian Stanciulica on 24/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import Foundation

struct FlightData {
    let summary: String
    let flightNumber: String
    let gateNumber: String
    let departingFrom: String
    let arrivingTo: String
    let weatherImageName: String
    let showWeatherEffects: Bool
    let isTakingOff: Bool
    let flightStatus: String
}

let londonToParis = FlightData(
    summary: "01 Apr 2015 09:42",
    flightNumber: "ZY 2014",
    gateNumber: "T1 A33",
    departingFrom: "LGW",
    arrivingTo: "CDG",
    weatherImageName: "bg-snowy",
    showWeatherEffects: true,
    isTakingOff: true,
    flightStatus: "Boarding")

let parisToRome = FlightData(
    summary: "01 Apr 2015 17:05",
    flightNumber: "AE 1107",
    gateNumber: "045",
    departingFrom: "CDG",
    arrivingTo: "FCO",
    weatherImageName: "bg-sunny",
    showWeatherEffects: false,
    isTakingOff: false,
    flightStatus: "Delayed")
