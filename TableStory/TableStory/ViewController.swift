//
//  ViewController.swift
//  TableStory
//
//  Created by Amezcua, Bella G on 3/20/24.
//

import UIKit
import MapKit

let data = [
    Item(name: "The Coffee Bar", neighborhood: "Downtown", desc: "The Coffee Bar has a great menu and fun music to help you decompress during those tough study sessions!", lat: 29.88707824751259, long: -97.94045238440557, imageName: "rest1"),
    Item(name: "Mochas & Javas", neighborhood: "Hyde Park", desc: "A comfortable place for the community to come together while enjoying extraordinary beverages, food, and legendary customer service. ", lat:29.89658660642566, long: -97.94057573858085, imageName: "rest2"),
    Item(name: "Tantra", neighborhood: "Mueller", desc: "Enjoy a nice cup of coffee or tea while listening to live music at Tantra's relaxing coffee shop! Tantra's atmosphere is comforting and cool due to their awesome staff.", lat:29.888422241255956, long: -97.94388638442337, imageName: "rest3"),
    Item(name: "The Sweet Spot", neighborhood: "Downtown", desc: "Craving a sweet treat? This cafe carries fun drinks and the yummiest snacks you can think of.  ", lat: 29.8842928567984,long: -97.93981837166598, imageName: "rest4"),
    Item(name: "Crater Coffee Co.", neighborhood: "Hyde Park", desc: "This coffee shop strives to create a perfect beverage for a quick pick-me-up during the day.", lat:29.88603206406401, long: -97.93850306932956, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name
        
        //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        return cell!
        
        
    }
        
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }
        
    // add this function to original ViewController
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "ShowDetailSegue" {
              if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                  // Pass the selected item to the detail view controller
                  detailViewController.item = selectedItem
              }
          }
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.883525469952623, longitude: -97.9413973208416)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }
        
        
    }


}

