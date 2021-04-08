//
//  GuidePageViewController.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/18.
//

import UIKit

class GuidePageViewController: BaseViewController {
    var contentScrollView:UIScrollView?
    var startButton:UIButton?
    var pageControl:UIPageControl! // 全部使用图片会变形 所以自己写
    let imagesArray = ["guidePage1", "guidePage2"]
    let titleArray = ["了解最新签约进展", "掌握人群签约排行情况"]
    let subtitleArray = ["口袋里的数据管家", "口袋里的数据管家"]
    let pageControlHeigth = 66 + 12 + SizeHelper.homeIndicatorHeight

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
}

extension GuidePageViewController {
    func setupUI()  {
        
        pageControl = UIPageControl.init()
        pageControl?.currentPage = 0
        pageControl?.numberOfPages = imagesArray.count
        pageControl?.pageIndicatorTintColor = UIColor.colorWith(hex: "#F0F3F2")
        pageControl?.currentPageIndicatorTintColor = UIColor.defaultMainColor

        view.addSubview(pageControl!)
        view.bringSubviewToFront(pageControl!)
        pageControl?.snp.makeConstraints({ (make) in
            make.left.width.bottom.equalToSuperview()
            make.height.equalTo(pageControlHeigth)
        })
        
        contentScrollView  = UIScrollView.init(frame: self.view.bounds)
        contentScrollView?.bounces = false
        contentScrollView?.showsHorizontalScrollIndicator = false
        contentScrollView?.delegate = self
        contentScrollView?.isPagingEnabled = true
        contentScrollView?.contentSize = CGSize.init(width: SizeHelper.screenWidth * CGFloat(imagesArray.count), height: SizeHelper.screenHeight)
        view.addSubview(contentScrollView!)
        
        for (index,imageName) in imagesArray.enumerated() {
            let contentView = UIView.init()
            contentScrollView?.addSubview(contentView)
            contentView.frame = CGRect.init(x: CGFloat(SizeHelper.screenWidth * CGFloat(index)), y: 0, width: SizeHelper.screenWidth, height: SizeHelper.screenHeight)
            
            let subtitleLabel = UILabel.init(fontSize: 16, colorHex: "#999999", text: subtitleArray[index])
            contentView.addSubview(subtitleLabel)
            subtitleLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(-(SizeHelper.autoHeight(100) + CGFloat(pageControlHeigth)))
                make.centerX.equalToSuperview()
            }
            
            let titleLabel = UILabel.init(fontSize: 16, colorHex: "#333333", text: titleArray[index])
            titleLabel.font = UIFont.semibold(24)
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(subtitleLabel.snp.top).offset(-SizeHelper.autoHeight(12))
                make.centerX.equalToSuperview()
            }
           
            
            let imageView = UIImageView.init(image:UIImage.init(named: imageName))
            imageView.contentMode = .scaleAspectFill
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(titleLabel.snp.top).offset(-SizeHelper.autoHeight(80))
                make.centerX.equalToSuperview()
            })
            
            if index == (imagesArray.count - 1) {
                startButton = UIButton.init(fontSize: 16, colorHex: "#FFFFFF", text: "开始使用")
                startButton?.backgroundColor = UIColor.defaultMainColor
                startButton?.addConner()
                startButton?.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
                contentView.addSubview(startButton!)
                imageView.isUserInteractionEnabled = true
                startButton?.snp.makeConstraints({ (make) in
                    make.top.equalTo(subtitleLabel.snp.bottom).offset(SizeHelper.autoHeight((100 - 40) / 2))
                    make.width.equalTo(125)
                    make.height.equalTo(40)
                    make.centerX.equalToSuperview()
                })
            }
        }
    }
    
   @objc  func startButtonClicked()  {
      
    GuidePageHelper.loadingGuidePageVCFinished()
    LoginViewModel.pushLoginVC()
      self.removeFromParent()
    }
}

extension GuidePageViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        pageControl?.currentPage = lround(Double(x / SizeHelper.screenWidth))
    }
}
