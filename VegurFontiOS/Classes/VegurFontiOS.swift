public extension UIFont {
    
    public class func vegurFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: VegurFonts.VegurRegular.rawValue, size: fontSize)!
    }
    
    public class func vegurLightFontWithSize(fontSize: CGFloat) -> UIFont {
        FontLoader.loadFontIfNeeded()
        return UIFont(name: VegurFonts.VegurLight.rawValue, size: fontSize)!
    }

    public class func vegurBoldWithSize(fontSize: CGFloat) -> UIFont {
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
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    static func loadFontIfNeeded() {
        if (UIFont.fontNamesForFamilyName(VegurFonts.FontFamilyName.rawValue).count == 0) {
            
            dispatch_once(&Static.onceToken) {
                let bundle = NSBundle(forClass: FontLoader.self)
                var fontURL = NSURL()
                let identifier = bundle.bundleIdentifier
                
                for vegurFont in VegurFonts.allValues {
                    if identifier?.hasPrefix("org.cocoapods") == true {
                        fontURL = bundle.URLForResource(vegurFont.rawValue, withExtension: "otf", subdirectory: "VegurFontiOS.bundle")!
                    } else {
                        fontURL = bundle.URLForResource(vegurFont.rawValue, withExtension: "otf")!
                    }
                    let data = NSData(contentsOfURL: fontURL)!
                    
                    let provider = CGDataProviderCreateWithCFData(data)
                    let font = CGFontCreateWithDataProvider(provider)!
                    
                    var error: Unmanaged<CFError>?
                    if !CTFontManagerRegisterGraphicsFont(font, &error) {
                        
                        let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
                        let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
                        NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
                    }
                    
                }
            }
        }
    }
}
