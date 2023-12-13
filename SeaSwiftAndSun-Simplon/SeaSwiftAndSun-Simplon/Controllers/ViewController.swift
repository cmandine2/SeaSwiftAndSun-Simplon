import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var spots: [Spot] = []
    var surfBreakSections: [String] = []
    var spotsBySurfBreak: [String: [Spot]] = [:]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getSpot()
        self.title = "Surf Spots"
        self.navigationController?.navigationBar.accessibilityIdentifier = "SurfSpotsNavigationBar"
        
        self.tableView.accessibilityIdentifier = "SurfSpotsTableView"
    }
    func getSpot() {
        SpotService.shared.getSpot { error, destination in
            guard let destination = destination else {
                return
            }
            
            self.spots = destination.spots
            
            // Populate the sections and organize spots by Surf Break
            self.surfBreakSections = Array(Set(self.spots.map { $0.fields.surfBreak.joined(separator: ", ") }))
            for surfBreak in self.surfBreakSections {
                self.spotsBySurfBreak[surfBreak] = self.spots.filter { $0.fields.surfBreak.contains(surfBreak) }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return surfBreakSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return surfBreakSections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let surfBreak = surfBreakSections[section]
        return spotsBySurfBreak[surfBreak]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as! SpotCell
            let surfBreak = surfBreakSections[indexPath.section]
            if let spotsInSection = spotsBySurfBreak[surfBreak] {
                cell.setUpCell(spot: spotsInSection[indexPath.row])
            }

            cell.accessibilityIdentifier = "SpotCell"

            return cell
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()

            headerView.accessibilityIdentifier = "SectionHeader"

            return headerView
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpotDetails",
           let indexPath = self.tableView.indexPathForSelectedRow,
           let controller = segue.destination as? DetailSpotViewController {
            let selectedSpot = spots[indexPath.row]
            controller.selectedSpot = selectedSpot
            
            if let cell = tableView.cellForRow(at: indexPath) as? SpotCell {
                controller.selectedImage = cell.spotImage.image
            }
        }
    }

}
