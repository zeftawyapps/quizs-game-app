This application is a question and answer application that contains a control panel for adding questions and a mobile application to display questions to the user. The user solves the questions and displays the answer. It also contains AdMob ads and the possibility of payment.

Other possible translations: 

* This app is a Q&A app that features a dashboard for adding questions and a mobile app for displaying questions to the user. The user solves the questions and displays the answer. It also includes AdMob ads and a payment option.
* This app is a quiz app that features an admin panel for adding questions and a mobile app for users to answer questions. Users can solve the questions and view the answers. The app also includes AdMob ads and a payment option.

Additional information:

* The app is designed to be used by both students and teachers.
* The app includes a variety of question types, including multiple choice, true/false, and short answer.
* The app allows users to track their progress and see their scores.
* The app is available for both Android and iOS devices.

## the images 

app iamges 

![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/Screenshot_2023-10-17-11-57-18-43_42c17d524df30ba81cdddad866a78249.jpg) ![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/Screenshot_2023-11-26-22-25-58-97_42c17d524df30ba81cdddad866a78249.jpg) ![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/Screenshot_2023-11-26-22-26-26-11_42c17d524df30ba81cdddad866a78249.jpg) ![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/Screenshot_2023-11-26-22-26-23-09_42c17d524df30ba81cdddad866a78249.jpg) 

dashboard iamge 

![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/d1.png) 

![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/d2.png) 

![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/d3.png) 

![](https://github.com/zeftawyapps/quizs-game-app/blob/master/app%20image/d4.png) 


# Get start : 
To start in this app you should to change the app android and ios packages name aftar you download the code  then : 
1- log in to firebase and create new project and add anroind and ios app and dowload the google_service.json file 
2- to run the firebase in web app you should to change the firebase options in the file  #assets/json_config/firebase_config.json  , 
```markdown
``` json
{ 
"firebaseConfig": {
    "dev": {
        "apiKey": "AIzaSyBYzJ ",
        "appId": "1:10451050373"  ,
        "messagingSenderId": "6",
        "projectId": "quiz",
        "storageBucket": "qustions.appspot.com"
    } ,
    "prod": {
        "apiKey": "AIzaSyBYzJ ",
        "appId": "1:10451050373"  ,
        "messagingSenderId": "6",
        "projectId": "quiz",
        "storageBucket": "qustions.appspot.com"
    }

}
}
```

and change the base url in file  assets/json_config/base_url_config.json
``` markdown
``` json
{
"baseUrls": {

    "remote":  "https://europe-west3-" ,
    "local": "http://127.0.0.1:5001/"

}
}
``` 
2-  if you want to custom your app yuo shold to douwload this reposatories : 
   -  [user model :](https://github.com/zeftawyapps/users_module)
   - [ zeftawyapps/quize-module :](https://github.com/zeftawyapps/quize-module)
   - [coloud functions :](https://github.com/zeftawyapps/quiz-cloud-function-backend)
 




