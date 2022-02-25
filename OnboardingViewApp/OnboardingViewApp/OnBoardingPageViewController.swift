//
//  OnBoardingPageViewController.swift
//  OnboardingViewApp
//
//  Created by 이택성 on 2022/01/20.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    let startIndex = 0
    var currentIndex = 0 {
        didSet {                // 값을 받을 떄 마다 didset이 호출됨.
            pageControl.currentPage = currentIndex
        }
    }
    
    
    func makePagesLoad() {
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "첫번째"
        itemVC1.topImage = UIImage(named: "OnBoarding1")
        itemVC1.subText = "엄빠의 사랑으로! "
        
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.mainText = "두번째"
        itemVC2.topImage = UIImage(named: "OnBoarding2")
        itemVC2.subText = " 내가 태어났어! "
        
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "세번째"
        itemVC3.topImage = UIImage(named: "OnBoarding3")
        itemVC3.subText = " 그런데 내 삶을 멀리서 보니 희극인줄 알았는데 비극이었어! "
        
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)

        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        // 처음 시작할 때에 나올 페이지의 설정이 필요함
        self.dataSource = self
        self.delegate = self
    }

    func makePagecontrol() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black      // 점의 색깔
        pageControl.pageIndicatorTintColor = .lightGray     // 선택 안한 점의 색깔
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // pageControl.isUserInteractionEnabled = false  // 페이지 컨드를을 누르는걸 막음.
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
    }
    
    @objc func pageControlTapped(sender: UIPageControl){
       
        if sender.currentPage > self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        
        self.currentIndex = sender.currentPage
        
        buttonPresentationStyle()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makePagesLoad()
        self.makeBottomButton()
        self.makePagecontrol()
        
    }
    
    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        self.view.addSubview(button)         // 화면에 버튼을 올림
        button.translatesAutoresizingMaskIntoConstraints = false         // 오토레이아웃 하려면 얘 false로 해야함
        
        // 어디를 기준으로 버튼을 붙일거냐?, isactive는 이 기능을 활성화 시키는 것.
        // 이때 아이폰 X이상 기종은 밑에 safe area가 있기 때문에 safeAreaLayoutGuide에 있는 프로퍼티로 사용한다.
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        
        
        hideButton()
        
        //bottomButtonMargin?.constant = 100
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }

    
    
}


extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { // 이전 페이지는 뭐임?
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }               // currentIndex가 옵셔널이기 때문에 없으면 nil로 리턴
        
        self.currentIndex = currentIndex
        
        if currentIndex == 0 {          //  처음 장에서 뒤로 가면 마지막 페이지로.
            return pages.last
        } else {
            return pages[currentIndex - 1]}
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { // 다음 페이지는 뭐임?
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }               // currentIndex가 옵셔널이기 때문에 없으면 nil로 리턴
        self.currentIndex = currentIndex

        if currentIndex == pages.count - 1 {
            return pages.first
        }else {
        return pages[currentIndex + 1]
        }
    }
    
    
}


extension OnBoardingPageViewController: UIPageViewControllerDelegate {
     
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVc = pageViewController.viewControllers?.first else {
            return 
        }      // veiwControllers에 배열 형태로 딱 하나 들어있다.
    
        guard let currentIndex = pages.firstIndex(of: currentVc) else {
            return
        }
        
        self.currentIndex = currentIndex

        buttonPresentationStyle()


    }
    
    func buttonPresentationStyle() {
        if currentIndex == pages.count - 1 {
            self.showButton()
        } else {
            self.hideButton()
        }
        
        //        UIView.animate(withDuration: 0.5) {         // 애니메이션 추가, 포지션이라는 개념이 없다.
        //            self.view.layoutIfNeeded()
        //        }
                
         // 끝났을 때 포지션 조정도 가능하다.  laytouifneeded는 즉시 변경하겠다는 소리.
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {self.view.layoutIfNeeded()}, completion: nil)
        
    }
    
    func showButton() {
        bottomButtonMargin?.constant = 0

    }
    
    func hideButton() {
        bottomButtonMargin?.constant = 100

    }
    
}
