//
//  detailViewController.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/05.
//

import UIKit

class detailViewController: UIViewController {

    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var name = String()
    var number = String()
    var imageURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = "No." + number
        nameLabel.text = name
        imageView.sd_setImage(with: URL(string:imageURL))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
