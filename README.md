<h1 align="center">iOS Animations</h1>

## 1. LoginAnimations - Translate Animation

To place the form elements outside the visible bounds of the screen add the following code to *viewWillAppear()*:

```swift
heading.center.x  -= view.bounds.width
username.center.x -= view.bounds.width
password.center.x -= view.bounds.width
```
To animate the form elements back to their original position add the following code to *viewDidAppear()*:

```swift
UIView.animate(withDuration: 0.5) {
    self.headingLabel.center.x += self.view.bounds.width
}

UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
    self.usernameTextField.center.x += self.view.bounds.width
}, completion: nil)

UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
    self.passwordTextField.center.x += self.view.bounds.width
}, completion: nil)
```

<p align="center">
    <a href="https://media.giphy.com/media/1xoYW0CSv2U2ddclAH/giphy">
        <img src="https://media.giphy.com/media/1xoYW0CSv2U2ddclAH/giphy.gif">
	</a>
</p>

## 2. LoginAnimations - Fade in the clouds

To animate the clouds,  you initially need to set alpha to 0 in *viewWillAppear()*:

```swift
cloud1ImageView.alpha = 0.0
cloud2ImageView.alpha = 0.0
cloud3ImageView.alpha = 0.0
cloud4ImageView.alpha = 0.0
```
And to call the *UIView.animate(withDuration:delay:options:animations:completion:)* method with proper parameters in *viewDidAppear()*:

```swift
UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
    self.cloud1ImageView.alpha = 1.0
}, completion: nil)

UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
    self.cloud2ImageView.alpha = 1.0
}, completion: nil)

UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
    self.cloud3ImageView.alpha = 1.0
}, completion: nil)

UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
    self.cloud4ImageView.alpha = 1.0
}, completion: nil)
```

<p align="center">
    <a href="https://media.giphy.com/media/ZNn8Kfjpl8vDA908K4/giphy">
        <img src="https://media.giphy.com/media/ZNn8Kfjpl8vDA908K4/giphy.gif">
    </a>
</p>

## 3. LoginAnimations - Login Button Spring Animation

To animate the login button, you initially need to set alpha to 0 in *viewWillAppear()*:

```swift
loginButton.center.y += 30.0
loginButton.alpha = 0.0
```
Call the *UIView.animate(withDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)* method with proper parameters in *viewDidAppear()*:

```swift
UIView.animate(withDuration: 0.5, 
               delay: 0.5, 
               usingSpringWithDamping: 0.5, 
               initialSpringVelocity: 0.0, 
               options: [], 
               animations: {
	self.loginButton.center.y -= 30.0
	self.loginButton.alpha = 1.0
}, completion: nil)
```

<p align="center">
    <a href="https://media.giphy.com/media/OQIA8g3Ev3jbP8PsWs/giphy">
        <img src="https://media.giphy.com/media/OQIA8g3Ev3jbP8PsWs/giphy.gif">
    </a>
</p>

## 4. LoginAnimations - Touch Up Inside Animation

To animate the login button when it is tapped add this code to its action method:

```swift
@IBAction func login(_ sender: UIButton) {
    UIView.animate(withDuration: 1.5,
                   delay: 0.0, 
                   usingSpringWithDamping: 0.2, 
                   initialSpringVelocity: 0.0, 
                   options: [], 
                   animations: {
        self.loginButton.bounds.size.width += 80.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.33, 
                   delay: 0.0, 
                   usingSpringWithDamping: 0.7, 
                   initialSpringVelocity: 0.0, 
                   options: [], 
                   animations: {
        self.loginButton.center.y += 60.0
        self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    }, completion: nil)
}
```

First animation increase the button's width by 80 points over a duration of 1.5 seconds. The second animation moves the button 60 points down and the duration is shorter because the desired effect is to make the button jump away from the tap point and bounce a bit once it's settled into its new vertical position.

<p align="center">
    <a href="https://media.giphy.com/media/6EnMtfWMBtI1bWdQ0y/giphy">
        <img src="https://media.giphy.com/media/6EnMtfWMBtI1bWdQ0y/giphy.gif">
    </a>
</p>

## 5. LoginAnimations - Status Message Transition

In order to show the status banner animation we need to set *isHidden* to true in *viewDidLoad* and call *transition(with:duration:options:animations:completion:)* and set *isHidden* to false within the animations block and for options select *.transitionCurlDown* to animate the view like a sheet of paper being flipped down.

```swift
 override func viewDidLoad() {
        ...
        statusImageView.isHidden = true
        ...
}
```

