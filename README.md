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

Now, within that new InBrain Dictionary row, click the arrow to the left of the title and make sure it’s pointing downwards. Once confirmed, press the **“+”** to add a new row to the InBrain Dictionary. Title it **“client”**, set its type to *String*, then add your clientID value into this field.

Next, add another row to your InBrain Dictionary in your Info.plist and title it **“server”**. Set its type to *Bool*, then if your app will be using S2S callbacks for inBrain rewards, set value to YES, otherwise set to NO.

# Usage
