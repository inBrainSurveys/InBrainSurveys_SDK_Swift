# InBrainSurveys_SDK_Swift
Survey library to monetize your mobile app, provided by inBrain.ai

# Requirements
* iOS 10.0
* Xcode 11+

# Installation
### Manual
Drag and drop the **InBrainSurveys_SDK_Swift.framework** file into the same folder level as your *[AppName].xcodeproj* or *[AppName].xworkspace* file. 

**Next...**
Visit your app’s ***Target*** in the Project Settings and Choose the ***General*** tab.
Scroll down until you hit the ***Embedded Binaries*** section… 
1) Press ‘+’ to Locate the **InBrainSurveys_SDK_Swift.framework** file in your file hierarchy.
2) Once selected, add to your Embedded Binaries.

# Configuration
You’ll need to have 3 items:

**1)** Your unique App ID

**2)** Your unique Client ID 

**3)** Based on your app's architecture, whether the rewards will be delivered via in-app callback or Server-to-Server (S2S)callback 

Add a new row to your apps's ***Info.plist*** , as type 'Dictionary', and title it **“InBrain”**. (You can right click anywhere in ***Info.plist*** and then click **“Add Row”**.

**Now,** within that new InBrain Dictionary row, click the arrow to the left of the title and make sure it’s pointing downwards. Once confirmed, press the **“+”** to add a new row to the InBrain Dictionary. Title it **“client”**, set its type to *String*, then add your clientID value into this field.

**Next,** add another row to your InBrain Dictionary in your ***Info.plist*** and title it **“server”**. Set its type to *Bool*, then if your app will be using S2S callbacks for inBrain rewards, set value to YES, otherwise set to NO.

**Finally,** add one last row to your InBrain Dictionary in your ***Info.plist*** and title it **'prodEnv'**. Set its type to *Bool*, then if your app is launching in the inBrain production environment, set value to YES, otherwise set value to NO.

(You may want to test in staging (‘NO’ status) but you MUST switch the status to YES before going live.)

# Usage

An InBrain object should be added as an instance variable of the presenting UIViewController, then instantiated using the singleton call. 

Also, add your client secret as a static constant to be used when presenting the web view. (Sample code below)

```
Import InBrainSurveys_SDK_Swift

class ViewController : UIViewController {
    
    var inBrain : InBrain = InBrain.shared
    static let secret = "clientSecret"
}
```

To present the InBrain WebView from a UIViewController, set the UIViewController as the inBrain singleton’s inBrainDelegate, then execute the presentInBrainWebView function call. (Sample code below)

```
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    inBrain.inBrainDelegate = self
    inBrain.presentInBrainWebView(withSecret: self.inBrainClientId, withAppUID: "anyID")
}
```
## Reward Hooks For Server2Server Apps
You can add your callback in your dashboard and test the response!

If you need any assistance in getting your callback working properly, please email us at [dev@inbrain.ai](dev@inbrain.ai)

## Reward Hooks For Serverless Apps
Even without a unique user ID, we’ll pass along the reward value for you to add. 

In order to receive rewards earned from inBrain, the presenting UIViewController should conform to the *InBrainDelegate* and set itself to the inBrainDelegate of the inBrain instance variable declared earlier.

*** Handling Rewards Received & Confirming Received Rewards

```
class ViewController: UIViewController, InBrainDelegate {
    func inBrainRewardsReceived(rewardsArray: [InBrainReward]) {
        //Example Rewards Handling
        var arr : [Int] = []
        for reward in rewardsArray {
         //User's balance is increased by reward amount
         currentUser.balance += reward.amount
           if let txID = reward.transactionId {
              //Append each transactionId value to 'arr' array
              arr.append(txID)
           }
        }
        //Pass array of transactionID's as parameter of confirmRewards() 
        inBrain.confirmRewards(txIDArray: arr)
    }
}
```
### Confirm Received Rewards (sample code above)

Rewards that have been processed **must** be confirmed with InBrain. To do this, use the ***InBrain.confirmRewards(txIDArray: [Int])*** function to confirm the acceptance of reward data.

This call should **always** be made following reward data processing.