```swift
func showMessage(index: Int) {
    statusLabel.text = statusMessages[index]

    UIView.transition(with: statusImageView, 
                      duration: 0.33, 
                      options: [.curveEaseOut, .transitionCurlDown], 
                      animations: {
        self.statusImageView.isHidden = false
    }) { _ in
        // transition completion
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/elRfGR3knOc6qU9a1Q/giphy">
        <img src="https://media.giphy.com/media/elRfGR3knOc6qU9a1Q/giphy.gif">
    </a>
</p>

## 6. LoginAnimations Status Mixing Transitions

For removing the status message from the screen create a method called *removeMessage(index:)* and create an animation to move the status outside of the visible area of the screen.

```swift
func removeMessage(index: Int) {
    UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
        self.statusImageView.center.x += self.view.frame.size.width
    }) { _ in
        self.statusImageView.isHidden = true
        self.statusImageView.center = self.statusImageViewPosition

        self.showMessage(index: index + 1)
    }
}
```

When the animation is completed, we need to move the status back to its original position and hide it. Then, the next message is shown. The *removeMessage(index:)* is called from the completion block of the transition in *showMessage(index:)* with a delay of 1.5 seconds.

```swift
func showMessage(index: Int) {
    statusLabel.text = statusMessages[index]

    UIView.transition(with: statusImageView, 
                      duration: 0.33, 
                      options: [.curveEaseOut, .transitionCurlDown], 
                      animations: {
        self.statusImageView.isHidden = false
    }) { _ in
        delay(seconds: 1.5) {
            if index < self.statusMessages.count - 1 {
                self.removeMessage(index: index)
            } else {
                // reset form
            }
        }
    }
}
```    

<p align="center">
    <a href="https://media.giphy.com/media/8vsZJSEx6HywXGJRAA/giphy">
       <img src="https://media.giphy.com/media/8vsZJSEx6HywXGJRAA/giphy.gif">
    </a>
</p>

## 7. LoginAnimations - Reversed Login Animations 

To reset the form to its initial state, we call *transition(with:duration:options: animations:completion:)* to set the visibility of the status to hidden and center the banner to its initial state. Next, call *animate(withDuration:delay:options: animations:completion:)* to undo all changes made to the Log In button.

```swift
func resetForm() {
    UIView.transition(with: statusImageView, duration: 0.2, options: [.transitionFlipFromTop], animations: {
        self.statusImageView.isHidden = true
        self.statusImageView.center = self.statusImageViewPosition
    }, completion: nil)

    UIView.animate(withDuration: 0.33, delay: 0, options: [], animations: {
        self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
        self.loginButton.bounds.size.width -= 80.0
        self.loginButton.center.y -= 60.0
    }, completion: nil)
}
```
     
<p align="center">
    <a href="https://media.giphy.com/media/ZcWxjzl9CJaI1dRwqv/giphy">
        <img src="https://media.giphy.com/media/ZcWxjzl9CJaI1dRwqv/giphy.gif">
    </a>
</p>

## 8. LoginAnimations - Animate clouds

In order to animate the clouds, we need to choose the speed (in this case, the clouds should cross the entire length of the screen in 30 seconds) and in the animations block we move the cloud to the right. In the completion block the cloud is moved outside the opposite edge of the screen from its current position. Finally, *animateCloud(cloud:)* is called in *viewDidAppear()* for every cloud.

```swift
func animateCloud(cloud: UIImageView) {
    let cloudSpeed = 30.0 / view.frame.size.width
    let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed

    UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
        cloud.frame.origin.x = self.view.frame.size.width
    }) { _ in
        cloud.frame.origin.x = -cloud.frame.size.width
        self.animateCloud(cloud: cloud)
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/4560lyPoPuHEYarf54/giphy">
       <img src="https://media.giphy.com/media/4560lyPoPuHEYarf54/giphy.gif">
    </a>
</p>

## 9. FlightAnimations - Crossfading Animation

To create the crossfading effect we need to create a method *fade(imageView:toImage:showEffects)*, where:
1. imageView: Image view to fade out
2. toImage: The new image we want to be visible at the end of the animation
3. showEffects: Boolean flag indicating whether the scene should show or hide the snowfall effect

```swift
func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
	UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
		imageView.image = toImage
	}, completion: nil)

	UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
		self.snowView.alpha = showEffects ? 1.0 : 0.0
	}, completion: nil)
}
```

The *fade(imageView:toImage:showEffects)* method is triggered from *changeFlight(to:)*.

```swift
func changeFlight(to data: FlightData, animated: Bool = false) {
    if animated {
        fade(imageView: backgroundImageView, 
             toImage: UIImage(named: data.weatherImageName)!, 
             showEffects: data.showWeatherEffects)
    } else {
        backgroundImageView.image = UIImage(named: data.weatherImageName)
        snowView.isHidden = !data.showWeatherEffects
    }

    delay(seconds: 3.0) {
        self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/LTpsfcKILxwjArb0l8/giphy">
        <img src="https://media.giphy.com/media/LTpsfcKILxwjArb0l8/giphy.gif">
    </a>
</p>

## 10. FlightAnimations - Cube Transition

This effect makes the flight and gate information be on adjacent sides of a cube that rotates around its center to reveal the next value. For this, create a method called *cubeTransition(label:text:direction:)*, where:
1. label: The label we want to animate
2. text: The new text to display on the label
3. direction: The location from where to animate the new label (top or bottom)

```swift
func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
    // Create an auxiliary label and copy properties
    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = label.backgroundColor

    // Adjust the auxLabel.transform to create a faux-perspective effect
    let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
    auxLabel.transform = 
        CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(
        CGAffineTransform(translationX: 0.0, y: auxLabelOffset))

    label.superview?.addSubview(auxLabel)

    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
        auxLabel.transform = .identity
        label.transform = 
            CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(
            CGAffineTransform(translationX: 0.0, y: -auxLabelOffset))
    }) { _ in
        label.text = auxLabel.text
        label.transform = .identity

        auxLabel.removeFromSuperview()
    }
}
```

In the animations block we reset the transform of *auxLabel* making the new text to grow in height, on top of the exact position of the old one. Afterwards, we apply a transform to scale it down and move the old one in the opposite direction to where the new text appears. Now, we just need to call the method in *changeFlight(to:)*.

```swift
func changeFlight(to data: FlightData, animated: Bool = false) {
    if animated {
        fade(imageView: backgroundImageView, 
             toImage: UIImage(named: data.weatherImageName)!, 
             showEffects: data.showWeatherEffects)

        let direction: AnimationDirection = data.isTakingOff ? .positive : .negative
        cubeTransition(label: flightNumberLabel, text: data.flightNumber, direction: direction)
        cubeTransition(label: gateNumberLabel, text: data.gateNumber, direction: direction)

    } else {
        backgroundImageView.image = UIImage(named: data.weatherImageName)
        snowView.isHidden = !data.showWeatherEffects

        flightNumberLabel.text = data.flightNumber
        gateNumberLabel.text = data.gateNumber

        departingFromLabel.text = data.departingFrom
        arrivingToLabel.text = data.arrivingTo

        flightStatusLabel.text = data.flightStatus
    }

    delay(seconds: 3.0) {
        self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/2zcnNS9kkXuD8xf7WC/giphy">
        <img src="https://media.giphy.com/media/2zcnNS9kkXuD8xf7WC/giphy.gif">
    </a>
</p>

## 11. FlightAnimations - Fade and Bounce Animation

To make the *departingFromLabel* and *arrivingToLabel* bounce and fade we need to create a method called *moveLabel(label:text:offset)*, where:
1. label: The label we want to animate
2. text: The new text we want display
3. offset: The arbitrary offset we'll use to animate the auxiliary label

```swift
func moveLabel(label:UILabel, text: String, offset: CGPoint) {
    // Create an auxiliary label and copy properties
    let auxLabel = UILabel(frame: label.frame)
    auxLabel.text = text
    auxLabel.font = label.font
    auxLabel.textAlignment = label.textAlignment
    auxLabel.textColor = label.textColor
    auxLabel.backgroundColor = .clear

    // Set transform and hide
    auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
    auxLabel.alpha = 0
    view.addSubview(auxLabel)

    // Move the label away from its original position and fade it out
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
        label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        label.alpha = 0.0
    }, completion: nil)

    // Reset auxiliary label transform (move to original position) and fade the text
    UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
        auxLabel.transform = .identity
        auxLabel.alpha = 1.0
    }) { _ in
        // Clean Up
        auxLabel.removeFromSuperview()
        label.text = text
        label.alpha = 1.0
        label.transform = .identity
    }
}
```

The *moveLabel(label:text:offset)* method is called in *changeFlight(to:animated:)* with an arbitrary offset as a parameter, for the departure label, we create a horizontal movement; for the arrival label, we create a vertical movement:

```swift
 func changeFlight(to data: FlightData, animated: Bool = false) {
    if animated {
        ...
        let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue) * 80.0, y: 0.0)
        let offsetArriving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue) * 50.0)
            
        moveLabel(label: departingFromLabel, text: data.departingFrom, offset: offsetDeparting)
        moveLabel(label: arrivingToLabel, text: data.arrivingTo, offset: offsetArriving)
    } else {
        ...
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/9UZZHvFXsRBbftQbNz/giphy">
        <img src="https://media.giphy.com/media/9UZZHvFXsRBbftQbNz/giphy.gif">
    </a>
</p>

## 12. FlightAnimations - Keyframe Animation

To create keyframe animations we need to use *animateKeyframes(withDuration:delay:options:animations:completion:)*, then we need to call *addKeyframe(withRelativeStartTime:relativeDuration:animations:)* to add keyframes. In every animations block from frames are set the properties we want on *planeImageView*. 

```swift
func planeDepart() {
    let originalCenter = planeImageView.center

    UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: .beginFromCurrentState, animations: {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
            self.planeImageView.center.x += 80.0
            self.planeImageView.center.y -= 10.0
        })

        UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
            self.planeImageView.transform = CGAffineTransform(rotationAngle: -.pi / 8)
        })

        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
            self.planeImageView.center.x += 100.0
            self.planeImageView.center.y -= 50.0
            self.planeImageView.alpha = 0.0
        })

        UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: {
            self.planeImageView.transform = .identity
            self.planeImageView.center = CGPoint(x: 0.0, y: originalCenter.y)
        })

        UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
            self.planeImageView.alpha = 1.0
            self.planeImageView.center = originalCenter
        })
    }, completion: nil)
}
```

This method is called when we want to change flight in an animated way.

```swift
func changeFlight(to data: FlightData, animated: Bool = false) {
    if animated {
        planeDepart()
        ...
    } else {
        ...
    }
    ...
}
```

<p align="center">
    <a href="https://media.giphy.com/media/8UH02jBDwZGGKioJa3/giphy">
        <img src="https://media.giphy.com/media/8UH02jBDwZGGKioJa3/giphy.gif">
    </a>
</p>

## 13. PackingListAnimations - Auto Layout Animations

In order to use a constraint in an animation we need to create an outlet using drag'n'drop from Interface Builder.

```swift
@IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
```

When the toggle menu button is pressed the animations on title constraint and menu height constraint are started. First, the toogle *isMenuOpen* is switched to capture the current state, then search constraints on title and update them based on the menu state. Further, the menu height constraint constant is updated.

```swift
 @IBAction func actionToggleMenu(_ sender: AnyObject) {
    isMenuOpen = !isMenuOpen

    // Search constraints on title at runtime and change them based on menu state
    titleLabel.superview?.constraints.forEach({ constraint in
        if constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX {
            constraint.constant = isMenuOpen ? -100.0 : 0.0
            return
        }

        if constraint.identifier == "TitleCenterY" {
            constraint.isActive = false

            let newContraint = NSLayoutConstraint(item: titleLabel, 
                                                  attribute: .centerY, 
                                                  relatedBy: .equal, 
                                                  toItem: titleLabel.superview, 
                                                  attribute: .centerY, 
                                                  multiplier: isMenuOpen ? 0.67 : 1.0, 
                                                  constant: 5.0)
            newContraint.identifier = "TitleCenterY"
            newContraint.isActive = true
        }
    })

    // Change menu height constraint constant based on menu state
    menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
    titleLabel.text = isMenuOpen ? "Select Item" : "Packing List"

    // Rotate menuButton with 45 degrees and update layout
    UIView.animate( withDuration: 1.0,
                    delay: 0.0,
                    usingSpringWithDamping: 0.4, 
                    initialSpringVelocity: 10.0, 
                    options: .curveEaseIn, 
                    animations: {
        self.view.layoutIfNeeded()

        let angle: CGFloat = self.isMenuOpen ? .pi / 4 : 0.0
        self.menuButton.transform = CGAffineTransform(rotationAngle: angle)
    }, completion: nil)

    if isMenuOpen {
        slider  = HorizontalItemList(inView: view)
        slider.didSelectItem = { index in
            self.items.append(index)
            self.tableView.reloadData()
            self.actionToggleMenu(self)
        }
        self.titleLabel.superview?.addSubview(slider)
    } else {
        slider.removeFromSuperview()
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/1APahzssU3U7ORcsrT/giphy">
        <img src="https://media.giphy.com/media/1APahzssU3U7ORcsrT/giphy.gif">
    </a>
</p>

## 12. LoginAnimations - Animation Keys and Delegates

In this section, I will use *CAAnimationDelegate* methods which permit to receive delegate callbacks for when an animation begins and ends.

```swift
func animationDidStart(_ anim: CAAnimation)
func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
```

In order to implement these methods we need to set the delegate variable from every *CABasicAnimation* to *self* before being added to a layer. To identify every animation we need to a name using the *setValue* method. Below is the implementation of the animation *flyLeft* that is used to make the info label to change its horizontal position in 5 seconds. :arrow_down:

```swift
let flyLeft = CABasicAnimation(keyPath: "position.x")
flyLeft.fromValue = info.layer.position.x + view.frame.size.width
flyLeft.toValue = info.layer.position.x
flyLeft.duration = 5.0
info.layer.add(flyLeft, forKey: "infoappear")
```

When the info label finished its animation in the *animationDidStop(anim:finished)* we detect what animation triggered the method and in the case of animations with name "form" we create an animation that bumps the scale of the layer by a factor of 1.25, then animate the layer back to its original size to give user feedback that the current animation is finished.

```swift
func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    // Filter the animation with key "name"
    guard let name = anim.value(forKey: "name") as? String else { return }

    if name == "form" {
        let layer = anim.value(forKey: "layer") as? CALayer
        anim.setValue(nil, forKey: "layer")

        // Send user feedback using an animation
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1.25
        pulse.toValue = 1.0
        pulse.duration = 0.25
        layer?.add(pulse, forKey: nil)
    } else if name == "cloud" {
        guard let layer = anim.value(forKey: "layer") as? CALayer else { return }
        layer.position.x = -layer.bounds.width / 2

        delay(seconds: 0.2) {
            self.animateCloud(layer: layer)
        }
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/1Aj195yGlitJF0QKwj/giphy">
        <img src="https://media.giphy.com/media/1Aj195yGlitJF0QKwj/giphy.gif">
    </a>
</p>

## 13. LoginAnimations - Group and Advanced Timing

To add multiple, independent animations to a single layer we can use the *CAAanimationGroup* class. 

```swift
// groupAnimation is created and the values for properties are set
let groupAnimation = CAAnimationGroup()
groupAnimation.beginTime = CACurrentMediaTime() + 0.5
groupAnimation.duration = 0.5
groupAnimation.fillMode = kCAFillModeBackwards
groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

// scaleDown animation is created
let scaleDown = CABasicAnimation(keyPath: "transform.scale")
scaleDown.fromValue = 3.5
scaleDown.toValue = 1.0

// rotate animation is created
let rotate = CABasicAnimation(keyPath: "transform.rotation")
rotate.fromValue = .pi / 4.0
rotate.toValue = 0.0

// fade animation is created
let fade = CABasicAnimation(keyPath: "opacity")
fade.fromValue = 0.0
fade.toValue = 1.0

// all animations are added to group
groupAnimation.animations = [scaleDown, rotate, fade]

// groupAnimation is added to login button's layer
loginButton.layer.add(groupAnimation, forKey: nil)
```

<p align="center">
    <a href="https://media.giphy.com/media/7JgLNf9UxUlJ8PI3sg/giphy">
        <img src="https://media.giphy.com/media/7JgLNf9UxUlJ8PI3sg/giphy.gif">
    </a>
</p>

## 14. LoginAnimations - Layer Springs

In this section we will use *CoreAnimation* to make spring animations for layers that renders a physical simulation that looks and feels much more natural than the UIKit method to create spring animations. For this, we will use the *CASpringAnimation* class with the following properties:
* *damping*: The damping applied
* *mass*: The mass of the weight
* *stiffness*: The stiffness of the spring attached to the weight
* *initialVelocity*: The initial *push* applied to the weight

```swift
func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text else { return }

    // When user introduces less than 5 characters in username or password text fields
    if text.count < 5 {
    
        // Create a spring animation on Y position
        let jump = CASpringAnimation(keyPath: "position.y")
        jump.initialVelocity = 100.0
        jump.mass = 10.0
        jump.stiffness = 1500.0
        jump.damping = 50.0
        jump.fromValue = textField.layer.position.y + 1.0
        jump.toValue = textField.layer.position.y
        jump.duration = jump.settlingDuration
        textField.layer.add(jump, forKey: nil)

        textField.layer.borderWidth = 3.0
        textField.layer.borderColor = UIColor.clear.cgColor

        // Create a flash animation on borderColor
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 7.0
        flash.stiffness = 200.0
        flash.fromValue = UIColor(red: 1.0, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
        flash.toValue = UIColor.white.cgColor
        flash.duration = flash.settlingDuration
        textField.layer.add(flash, forKey: nil)
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/2mFEm5ltiaY3Cj0s8L/giphy">
        <img src="https://media.giphy.com/media/2mFEm5ltiaY3Cj0s8L/giphy.gif">
    </a>
</p>

## 15. LoginAnimations - Layer Keyframe Animation

In contrast with view keyframe animations, *CAKeyframeAnimation* animates only a single property on a given layer. In the example below, a balloon layer is created and there's used a *CAKeyframeAnimation* in order to animate its position for a duration of 12 seconds using 3 points as values for when the login button is pressed.	:arrow_down:

```swift
@IBAction func login(_ sender: UIButton) {
    ...
    
    // Insert balloon in view's layer
    let balloon = CALayer()
    balloon.contents = UIImage(named: "balloon")?.cgImage
    balloon.frame = CGRect(x: -50.0, y: 0.0, width: 50.0, height: 65.0)
    view.layer.insertSublayer(balloon, below: usernameTextField.layer)

    // Create keyframe animation for position
    let flight = CAKeyframeAnimation(keyPath: "position")
    flight.duration = 12.0
    flight.values = [
        CGPoint(x: -50.0, y: 0.0),
        CGPoint(x: view.frame.width + 50.0, y: 160.0),
        CGPoint(x: -50.0, y: loginButton.center.y),
    ].map { NSValue(cgPoint: $0) }
    balloon.add(flight, forKey: nil)
    balloon.position = CGPoint(x: -50.0, y: loginButton.center.y)
}
```

<p align="center">
    <a href="https://media.giphy.com/media/1zKP6y4hywN3OQd9Dq/giphy">
        <img src="https://media.giphy.com/media/1zKP6y4hywN3OQd9Dq/giphy.gif">
    </a>
</p>

## 16. ShapeMorphing - Bounce Off Animation

```swift
func searchForOpponent() {
    let avatarSize = myAvatar.frame.size
    
    // Horizontal distance the avatars should move when they bounce towards each other
    let bounceXOffset: CGFloat = avatarSize.width / 1.9
    let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
    
    // Locations to which the avatars should move
    let rightBouncePoint = CGPoint(x: view.frame.size.width / 2.0 + bounceXOffset,
                                   y: myAvatar.center.y)
    let leftBouncePoint = CGPoint(x: view.frame.size.width / 2.0 - bounceXOffset, 
                                  y: myAvatar.center.y)

    myAvatar.bounceOff(point: rightBouncePoint, morphSize: morphSize)
    opponentAvatar.bounceOff(point: leftBouncePoint, morphSize: morphSize)
}
```

```swift
class AvatarView: UIView {
    ...
    
    func bounceOff(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center

        // Animate towards center of the view
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0, 
                       usingSpringWithDamping: 0.8, 
                       initialSpringVelocity: 0.8, 
                       options: [], 
                       animations: {
            self.center = point
        }) { _ in
            // Complete bounce to
        }

        // Animate to original positions
        UIView.animate(withDuration: animationDuration, 
                       delay: animationDuration, 
                       usingSpringWithDamping: 0.7, 
                       initialSpringVelocity: 1.0, 
                       options: [],
                       animations: {
            self.center = originalCenter
        }) { _ in
            delay(seconds: 0.1) {
                self.bounceOff(point: point, morphSize: morphSize)
            }
        }
    }
}
```

<p align="center">
    <a href="https://media.giphy.com/media/sRK6ck74AFW3Pur4F0/giphy">
        <img src="https://media.giphy.com/media/sRK6ck74AFW3Pur4F0/giphy.gif">
    </a>
</p>

## 17. ShapeMorphing - Morphing Shapes Animation

In this section, the two avatars will squish a little in this perfectly elastic collision to look like the avatars are pressing against each other when they meet in the middle of the screen.

```swift
func bounceOff(point: CGPoint, morphSize: CGSize) {
    ...
    
    // Compute morphedFrame depending on avatar animation direction
    let morphedFrame = (originalCenter.x > point.x) ?
        CGRect(x: 0.0,
               y: bounds.height - morphSize.height,
               idth: morphSize.width,
               height: morphSize.height) :
        CGRect(x: bounds.width - morphSize.width,
               y: bounds.height - morphSize.height,
               width: morphSize.width,
               height: morphSize.height)

    // Shape shifting animation
    let morphAnimation = CABasicAnimation(keyPath: "path")
    morphAnimation.duration = animationDuration
    morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
    morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

    circleLayer.add(morphAnimation, forKey: nil)
    maskLayer.add(morphAnimation, forKey: nil)
}
```

<p align="center">
    <a href="https://media.giphy.com/media/pyvPmdmbdrcsZUSRv3/giphy">
        <img src="https://media.giphy.com/media/pyvPmdmbdrcsZUSRv3/giphy.gif">
    </a>
</p>

## 18. GradientAnimations - Lock Screen Gradient Animation

The goal of this section is to recreate a moving gradient animation. For this, I will use the *CAGradientLayer* class which has 4 animatable properties along with the ones inherited from *CALayer*:
* *colors*: Animates the gradient's colors to give it a tint
* *locations*: Animates the color milestone locations to make the colors move around inside the gradient
* *startPoint* and *endPoint*: Animate the extents of the layout of the gradient

In the code block below is described every step to perform the gradient animation.

```swift  
override func didMoveToSuperview() {
    super.didMoveToSuperview()

    // Set the Background Color
    backgroundColor = .black
    clipsToBounds = true

    // Configure the gradient start and end point
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

    // Configure the colors for gradient
    let colors = [
        UIColor.white.cgColor,
        UIColor.green.cgColor,
        UIColor.orange.cgColor,
        UIColor.yellow.cgColor,
        UIColor.cyan.cgColor,
        UIColor.red.cgColor,
        UIColor.white.cgColor
    ]
    gradientLayer.colors = colors

    // Set gradient locations
    let locations: [NSNumber] = [0.25, 0.50, 0.75]
    gradientLayer.locations = locations
}

override func didMoveToWindow() {
    super.didMoveToWindow()

    layer.addSublayer(gradientLayer)

    // Configure gradientAnimation for animating locations
    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
    gradientAnimation.toValue = [0.65, 0.75, 0.8, 0.85, 0.9, 0.95, 1.0]
    gradientAnimation.duration = 3.0
    gradientAnimation.repeatCount = Float.infinity
    gradientLayer.add(gradientAnimation, forKey: nil)
}
```

<p align="center">
    <a href="https://media.giphy.com/media/fwYXjzLCB8Y74E9W5f/giphy">
       <img src="https://media.giphy.com/media/fwYXjzLCB8Y74E9W5f/giphy.gif">
    </a>
</p>

## 19. RefreshAnimation - Stroke and Path Animations

In this part, I will do the coolest pull-to-refresh animation ever using stroke and path animations. Firstly, I will create a circle shape and I will add an airplane image on the circle layer.

```swift
class RefreshView: UIView, UIScrollViewDelegate {
    ...
    let ovalShapeLayer = CAShapeLayer()

    init(frame: CGRect, scrollView: UIScrollView) {
        ...

        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4.0
        ovalShapeLayer.lineDashPattern = [2, 3]

        let refreshRadius = frame.size.height / 2 * 0.8

        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width / 2 - refreshRadius, 
                                                          y: frame.size.height / 2 - refreshRadius, 
                                                          width: 2 * refreshRadius, 
                                                          height: 2 * refreshRadius)).cgPath
        layer.addSublayer(ovalShapeLayer)

        let airplaneImage = UIImage(named: "airplane")!
        airplaneLayer.contents = airplaneImage.cgImage
        airplaneLayer.bounds = CGRect(x: 0.0, 
                                      y: 0.0, 
                                      width: airplaneImage.size.width, 
                                      height: airplaneImage.size.height)
        airplaneLayer.position = CGPoint(x: frame.size.width / 2 + refreshRadius, 
                                         y: frame.size.height / 2)

        layer.addSublayer(airplaneLayer)

        airplaneLayer.opacity = 0.0
    }
    ...
}
```

In the code below are animation for both the *strokeStart* and *strokeEnd* properties to make the shape "run around". :arrow_down:

```swift
let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
strokeStartAnimation.fromValue = -0.5
strokeStartAnimation.toValue = 1.0

let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
strokeEndAnimation.fromValue = 0.0
strokeEndAnimation.toValue = 1.0

let strokeAnimationGroup = CAAnimationGroup()
strokeAnimationGroup.duration = 1.5
strokeAnimationGroup.repeatDuration = 5.0
strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
```

The final step is to animate the airplane layer along the path and to animate the orientation of the airplane image.

```swift
let flightAnimation = CAKeyframeAnimation(keyPath: "position")
flightAnimation.path = ovalShapeLayer.path
flightAnimation.calculationMode = CAAnimationCalculationMode.paced

let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
airplaneOrientationAnimation.fromValue = 0
airplaneOrientationAnimation.toValue = 2.0 * .pi

let flightAnimationGroup = CAAnimationGroup()
flightAnimationGroup.duration = 1.5
flightAnimationGroup.repeatDuration = 5.0
flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
airplaneLayer.add(flightAnimationGroup, forKey: nil)
```

<p align="center">
    <a href="https://media.giphy.com/media/iOrVj0SC4ZGVNkHQof/giphy">
        <img src="https://media.giphy.com/media/iOrVj0SC4ZGVNkHQof/giphy.gif">
    </a>
</p>

## 20. IrisAnimations - Replicating Animations

In this section, I will use a container layer that replicates animations called *CAReplicatorLayer* which makes the content of the layer to be copied multiple times on the screen. This class permits to apply a transform between copies and to set an animation delay to follow each copy.

I will use three *CAReplicatorLayer* properties:
* *instanceCount*: Sets the number of copies
* *instanceTransform*: Sets the transform to apply between copies
* *instanceDelay*: Sets the animation delay between copies

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    replicator.frame = view.bounds
    view.layer.addSublayer(replicator)

    // dot represents a CALayer in square shape
    dot.frame = CGRect(x: replicator.frame.size.width - dotLength,
                       y: replicator.position.y,
                       width: dotLength,
                       height: dotLength)
    dot.backgroundColor = UIColor.gray.cgColor
    dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
    dot.borderWidth = 0.5
    dot.cornerRadius = 1.5

    // Adding dot to replicator
    replicator.addSublayer(dot)

    // Configure replicator's properties
    replicator.instanceCount = Int(view.frame.size.width / dotOffset)
    replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
    replicator.instanceDelay = 0.02
}
```

In the code block above is configured just the replicator. To perform animations you need to add animations to the dot layer like I did before. An example of what can be done with *CAReplicatorLayer* is in the image below and the details of the implementation are available in the corresponding commit: [IrisAnimations - Replicating Animations](https://github.com/Marian25/iOS_Animations/commit/e61c9505afe07d1193521b8cbe6d6ae7bba5d3aa). :arrow_down:

<p align="center">
    <a href="https://media.giphy.com/media/5bd5VgNqpE64w2vdZH/giphy">
        <img src="https://media.giphy.com/media/5bd5VgNqpE64w2vdZH/giphy.gif">
    </a>
</p>

## 21. CookAnimations - Presentation Controller & Orientation Animations

In this section, I will customize the presentation controller animation. To do that, I need to adopt *UIViewControllerTransitioningDelegate* and implement the *animationController(forPresented:presenting:source:)* method so that UIKit can call it and use the returned object as the animation controller for the transition. For that, I need to set the *transitioningDelegate* on DetailsViewController.

```swift
@objc func didTapImageView(_ tap: UITapGestureRecognizer) {
    selectedImage = tap.view as? UIImageView

    let index = selectedImage!.tag
    let selectedHerb = herbs[index]

    let herbDetails = storyboard!.instantiateViewController(withIdentifier: "HerbDetailsViewController") as! HerbDetailsViewController
    herbDetails.herb = selectedHerb
    herbDetails.transitioningDelegate = self
    present(herbDetails, animated: true, completion: nil)
}
```

Next, I need to define a class for the animator that conforms to the *UIViewControllerAnimatedTransitioning* protocol as follows:

```swift
class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

}
```

You can see the implementation here: [PopAnimator.swift](https://github.com/Marian25/iOS_Animations/blob/master/CookAnimations/CookAnimations/PopAnimator.swift)


<p align="center">
    <a href="https://media.giphy.com/media/ensLAfpldwLFEXtixs/giphy.gif">
        <img src="https://media.giphy.com/media/ensLAfpldwLFEXtixs/giphy.gif">
    </a>
</p>

## 22. LogoReveal - UINavigationController Custom Transition Animations

In a similar way as in the previous section, to customize navigation transitions I need to adopt the *UINavigationControllerDelegate* protocol for *MasterViewController* and set it to be the delegate of the navigation controller. In this way, every time I push a view controller onto the navigation stack, the navigation controller will ask its delegate whether it should use the built-in transition or a custom one.

You can view the implementation of the animator here: [RevealAnimator.swift](https://github.com/Marian25/iOS_Animations/blob/master/LogoReveal/LogoReveal/RevealAnimator.swift)

All details of this custom transition animation are available in its corresponding commit: [LogoReveal - UINavigationController Custom Transition Animations](https://github.com/Marian25/iOS_Animations/commit/f00c8b22574306a4698ed10bb3e9f1bc64edc4c9)

<p align="center">
    <a href="https://media.giphy.com/media/wHOnneTqLrFPoWLQVp/giphy">
        <img src="https://media.giphy.com/media/wHOnneTqLrFPoWLQVp/giphy.gif">
    </a>
</p>

## 23. PhoneBookAnimations - Simple 3D Animations

In this section I want to add some depth to the side menu when it is displayed. For this, I created the method *menuTransform(percent:)* which accepts a single parameter of the current progress of the menu, which was calculated by the code in *handleGesture(_:)* and returns an instance of *CATransform3D*.

```swift
func menuTransform(percent: CGFloat) -> CATransform3D {
    var identity = CATransform3DIdentity
    
    // Set z-axis perspective using 1000 for camera distance
    identity.m34 = -1.0 / 1000

    let remainingPercent = 1.0 - percent
    
    // Calculate *openness* angle
    let angle = remainingPercent * .pi * -0.5

    // Create rotation transform
    let rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0)
    
    // Create translation tranform
    let translationTransform = CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
    
    return CATransform3DConcat(rotationTransform, translationTransform)
}
```

All transforms are calculated around the layer’s anchor point. By default, the anchor point of a layer has an x coordinate of 0.5, meaning it is in the center. So, I need to set the x of the anchor point to 1.0 to make the menu rotate around its right edge like a hinge.

```swift
menuViewController.view.layer.anchorPoint.x = 1.0
```

<p align="center">
    <a href="https://media.giphy.com/media/82kMt5NLKiGz7OcMBK/giphy">
        <img src="https://media.giphy.com/media/82kMt5NLKiGz7OcMBK/giphy.gif">
    </a>
</p>

## 24. ImageGallery - Intermediate 3D Animations

The scope of this section is to create a 3D effect to get an overall view of the images in the hurricane image gallery. To do this I linked an IBAction from left-top button to *toggleGallery(_:)* method. For more details about implementation follow the comments in code.

```swift
@IBAction func toggleGallery(_ sender: Any) {
    // Check if gallley is open or not
    if isGalleryOpen {
        for subview in view.subviews {
            // Get only hurricane images
            guard let image = subview as? ImageViewCard else { continue }

            // Create animation to animate image from current transform to identity
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: image.layer.transform)
            animation.toValue = CATransform3DIdentity
            animation.duration = 0.33
            
            // Add animation to image
            image.layer.add(animation, forKey: nil)
            
            // Reset image transform
            image.layer.transform = CATransform3DIdentity
        }
    } else {
        // Offset between images
        var imageYOffset: CGFloat = 100.0

        for subview in view.subviews {
            // Get only hurricane images
            guard let image = subview as? ImageViewCard else { continue }

            // Create identity transform
            var imageTransform = CATransform3DIdentity
            
            // Translate using offset
            imageTransform = CATransform3DTranslate(imageTransform, 0.0, imageYOffset, 0.0)
            
            // Scale on Y coordinate 
            imageTransform = CATransform3DScale(imageTransform, 0.95, 0.6, 1.0)
            
            // Rotate by 22.5 degrees to give the image some perspective distortion
            imageTransform = CATransform3DRotate(imageTransform, .pi / 8, -1.0, 0.0, 0.0)

            // Create animation to animate image from current transform to previously calculated transform
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(caTransform3D: image.layer.transform)
            animation.toValue = imageTransform
            animation.duration = 0.33
            
            // Add animation to image
            image.layer.add(animation, forKey: nil)
            
             // Set image transform to previously calculated transform
            image.layer.transform = imageTransform

            // Increase offset
            imageYOffset += view.frame.height / CGFloat(images.count)
        }
    }

    isGalleryOpen = !isGalleryOpen
}
```

<p align="center">
    <a href="https://media.giphy.com/media/1es0sgM2XXQNOnz7Pz/giphy">
        <img src="https://media.giphy.com/media/1es0sgM2XXQNOnz7Pz/giphy.gif">
    </a>
</p>

## 25. SnowAnimation - Particle Emitters

In this section I create the particle emitter snow effect using *CAEmitterLayer*. The implementation is explained in detail in the comments as shown in the code below. :arrow_down:

```swift
 override func viewDidLoad() {
    ...
    
    // Create emitter frame
    let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width, height: 50.0)
    let emitter = CAEmitterLayer()
    emitter.frame = rect
    
    // Add emitter to layer
    view.layer.addSublayer(emitter)

    // Set emitter shape & position & size
    emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
    emitter.emitterPosition = CGPoint(x: rect.width / 2, y: rect.height / 2)
    emitter.emitterSize = rect.size

    // Generate emitter cells for every type of flake
    for flake in flakes {
        let emitterCell = makeEmitterCell(with: flake)
        if emitter.emitterCells == nil {
            emitter.emitterCells = [emitterCell]
        } else {
            emitter.emitterCells!.append(emitterCell)
        }
    }
}
```

```swift
func makeEmitterCell(with imageNamed: String) -> CAEmitterCell {
    // Create emitter cell
    let emitterCell = CAEmitterCell()
    
    // Set emitter image
    emitterCell.contents = UIImage(named: imageNamed)?.cgImage
    
    // Set emitter properties
    emitterCell.birthRate = 50
    emitterCell.lifetime = 3.5
    emitterCell.yAcceleration = 70.0
    emitterCell.xAcceleration = 10.0
    emitterCell.velocity = 20.0
    emitterCell.emissionLongitude = -.pi
    emitterCell.velocityRange = 200.0
    emitterCell.emissionRange = .pi * 0.5
    emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
    emitterCell.redRange = 0.1
    emitterCell.greenRange = 0.1
    emitterCell.blueRange = 0.1
    emitterCell.scale = 0.8
    emitterCell.scaleRange = 0.8
    emitterCell.scaleSpeed = -0.15
    emitterCell.alphaRange = 0.75
    emitterCell.alphaSpeed = -0.15
    emitterCell.lifetimeRange = 1.0
    
    return emitterCell
}
```

<p align="center">
    <a href="https://media.giphy.com/media/5oKf6xG6123G0N3goG/giphy">
       <img src="https://media.giphy.com/media/5oKf6xG6123G0N3goG/giphy.gif">
    </a>
</p>

## 26. SouthPoleAnimations - Frame Animations with UIImageView

Now, I will probably do the most extraordinary animation you will ever see, I will animate a penguin to walk and slide. For the walking animation I created a method called *loadWalkAnimation()*. :arrow_down:

```swift
func loadWalkAnimation() {
    // Store all the frame images 
    penguin.animationImages = walkFrames
    
    // Set iteration duration
    penguin.animationDuration = animationDuration / 3
    
    // Set repeat count of the animation
    penguin.animationRepeatCount = 3
}
```

Now, in order to move the penguin I implemented the right and left action like: :arrow_down:

```swift
@IBAction func actionLeft(_ sender: Any) {
    // Set looking direction
    isLookingRight = false
    
    // Start animation
    penguin.startAnimating()

    // Animate the translation on x-axis to left
    UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
        self.penguin.center.x -= self.walkSize.width
    }, completion: nil)
}

@IBAction func actionRight(_ sender: Any) {
    // Set looking direction
    isLookingRight = true
    
    // Start animation
    penguin.startAnimating()

    // Animate the translation on x-axis to right
    UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
        self.penguin.center.x += self.walkSize.width
    }, completion: nil)
}
```

The implementation for the slide action is quite similar, so I don't do that here, but you can see the full implementation here: [SouthPoleAnimations - Frame Animations with UIImageView](https://github.com/Marian25/iOS_Animations/commit/c7c35284dd8b90ab77ce86585072f8385b0acc48)

<p align="center">
    <a href="https://media.giphy.com/media/yvXBhDYjYLoOMgnOmI/giphy">
       <img src="https://media.giphy.com/media/yvXBhDYjYLoOMgnOmI/giphy.gif">
    </a>
</p>


