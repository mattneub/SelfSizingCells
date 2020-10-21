
// this fourth scene is not for purposes of the demonstration
// it's just something I added to prove that this solution works with configurations
// that's why I've stuck it into a branch

import UIKit

struct Config : UIContentConfiguration {
    var attributedText = NSAttributedString()
    func makeContentView() -> UIView & UIContentView {
        return ContentView(configuration:self)
    }
    
    func updated(for state: UIConfigurationState) -> Config {
        return self
    }
}
class ContentView : UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            config()
        }
    }
    let drawer = StringDrawer()
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.addSubview(drawer)
        drawer.translatesAutoresizingMaskIntoConstraints = false
        drawer.isOpaque = false
        drawer.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        drawer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        drawer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        drawer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config() {
        self.drawer.attributedText = (self.configuration as! Config).attributedText
    }
}

class RootViewController4: UITableViewController {

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
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
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
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
        cell.backgroundColor = .white
        let s = NSAttributedString(string: self.trivia[indexPath.row], attributes: [
            .foregroundColor : UIColor.darkText,
            .font : UIFont(name: "Helvetica", size: 14)!
        ])
        var config = Config()
        config.attributedText = s
        cell.contentConfiguration = config
        return cell
    }
    
}
