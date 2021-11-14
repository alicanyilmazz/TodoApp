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
    
    static let add : FloatingButtonViewModel = FloatingButtonViewModel(image: UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 32,weight: .medium)), tintColor: .white, setTitleColor: .white, backgroundColor: .systemPink, shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 30)
    
    static let settings : FloatingButtonViewModel = FloatingButtonViewModel(image: UIImage(systemName: "moon",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,weight: .medium)), tintColor: .white, setTitleColor: .white, backgroundColor: .systemPink, shadowRadius: 10, shadowOpacity: 0.3, cornerRadius: 22)
}

final class FloatingButton : UIButton{
    let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 32,weight: .medium))
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

//CGRect(x: view.frame.size.width - 60 - 18, y: view.frame.size.height - 70 - 8 - view.safeAreaInsets.bottom, width: 60, height: 60)
