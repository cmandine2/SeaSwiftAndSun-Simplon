import UIKit

class DetailSpotViewController: UIViewController {
    var selectedSpot: Spot?
    var selectedImage: UIImage?
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let spot = selectedSpot {
            self.setUpUI(spot: spot)
        }
    }
    
    func setUpUI(spot: Spot) {
        self.spotImage.image = self.selectedImage
        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2
        self.spotName.text = spot.fields.destination
        self.setUpSpotDetails(spot: spot)
    }
    
    private func setUpSpotDetails(spot: Spot) {
        let peakSurfSeason: [(title: String, dates: String)] = [
            ("Peak Surf Season", "\(spot.fields.peakSurfSeasonBegins)・\( spot.fields.peakSurfSeasonEnds)")
        ]
        var previousView : UIView = self.detailsView
        
        for (title, dates) in peakSurfSeason {
            let lineView = LineView()
            lineView.setUpLineContent(title: title, schedule: dates)
            self.detailsView.addSubview(lineView)
            lineView.translatesAutoresizingMaskIntoConstraints = false
            if previousView === self.detailsView {
                lineView.topAnchor.constraint(equalTo: previousView.topAnchor).isActive = true
            } else {
                lineView.topAnchor.constraint(equalTo: previousView.bottomAnchor).isActive = true
            }
            
            lineView.leftAnchor.constraint(equalTo: self.detailsView.leftAnchor).isActive = true
            lineView.rightAnchor.constraint(equalTo: self.detailsView.rightAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            previousView = lineView
        }
        
        let contactDetails: [(icon: String, detail: String)] = [
            ("mappin.and.ellipse", spot.fields.destinationStateCountry),
            ("link", spot.fields.magicSeaweedLink)
        ]
        
        for (icon,detail) in contactDetails {
                let lineView2 = LineView2()
                lineView2.setUpLineContent(icon: icon, detail: detail)
                self.detailsView.addSubview(lineView2)
                lineView2.translatesAutoresizingMaskIntoConstraints = false
                lineView2.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 10).isActive = true
                lineView2.leftAnchor.constraint(equalTo: self.detailsView.leftAnchor).isActive = true
                lineView2.rightAnchor.constraint(equalTo: self.detailsView.rightAnchor).isActive = true
                lineView2.heightAnchor.constraint(equalToConstant: 25).isActive = true
                previousView = lineView2
            }
        
        
        
    }
}
class LineView: UIView {
    var title: String = ""
    var schedule: String = ""
    
    func setUpLineContent(title: String,  schedule: String) {
        self.title = title
        self.schedule = schedule
        
        self.setUp()
    }
    
    func setUp() {
        let clockImageView: UIImageView = UIImageView(image: UIImage(systemName: "clock"))
        self.addSubview(clockImageView)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        clockImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        clockImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        clockImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        clockImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        let titleLabel: UILabel = UILabel()
        titleLabel.text = self.title
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: clockImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let scheduleLabel: UILabel = UILabel()
        scheduleLabel.text = self.schedule
        
        scheduleLabel
            .textAlignment = .right
        self.addSubview(scheduleLabel)
        
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        scheduleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        scheduleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scheduleLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        scheduleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}

class LineView2: UIView {
    var icon: String = ""
    var detail: String = ""
    
    func setUpLineContent(icon: String,  detail: String) {
        self.icon = icon
        self.detail = detail
        
        self.setUp()
    }
    
    func setUp() {
        let iconImageView: UIImageView = UIImageView(image: UIImage(systemName: icon))
        self.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        let detailLabel: UILabel = UILabel()
        detailLabel.text = self.detail
        self.addSubview(detailLabel)
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        detailLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        detailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
}
