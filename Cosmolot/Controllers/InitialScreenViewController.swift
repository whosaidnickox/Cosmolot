
import UIKit
import SnapKit

class InitialScreenViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchMagnifyingGlassImage: UIImageView!
    @IBOutlet var categoriesViews: [UIView]!
    @IBOutlet var categoriesIcons: [UIButton]!
    @IBOutlet var categoriesLabels: [UILabel]!
    @IBOutlet weak var stackToAddFeaturedObjects: UIStackView!
    
    var planets = Planet.fetchPlanets()
    let navigator = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search cosmic objects...",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        planets.insert(contentsOf: Planet.fetchBlackHoles(), at: 0)
        planets.insert(contentsOf: Planet.fetchGalaxies(), at: 0)
        planets.insert(contentsOf: Planet.fetchStars(), at: 0)
        setupFeaturedObjects(info: planets)
    }
    @IBAction func beginEditing(_ sender: UITextField) {
        searchMagnifyingGlassImage.isHidden = true
    }
    
    @IBAction func endEditing(_ sender: UITextField) {
        if searchTextField.text == "" {
            searchMagnifyingGlassImage.isHidden = false
        }
        guard let searchText = sender.text?.lowercased(), !searchText.isEmpty else {
            setupFeaturedObjects(info: planets) // Show all planets when search is empty
            return
        }
        
        let filteredPlanets = planets.filter { $0.name.lowercased().contains(searchText) }
        setupFeaturedObjects(info: filteredPlanets)
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {}
    
    @IBAction func categoryButtonGotClicked(_ sender: UIButton) {
        for categoryView in categoriesViews {
            if categoryView.tag == sender.tag {
                categoryView.backgroundColor = AppColors.selectedCategoryColor.color
            } else {
                categoryView.backgroundColor = AppColors.unselectedCategoryColor.color
            }
        }
        for categoryIcon in categoriesIcons {
            if categoryIcon.tag == sender.tag {
                categoryIcon.tintColor = AppColors.unselectedCategoryColor.color
            } else {
                categoryIcon.tintColor = AppColors.selectedCategoryColor.color
            }
        }
        for categoryText in categoriesLabels {
            if categoryText.tag == sender.tag {
                categoryText.textColor = AppColors.unselectedCategoryColor.color
            } else {
                categoryText.textColor = .white
            }
        }
        
        switch sender.tag {
        case 0:
            planets = Planet.fetchPlanets()
            setupFeaturedObjects(info: planets)
        case 1:
            planets = Planet.fetchStars()
            setupFeaturedObjects(info: planets)
        case 2:
            planets = Planet.fetchGalaxies()
            setupFeaturedObjects(info: planets)
        case 3:
            planets = Planet.fetchBlackHoles()
            setupFeaturedObjects(info: planets)
        default:
            break
        }
    }
    
    @IBAction func weatherSelectionButton(_ sender: UIButton) {
        if let weatherVC = navigator.instantiateViewController(withIdentifier: "SpaceWeatherViewController") as? SpaceWeatherViewController {
            navigationController?.pushViewController(weatherVC, animated: true)
        }
    }
    
    @IBAction func gravityCalcSelected(_ sender: UIButton) {
        if let gravityVC = navigator.instantiateViewController(withIdentifier: "GravitationalCalculatorViewController") as? GravitationalCalculatorViewController {
            navigationController?.pushViewController(gravityVC, animated: true)
        }
    }
    
    @IBAction func spaceTimeGotTapped(_ sender: UIButton) {
        if let spaceTimeVC = navigator.instantiateViewController(withIdentifier: "SpaceTimeListViewController") as? SpaceTimeListViewController {
            navigationController?.pushViewController(spaceTimeVC, animated: true)
        }
    }
    
    @IBAction func astronomicCalcGotTapped(_ sender: UIButton) {
        if let astronomicVC = navigator.instantiateViewController(withIdentifier: "AstronomicalCalculatorViewController") as? AstronomicalCalculatorViewController {
            navigationController?.pushViewController(astronomicVC, animated: true)
        }
    }
}
extension InitialScreenViewController {
    func setupFeaturedObjects(info: [Planet]) {
        for vw in stackToAddFeaturedObjects.arrangedSubviews {
            vw.removeFromSuperview()
        }
        
        for object in info {
            let bigView = UIView()
            let centerView = UIView()
            let backImage = UIImageView(image: UIImage(named: formatName(object.name)))
            backImage.contentMode = .scaleAspectFill
            let footerView = UIView()
            let bottomShadow = UIImageView(image: UIImage(resource: .bottomBlur))
            
            let labelsStack = UIStackView()
            labelsStack.axis = .vertical
            let nameLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont(name: "Inter-Bold", size: 16)
                label.text = object.name
                label.textColor = .white
                label.textAlignment = .left
                return label
            }()
            let descriptionLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont(name: "Inter-Regular", size: 14)
                label.text = object.subInfo
                label.textColor = AppColors.sublabelColor.color
                label.textAlignment = .left
                return label
            }()
            let button = UIButton(type: .system)
            
            stackToAddFeaturedObjects.addArrangedSubview(bigView)
            bigView.addSubview(centerView)
            centerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(centerView.snp.width).dividedBy(1.86)
            }
            centerView.clipsToBounds = true
            centerView.layer.masksToBounds = true
            centerView.layer.cornerRadius = 8.0
            centerView.addSubview(backImage)
            backImage.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            centerView.addSubview(footerView)
            footerView.snp.makeConstraints { make in
                make.bottom.leading.trailing.equalToSuperview()
                make.height.equalTo(footerView.snp.width).dividedBy(4.7)
            }
            footerView.addSubview(bottomShadow)
            bottomShadow.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            footerView.addSubview(labelsStack)
            labelsStack.addArrangedSubview(nameLabel)
            labelsStack.addArrangedSubview(descriptionLabel)
            
            labelsStack.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.centerY.equalToSuperview()
            }
            
            bigView.addSubview(button)
            button.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            button.addHapticAction { [self] in
                if let detailsVC = navigator.instantiateViewController(identifier: "DetailsScreenViewController") as? DetailsScreenViewController {
                    detailsVC.object = object
                    navigationController?.pushViewController(detailsVC, animated: true)
                }
            }
        }
    }
    
    func formatName(_ input: String) -> String {
        let words = input.components(separatedBy: " ").filter { !$0.isEmpty }
        
        if words.count == 1 {
            return words[0].lowercased()
        } else if words.count == 2 {
            let first = words[0].lowercased()
            let second = words[1].capitalized
            return first + second
        } else {
            return input
        }
    }
}

