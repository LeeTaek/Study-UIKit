//
//  DraggableView.swift
//  PanGesture_App
//
//  Created by 이택성 on 2022/01/20.
//

import Foundation
import UIKit

class DraggableView: UIView {
    
    var dragType = DragType.none
    
    init() {                            // UIKit을 사용할 때에 꼭 설정해야 하는 init있음.
        super.init(frame: CGRect.zero)                  // 오브젝트를 형성할 때에 부모의 frame과 관련된 init을 설정해줘야 함.
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
//        self.addGestureRecognizer(pan)
        
      fatalError("init(coder:) has not been implemented")       //   nib에서 작동할때 제한을 둠.
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {                  // 손을 움직일 때에 이 함수가 호출됨.
        switch pan.state {              // state는 누르는 순간
        case .began :
            print("began")
        
        case .changed :                     //  움직이는 순간
            let delta = pan.translation(in: self.superview)           // 부모 뷰를 기준으로 움직인 만큼의 값을 알려줌.
            
            var myPosition = self.center        // 절대좌표
            
            if dragType == .x{
                myPosition.x += delta.x

            } else if dragType == .y {
                myPosition.y += delta.y
            } else {
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            self.center = myPosition            // 나의 위치값은 새롭게 변경된 값으로 바뀌여야함.
            pan.setTranslation(CGPoint.zero, in: self.superview)        // 내가 움직인 만큼 뷰도 움직였으니, 다음번 움직이기 전에 기준값을 초기화시켜야함.
            
        case .ended, .cancelled :
            print("ended cancelled")
            if self.frame.minX < 0 {            // minX는 프레임의 왼쪽 끝, 포지션이 화면을 넘어가면
                self.frame.origin.x = 0         // origin은 프레임의 왼쪽 상단
            }
            
            if let hasSuperView = self.superview {      // 오른쪽은 좌표적인 계산이 필요.
                if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
            }
        default:
            break
        }
    }
}
