

import UIKit

class RootViewController3: UITableViewController {

    var trivia = [String]()
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    let cellID = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource:"trivia", withExtension: "txt")
        let s = try! String(contentsOf:url!)
        let arr = s.components(separatedBy:"\n")
        self.trivia = Array(arr.dropLast())
        
        self.tableView.register(UINib(nibName: "Cell2", bundle: nil), forCellReuseIdentifier: self.cellID)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // extremely weird solution
    var didInitialLayout = false
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !didInitialLayout {
            didInitialLayout = true
            UIView.performWithoutAnimation {
//                self.tableView.beginUpdates()
//                self.tableView.endUpdates()
                // or can say it this way instead
                self.tableView.performBatchUpdates(nil, completion: nil)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trivia.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! Cell2
        cell.backgroundColor = .white
        let s = NSAttributedString(string: self.trivia[indexPath.row], attributes: [
            .foregroundColor : UIColor.darkText,
            .font : UIFont(name: "Helvetica", size: 14)!
        ])
        cell.drawer.attributedText = s
        return cell
    }

}
