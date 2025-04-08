

import UIKit

class SpaceTimeListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func planetGotTapped(_ sender: UIButton) {
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "SpaceTimeDetailsViewController") as? SpaceTimeDetailsViewController {
            detailsVC.index = sender.tag
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    @IBAction func returnToMain(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
