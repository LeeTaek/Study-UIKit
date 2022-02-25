//
//  RotateButton.swift
//  CustomButton
//
//  Created by 이택성 on 2022/02/07.
//

import UIKit

enum RotateType {
    case up
    case down
}


class RotateButton: UIButton {
    
    init() {                // UIButton을 누를 때에 만드시 실행됨.
        super.init(frame: .zero)            // 상속받든 뭐든 init을 사용할 때에 super.init()을 반드시 호출해야 한다.
        configure()
    }
    
    required init?(coder: NSCoder) {        //  UIButton에 속해있는 init(). 상속받을 때에 이를 만족해야 한다. 이것은 xib에서 작업하고 클래스 연결할 때에 호출된다.
        super.init(coder: coder)
        configure()
     
    }
    
    var isUp = RotateType.down{
        didSet{             // isUp 값이 입력될 경우 didSet에 있는걸 호출.
            changeDesign()
        }
    }

    // 누렀을 때 뜨는 이벤트를 만들 때에 보통 클로저로 만듬
    var selectTypeCallback: ((RotateType) -> Void)? = { _ in }
    
    private func configure() {
        self.addTarget(self, action: #selector(seletButton), for: .touchUpInside)      // touchUpInside는 눌러서 놔뒀을 때의 상황
        
    }
    
    @objc private func seletButton() {
        if isUp == .up {
            isUp = .down
        } else {
            isUp = .up
        }
        
        selectTypeCallback?(isUp)
}
    
    
    private func changeDesign() {
        
        UIView.animate(withDuration: 0.25) {
            if self.isUp == .up {
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.backgroundColor =  self.backgroundColor?.withAlphaComponent(0.3)
            } else {
                self.imageView?.transform = .identity // identity는 원래 상태로 돌아가겠다는 값.
                self.backgroundColor =  self.backgroundColor?.withAlphaComponent(1)
            }
        
        }
        
    }
}


