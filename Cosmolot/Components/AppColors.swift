
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(hex: Int) {
       self.init(
           red: (hex >> 16) & 0xFF,
           green: (hex >> 8) & 0xFF,
           blue: hex & 0xFF
       )
   }
}

enum AppColors: Int, CaseIterable {
    case placeholderColor = 0xADAEBC
    case selectedCategoryColor = 0x7A4CF6
    case unselectedCategoryColor = 0x251948
    case sublabelColor = 0xA9A7A8
    case unselectedDateCategory = 0x1D1137
    var color: UIColor {
        
        switch self {
        default:
            return UIColor.init(hex: rawValue)
        }
        
    }
}
