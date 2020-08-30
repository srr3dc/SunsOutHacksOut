//
//  RunViewController.swift
//  locationv2
//
//  Created by Samantha 2 on 8/30/20.
//  Copyright © 2020 Samantha 2. All rights reserved.
//

import UIKit
import CoreLocation
import RadarSDK
import MapKit


class RunViewController: UIViewController, CLLocationManagerDelegate {
    


    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var monsterImage: UIImageView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    var run: Run!
    
     private var seconds = 0
     private var timer: Timer?
     private var distance = Measurement(value: 0, unit: UnitLength.meters)
     private var locationList: [CLLocation] = []
    
    let vampire = UIImage(named: "vampire")
    let witch = UIImage(named: "witch")
    let zombie = UIImage(named: "zombie")
    let wereman = UIImage(named: "wolfman")
    let rock = UIImage(named: "rock")
    
    override func viewDidLoad(){
        super.viewDidLoad()
        checkLocationServices()
    
        locationManager.startUpdatingLocation()

        configureView()
        
        if Constants.picked == "rock"{
            monsterImage.image = rock
        }
        if Constants.picked == "witch"{
                   monsterImage.image = witch
               }
        if Constants.picked == "zombie"{
                   monsterImage.image = zombie
               }
        if Constants.picked == "vampire"{
                   monsterImage.image = vampire
               }
        if Constants.picked == "wolfman"{
                   monsterImage.image = wereman
               }

    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
       if CLLocationManager.locationServicesEnabled() { setupLocationManager()
        checkLocationAuthorization()}
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init (center:location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
           mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    private func startRun() {
      seconds = 0
      distance = Measurement(value: 0, unit: UnitLength.meters)
    configureView()
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      }
    }
    
    @IBAction func startTapped() {
             startRun()
         }
    
    private func configureView() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.milesPerHour)
         
        if distanceLabel != nil {distanceLabel.text = "Distance:  \(formattedDistance)"}
        if timeLabel != nil {timeLabel.text = "Time:  \(formattedTime)"}
        if paceLabel != nil  {paceLabel.text = "Pace:  \(formattedPace)"}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


