//
//  ViewController.swift
//  Pop_Demo
//
//  Created by Sam Lee on 2015/3/22.
//  Copyright (c) 2015年 Sam Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var squareView : UIView!;
    @IBOutlet var scaleBtn : UIButton!;
    @IBAction func btnScaleView(sender: UIButton){
        self.scaleView(self.squareView);
        self.scaleView(self.scaleBtn);
        self.spinView(self.squareView, type: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createSquare();
        
        // set Button background color
        self.scaleBtn.backgroundColor = UIColor.purpleColor();
    }
    
    func createSquare(){
        self.squareView = UIView(frame: CGRectMake(0, 0, 100, 100));
        self.squareView.backgroundColor = UIColor.blueColor();
        self.squareView.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2);
    
        self.squareView.userInteractionEnabled = true;
        self.view.addSubview(self.squareView);
    }
    
    
    func moveView(view: UIView, velocity: CGPoint){
        let animate = POPDecayAnimation(propertyNamed: kPOPLayerPosition);
        animate.velocity = NSValue(CGRect: CGRectMake(velocity.x, velocity.y, 0, 0));
        view.pop_addAnimation(animate, forKey: "move");
    }
    
    func moveViewNormal(view: UIView, position: CGPoint){
        let animate = POPBasicAnimation(propertyNamed: kPOPLayerPosition);
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear);
        animate.toValue = NSValue(CGRect: CGRectMake(position.x, position.y, 0, 0));
        view.pop_addAnimation(animate, forKey: "move_normal");
    }
    
    
    func scaleView(view: UIView){
        let animate = POPSpringAnimation(propertyNamed: kPOPLayerSize);
        animate.springBounciness = 4.0
        animate.springSpeed = 3.0
        
        if view.frame.size.width < 300 {
            animate.toValue = NSValue(CGSize:CGSizeMake(300, 300));
        }else{
            animate.toValue = NSValue(CGSize:CGSizeMake(100, 100));
        }

        animate.dynamicsFriction = 20;
        
        view.pop_addAnimation(animate, forKey: "bound");
    }
    
    func spinView(view: UIView, type: Bool){
        let animate = POPSpringAnimation(propertyNamed: kPOPLayerRotation);
        animate.springBounciness = 8;
        animate.springSpeed = 5;
        if(type == false){
            animate.fromValue = 0.0;
            animate.toValue = CGFloat(M_PI);
        }else{
            animate.fromValue = CGFloat(M_PI);
            animate.toValue = 0.0;
        }
        view.layer.pop_addAnimation(animate, forKey: "spin");
    }
    
    @IBAction func panGesture(recognizer: UIPanGestureRecognizer) {
        
        var point: CGPoint = recognizer.locationInView(self.view);
        var velocity: CGPoint = recognizer.velocityInView(self.view);
        var center: CGPoint = CGPointZero;
        
        var state : UIGestureRecognizerState = recognizer.state;
        if (state == UIGestureRecognizerState.Began || state == UIGestureRecognizerState.Changed){
            println("detected changed");
            println(point);
            println(velocity);
            self.moveView(self.squareView, velocity: velocity);
            self.spinView(self.squareView, type: true);
//            self.moveViewNormal(self.squareView, position: point);
        }
    }
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBAction func ChangeText(sender: UITextField) {
        if(sender.text == "good" || sender.text == "ok"){
            self.spinView(self.likeImg, type: true);
            self.scaleView(self.likeImg);
        }else{
            self.spinView(self.likeImg, type: false);
        }
    }
}

