//
//  ViewController.swift
//  UIImageViewTesting
//
//  Created by Edward O'Neill on 12/5/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let imageArray = ["https://cdn.arstechnica.net/wp-content/uploads/2016/02/5718897981_10faa45ac3_b-640x624.jpg", "https://apod.nasa.gov/apod/image/1912/NGC6744_FinalLiuYuhang.jpg", "https://interactive-examples.mdn.mozilla.net/media/examples/grapefruit-slice-332-332.jpg", "https://image.shutterstock.com/z/stock-photo-large-beautiful-drops-of-transparent-rain-water-on-a-green-leaf-macro-drops-of-dew-in-the-morning-668593321.jpg", "https://image.shutterstock.com/image-photo/beautiful-water-drop-on-dandelion-260nw-789676552.jpg", "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://www.w3schools.com/w3css/img_lights.jpg"]
    var gameTimer: Timer?
    var number = 0
    var testCell = TableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementX") as? TableViewCell else {return UITableViewCell()}
        testCell = cell
        gameTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        return cell
    }
    
        @objc func onTimerFires() {
            testCell.elementImage.load(url: URL(string: imageArray.randomElement() ?? "")! )
    //        if number == 70 {
    //            gameTimer?.invalidate()
    //        }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData = try Data(contentsOf: url)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print("contents of error: \(error)")
            }
        }
    }
}
