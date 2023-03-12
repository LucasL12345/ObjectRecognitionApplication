import UIKit

class FontManager {
    
    static let shared = FontManager()
    
    var currentFontSizeIndex = 0
    let fontSizes = [UIFont.systemFontSize+7, UIFont.systemFontSize + 10, UIFont.systemFontSize + 15]
    
    private init() {
        // Retrieve font size index from user defaults
        if let index = UserDefaults.standard.object(forKey: "currentFontSizeIndex") as? Int {
            currentFontSizeIndex = index
        }
    }
    
    func increaseFontSize() -> CGFloat {
        currentFontSizeIndex = (currentFontSizeIndex + 1) % fontSizes.count
        // Save font size index in user defaults
        UserDefaults.standard.set(currentFontSizeIndex, forKey: "currentFontSizeIndex")
        return fontSizes[currentFontSizeIndex]
    }
    
    func getFontSize() -> CGFloat {
        return fontSizes[currentFontSizeIndex]
    }
}
