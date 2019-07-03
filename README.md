# TweetsAnalyser
<p align="center">
  <img width="300" height="500" src="https://i.imgur.com/NS73Cyi.png">
</p>

Analyses the sentiment of the tweets written by people into **positive, negative & nuetral**.
Inspiration for this app came from a study conducted in IIT,Bhubaneswar : https://arxiv.org/pdf/1610.09225.pdf
For any particular handle, this app analyses the cumulative sentiment of 100 latest tweets (written in english language) and generates an emoji based on results.

Text Classfier Machine learning model which classifies any text into positive, negative & nuetral statement is trained using **CreateML**.
For more info on CreateML visit : https://developer.apple.com/machine-learning/create-ml/
![alt text](https://docs-assets.developer.apple.com/published/e6ad1efd6a/d926fc62-3dea-4447-86fc-920d4d6c4781.png)

**CoreML** is then used to incoporate self-trained model into our app.
For more info on CoreML visit : https://developer.apple.com/machine-learning/core-ml/ 
![alt text](https://docs-assets.developer.apple.com/published/7e05fb5a2e/4b0ecf58-a51a-4bfa-a361-eb77e59ed76e.png)

**Functionality:** 

When user enters a handle name, app requests twitter api (https://developer.twitter.com/en/docs/tweets/search/api-reference/get-search-tweets.html) to provide 100 latest tweets for that handle which are in english language. App uses Swifter framework for making api requests (https://github.com/mattdonnelly/Swifter).Then SwiftyJSON cocoapod (http://cocoapods.org/pods/SwiftyJSON) is used to parse JSON result and then feed an array of 100 tweets to our self-trained machine learning model.                

Result parameters:  
 -For every positive tweet +1 is added,                 
 -For every negative tweet -1 is added and                 
 -For every nuetral tweet nothing is added to sentiment score.

Finally the **sentiment score** generates a corresponding emoji representing the overall sentiment of 100 tweets towards the entered handle name.                   

![alt text](https://newscrewdriver.files.wordpress.com/2018/02/twitter-developer.jpg)
