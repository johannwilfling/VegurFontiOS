import Foundation

public extension UIFont {
    
    public class func vegurFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: VegurFonts.VegurRegular.rawValue, size: fontSize)!
    }
    
    public class func vegurLightFontWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: VegurFonts.VegurLight.rawValue, size: fontSize)!
    }
    
    public class func vegurBoldWithSize(_ fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: VegurFonts.VegurBold.rawValue, size: fontSize)!
    }
    
}

private enum VegurFonts: String {
    
    case FontFamilyName = "Vegur"
    
    case VegurLight = "Vegur-Light"
    case VegurRegular = "Vegur-Regular"
    case VegurBold = "Vegur-Bold"
    
    static let allValues = [
        VegurLight, VegurRegular, VegurBold
    ]
}

private class FontLoader {
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNames(forFamilyName: VegurFonts.FontFamilyName.rawValue).count == 0) {
            let bundle = Bundle(for: FontLoader.self)
            var fontURL: URL!
            let identifier = bundle.bundleIdentifier
            
            for vegurFont in VegurFonts.allValues {
                if identifier?.hasPrefix("org.cocoapods") == true {
                    fontURL = bundle.url(forResource: vegurFont.rawValue, withExtension: "otf", subdirectory: "VegurFontiOS.bundle")
                } else {
                    fontURL = bundle.url(forResource: vegurFont.rawValue, withExtension: "otf")
                }
                let data = try! Data(contentsOf: fontURL as URL)
                let provider = CGDataProvider(data: data as CFData)
                let font = CGFont(provider!)
                
                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    
                    let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                    let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                    NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                }
            }
        }
    }

}
