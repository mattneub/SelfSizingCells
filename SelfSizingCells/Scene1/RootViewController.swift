

import UIKit

class Cell : UITableViewCell {
    @IBOutlet weak var lab : UILabel!
}

class RootViewController : UITableViewController {
    var trivia = [String]()
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    let cellID = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let b = UIBarButtonItem(primaryAction: UIAction(title: "Next") { _ in
            self.navigationController?.pushViewController(RootViewController2(), animated: true)
        })
        self.navigationItem.rightBarButtonItem = b
        
        let url = Bundle.main.url(forResource:"trivia", withExtension: "txt")
        let s = try! String(contentsOf:url!)
        let arr = s.components(separatedBy:"\n")
        self.trivia = Array(arr.dropLast())
        
        self.tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: self.cellID)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trivia.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! Cell
        cell.backgroundColor = .white
        cell.lab.text = self.trivia[indexPath.row]
        return cell
    }
    
}
