//
//  ScoutsDetailViewController.swift
//  Scouts
//
//  Created by Jonathon Derr on 4/6/17.
//  Copyright © 2017 Jonathon Derr. All rights reserved.
//

import UIKit
import CoreGraphics


class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    
    
    @IBOutlet weak var infoBack: UIScrollView!
    @IBOutlet weak var info: UIScrollView!
    @IBOutlet weak var coverPhoto: UIScrollView!
    @IBOutlet weak var coverPhotoBlur: UIVisualEffectView!
    
    @IBOutlet weak var coverPhotoImage: UIImageView!
    @IBOutlet weak var profilePhoto: UIScrollView!
    @IBOutlet weak var profilePhotoMask: UIView!
    
    @IBOutlet weak var titleMask: UIView!
    @IBOutlet weak var titleScroller: UIScrollView!
    
    @IBOutlet weak var mainScroller: UIScrollView!
    @IBOutlet weak var infoMask: UIView!
    @IBOutlet weak var infoContainerView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var gradientBack: UIView!
    
    var direction: CGFloat = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let maskLayer = CAShapeLayer()
        let cornerRadius: CGFloat = 15
        
        let maskRect = CGRect(x: 0, y: 83, width: view.frame.width, height: 1000)
        let path = UIBezierPath(roundedRect: maskRect, cornerRadius: 15)
        
        
        
        
        
        
        //path is set as the _shapeLayer object's path
        maskLayer.path = path.cgPath
        infoMask.layer.mask = maskLayer
        
        infoView.layer.cornerRadius = 15
        infoView.layer.masksToBounds = true
        infoView.layer.shadowColor  = UIColor.black.cgColor
        
        infoContainerView.layer.cornerRadius = 15
        infoContainerView.layer.masksToBounds = true
        
        
        let titleMaskLayer = CAShapeLayer()
        let titleMaskRect = CGRect(x: 0, y: 0, width: info.frame.width, height: 83)
        let titlePath = CGPath(rect: titleMaskRect, transform: nil)
        titleMaskLayer.path = titlePath
        titleMask.layer.mask = titleMaskLayer
        
        
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientBack.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientBack.layer.insertSublayer(gradient, at: 0)
        
        
        mainScroller.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let mainScrollerHeight = mainScroller.contentSize.height - mainScroller.bounds.height
        let percentageScroll = mainScroller.contentOffset.y / mainScrollerHeight
        
        let profilePhotoHeight = profilePhoto.contentSize.height - profilePhoto.bounds.height
        let titleScroll = titleScroller.contentSize.height - titleScroller.bounds.height
        let coverPhotoHeight = coverPhoto.contentSize.height - coverPhoto.bounds.height
        let infoHeight = info.contentSize.height - info.bounds.height
        let infoBackHeight = infoBack.contentSize.height - info.bounds.height
        
        if percentageScroll > -0.424433249370277{
            
            info.contentOffset = CGPoint(x: 0, y: infoHeight * percentageScroll )
            profilePhoto.contentOffset = CGPoint(x: 0, y: profilePhotoHeight * percentageScroll)
            
            gradientBack.frame = coverPhotoImage.frame
            
            if mainScroller.contentOffset.y < 66.5{
                infoBack.contentOffset = CGPoint(x: 0, y: infoBackHeight * percentageScroll)
            }else{
                infoBack.contentOffset = CGPoint(x: 0, y: 66.5)
            }
            
            
            let offsetY = mainScroller.contentOffset.y
            
            if offsetY < 0 {
                coverPhotoImage.frame.size.height = -offsetY + 192
                
            }else{
                coverPhotoImage.frame.size.height = coverPhotoImage.frame.height
            }
            
            
            if infoBack.contentOffset.y < 65.5 && infoBack.contentOffset.y > 0.0
            {
                self.imageView.frame = CGRect(x: (view.frame.size.width/2) - ((imageView.frame.width)/2),y: (infoBack.contentOffset.y/1.5 + 105),width: 131 - (infoBack.contentOffset.y/2), height: 131 - (infoBack.contentOffset.y/2))
                
                self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2
                self.imageView.clipsToBounds = true
                
            }
            
            if infoBack.contentOffset.y > 65.5 {
                let maskLayer = CAShapeLayer()
                let maskRect = CGRect(x: 0, y: 84, width: profilePhotoMask.frame.width, height: 1000)
                let path = CGPath(rect: maskRect, transform: nil)
                maskLayer.path = path
                profilePhotoMask.layer.mask = maskLayer
            }
            
            if infoBack.contentOffset.y <= 0.0{
                self.imageView.frame = CGRect(x: view.frame.size.width/2 - 65.5,y: 105,width: 131, height: 131)
                
                self.imageView.layer.cornerRadius = self.imageView.frame.size.width/2
                self.imageView.clipsToBounds = true
                
            }
            
            
            if infoBack.contentOffset.y == 66.5 {
                self.imageView.frame = CGRect(x: view.frame.size.width/2 - 49.25, y: 148.33, width: 98.5, height: 98.5)
            }
            
            if mainScroller.contentOffset.y > 100 && mainScroller.contentOffset.y < 154{
                coverPhotoBlur.alpha = ((mainScroller.contentOffset.y - 100) / 54)
            }
            
            if mainScroller.contentOffset.y > 154{
                coverPhotoBlur.alpha = 1
            }
            
            if mainScroller.contentOffset.y < 100 && mainScroller.contentOffset.y > 0 {
                coverPhotoBlur.alpha = 0
            }
            
            if mainScroller.contentOffset.y < 198 {
                titleScroller.contentOffset = CGPoint(x: 0,y: titleScroll * percentageScroll)
                
            }
            
            if mainScroller.contentOffset.y > 196.5 {
                titleScroller.contentOffset = CGPoint(x: 0,y:  196.5)
            }
            
            if mainScroller.contentOffset.y < 0 && mainScroller.contentOffset.y > -100{
                coverPhotoBlur.alpha = (mainScroller.contentOffset.y / -100)
            }
            
            
            if mainScroller.contentOffset.y < -100 {
                coverPhotoBlur.alpha = 1
            }
            
            
        }
        
        
    }
}
