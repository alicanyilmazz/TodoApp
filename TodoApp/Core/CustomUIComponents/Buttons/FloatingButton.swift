import Foundation
import UIKit

struct FloatingButtonViewModel{
    let image : UIImage?
    let tintColor : UIColor?
    let setTitleColor : UIColor?
    let backgroundColor : UIColor?
    let shadowRadius : CGFloat
    let shadowOpacity : Float
    let cornerRadius : CGFloat
    
    static let add : FloatingButtonViewModel = FloatingButtonViewModel(image: UIImage(systemName: ImageName.plus.description,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32,weight: .medium)), tintColor: .white, setTitleColor: .white, backgroundColor: ColorPalette.darkpink, shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 30)
    
    static let settings : FloatingButtonViewModel = FloatingButtonViewModel(image: UIImage(systemName: ImageName.moon.description,withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,weight: .medium)), tintColor: .white, setTitleColor: .white, backgroundColor: ColorPalette.darkpink, shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 22)
}

struct CustomFloatingButtonViewModel{
    let image : UIImage?
    let setTitleColor : UIColor?
    let shadowRadius : CGFloat
    let shadowOpacity : Float
    let cornerRadius : CGFloat
    
    static let add : CustomFloatingButtonViewModel = CustomFloatingButtonViewModel(image: UIImage(systemName: ImageName.plus.description,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32,weight: .medium)), setTitleColor: .white, shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 30)
    
    static let settings : CustomFloatingButtonViewModel = CustomFloatingButtonViewModel(image: UIImage(systemName: ImageName.moon.description,withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,weight: .medium)), setTitleColor:.white,
        shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 22)
}

final class FloatingButton : UIButton{
    let image = UIImage(systemName: ImageName.plus.description,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32,weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        setImage(image, for: .normal)
        tintColor = UIColor.white
        setTitleColor(.white, for: .normal)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel : FloatingButtonViewModel){
        backgroundColor = viewModel.backgroundColor
        setImage(viewModel.image, for: .normal)
        tintColor = viewModel.tintColor
        setTitleColor(viewModel.setTitleColor, for: .normal)
        layer.shadowRadius = viewModel.shadowRadius
        layer.shadowOpacity = viewModel.shadowOpacity
        layer.cornerRadius = viewModel.cornerRadius
    }
    
    func customConfigure(with viewModel : CustomFloatingButtonViewModel){
        theme.backgroundColor = themed { $0.addButtonBackgroundColor }
        setImage(viewModel.image, for: .normal)
        theme.tintColor = themed { $0.addButtonTintColor }
        setTitleColor(viewModel.setTitleColor, for: .normal)
        layer.shadowRadius = viewModel.shadowRadius
        layer.shadowOpacity = viewModel.shadowOpacity
        layer.cornerRadius = viewModel.cornerRadius
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


func setLigthModeIcon(_ themeButton : FloatingButton){
        themeButton.setImage(UIImage(systemName: ImageName.moon.description), for: .normal)
    }
    
func setDarkModeIcon(_ themeButton : FloatingButton){
        themeButton.setImage(UIImage(systemName: ImageName.sun.description), for: .normal)
    }



