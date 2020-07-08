# InBrainSurveys_SDK_Swift
Survey library to monetize your mobile app, provided by inBrain.ai

# Requirements
* iOS 10.0
* Xcode 11+

# Installation
### Manual
Drag and drop the **InBrainSurveys_SDK_Swift.xcframework** file into the same folder level as your *[AppName].xcodeproj* or *[AppName].xworkspace* file. 

**Next...**
Visit your app’s ***Target*** in the Project Settings and Choose the ***General*** tab.
Scroll down until you hit the ***Embedded Binaries*** section… 
1) Press ‘+’ to Locate the **InBrainSurveys_SDK_Swift.framework** file in your file hierarchy.
2) Once selected, add to your Embedded Binaries.

# Configuration
You’ll need to have 4 items:

**1)** A unique User ID, (per user)

**2)** Your API Client ID, (as provided by inBrain)

**3)** Your API Secret, (as provided by inBrain)

**4)** Based on your app's architecture, whether the rewards will be delivered via in-app callback or Server-to-Server (S2S)callback 

# Usage

An InBrain object should be added as an instance variable of the presenting UIViewController, then instantiated using the singleton call. 

Also, add your apiClient & apiSecret as a static constant to be used when presenting the web view. (Sample code below)

```
Import InBrainSurveys_SDK_Swift

class ViewController : UIViewController {
    
    var inBrain : InBrain = InBrain.shared
    static let exampleClient = "client"
    static let exampleSecret = "secret"
}
```

To present the InBrain WebView from a UIViewController, set the UIViewController as the inBrain singleton’s inBrainDelegate, then set values using the **setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String)** function call. 

# Parameters

**apiClientID:** Your API Client ID, (as provided by inBrain)

**apiSecret:** Your API Secret, (as provided by inBrain)

**isS2S:** Is your app enabled with Server-to-Server(S2S) callbacks? set to true if so, false if no server architecture

**userID:** A unique User ID, (per user)

Values must be set prior to calling **showSurveys()**. Once values are set then execute the **showSurveys()** function.  (Sample code below)

```
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    inBrain.inBrainDelegate = self
    
    inBrain.setInBrain(apiClientID: ViewController.exampleClient, apiSecret: ViewController.exampleSecret, isS2S: false, userID: "test333@me.com")
    
    inBrain.showSurveys()
}
```
# Advanced Usage
To add session tracking and/or to provide demographic data to your inBrainSurveys session utilize the **setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**

```
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    inBrain.inBrainDelegate = self
    
    inBrain.setInBrain(apiClientID: ViewController.exampleClient, apiSecret: ViewController.exampleSecret, isS2S: false, userID: "test333@me.com")
    
    //Create dataOptions Dictionary
    var data : [[String : Any]] = []
    let data1 : [String: Any] = ["gender" : "male"]
    data.append(data1)
    let data2 : [String : Any] = ["age" : 34]
    data.append(data2)
    
    inBrain.setInBrainValuesFor(sessionID: "testing33_Session", dataOptions: data)
    
    inBrain.showSurveys()
}
```
## Reward Hooks For Server2Server Apps
You can add your callback in your dashboard and test the response!

If you need any assistance in getting your callback working properly, please email us at [dev@inbrain.ai](dev@inbrain.ai)

## Reward Hooks For Serverless Apps
Even without a unique user ID, we’ll pass along the reward value for you to add. 

In order to receive rewards earned from inBrain, the presenting UIViewController should conform to the *InBrainDelegate* and set itself to the inBrainDelegate of the inBrain instance variable declared earlier.

### Handling Rewards Received & Confirming Received Rewards (sample code below)

```
class ViewController: UIViewController, InBrainDelegate {
    func didReceiveInBrainRewards(rewardsArray: [InBrainReward]) {
        var arr : [Int] = []
	for reward in rewardsArray {
            //User's balance is increased by reward amount
	    points +=  reward.amount
	    pointsLabel.text = "Total Points: \(points)"
	    let txID = reward.transactionId
            
            //Append each transactionId value to 'arr' array
	    arr.append(txID)
	}
	//Pass array of transactionID's as parameter of confirmRewards()
	inBrain.confirmRewards(txIdArray: arr)
    }
}
```
### Confirm Received Rewards (sample code above)

Rewards that have been processed **must** be confirmed with InBrain. To do this, use the ***InBrain.confirmRewards(txIDArray: [Int])*** function to confirm the acceptance of reward data.

This call should **always** be made following reward data processing.

## Ad Hoc inBrain Functions

**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String)**
* Ensure this is being called from the InBrain.shared singleton reference 

**setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**
* Available dataOptions keys "age" & "gender"

**showSurveys()**
* Presents the InBrain WebView with your set values as authentication credentials 
* Ensure this is being called from the InBrain.shared singleton reference 

**getRewards() (Useful for server less app)**
* InBrainDelegate must be set and implementation of inBrainRewardsReceived(rewardsArray: [InBrainReward]) function must be available to receive reward data
* Stand alone function to explicitly call for rewards within the app code 

**confirmRewards(txIDArray: [Int]) (Useful for server less app)**
* Necessary call to confirm processed reward data
* Pass array of reward transactionIDs as function parameter 

### InBrainDelegate functions
***surveysClosed()***
* This delegate function calls back whenever the InBrainWebView is dismissed

***didReceiveInBrainRewards(rewardsArray: [InBrainReward])***
* This delegate function provides an array of InBrainReward objects

## Customize inBrain

Call these functions in code prior to calling *showSurveys()*

**setInBrainWebViewTitle(toString: String)**

* Presents the InBrain WebView with the title string which is provided by the toString parameter

**setInBrainWebViewNavBarColor(toColor: UIColor)**

* Presents the InBrain WebView with the navigationBar displaying the toColor parameter as its background color

**setInBrainWebViewNavButtonColor(toColor: UIColor)**

* Presents the InBrain WebView with the navigationButtons displaying the toColor parameter as its text color

# Side note - Things to double check:
* Be sure your setInBrain values have the proper values 

* The UIViewController that presents the InBrainWebView should properly conform to the InBrainDelegate.

* Ensure that you are implementing the didReceiveInBrainRewards() function to receive reward data from the getRewards() call.

