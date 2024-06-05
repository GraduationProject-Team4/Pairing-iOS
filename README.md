# 🍎 Pairing-iOS 🍎
![Thumbnail](https://private-user-images.githubusercontent.com/80394340/336069641-821fe107-c47a-41dc-8ba5-bc24f84f4abb.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTc1ODc0MjUsIm5iZiI6MTcxNzU4NzEyNSwicGF0aCI6Ii84MDM5NDM0MC8zMzYwNjk2NDEtODIxZmUxMDctYzQ3YS00MWRjLThiYTUtYmMyNGY4NGY0YWJiLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA2MDUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNjA1VDExMzIwNVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWNmMDY1YTg5Yzc5NDA4ZWJjMzA1NmFiYmQ5OGY4MTI1OTdmMjcwOGJlMzQyM2JhMWNjZjYwMzQ3MWQyYjY1NWMmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.Kt51EBArZusYqeBLh3hfQQejEI6PqbFxbi_NyjMsaX0)

## 🤓 iOS Members 🤓

<img width="200px" src="https://avatars.githubusercontent.com/u/87434861?v=4"/> | <img width="200px" src="https://avatars.githubusercontent.com/u/80394340?v=4"/> | 
|:-----:|:-----:|
|[Seo Eunsu 👩‍💻](https://github.com/EunsuSeo01)|[Lee Youjin 👩‍💻](https://github.com/youz2me)|

## Screens 📱
|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 10 09](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/4b028b1d-de8e-4f32-8f5f-538fee41ff11)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 19 56](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/c9186fe7-0e2c-4b8a-9bfa-8cef8bbe22fc)|
|--|--|

|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 10](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/5eb8fc89-f236-4625-909a-190351dae0f4)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 13](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/0e17c019-64c2-44cc-a5a9-2471a0c24b24)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 30](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/1247cc58-5631-48e9-95b6-f895b25a505f)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 41](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/fc5fe278-e405-4de0-bb9e-e6ba0794aa46)|
|--|--|--|--|

|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 21 04](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/378795b9-48d9-42fa-96d7-f5e7126aa3e7)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 13](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/7e7ea120-2977-4ae7-bf6f-adc278a6f264)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 30](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/d41145b5-db83-42eb-8cab-3d8caafa2c8b)|![Simulator Screenshot - iPhone 13 Pro - 2024-05-12 at 23 20 41](https://github.com/GraduationProject-Team4/Pairing-iOS/assets/87434861/3d43cd13-079f-4ec6-804b-83bbd0fc1370)|
|--|--|--|--|


## Background 💭
Deaf people are classified into deaf people who use sign language, a visual language, as their first language, and Old people who use spoken language, a voice language, as their first language. According to statistics from the Ministry of Health and Welfare in 2020, 90.1 percent of 440,000 deaf people use voice language. In addition, according to statistics from the Seoul Metropolitan Government in 2020, the most difficult people in communication were deaf people. So we came up with the idea that it would be good to create an application that helps the deaf to communicate and live their daily lives in a non-disabled society.

## Key features 📍
Pairing is a life assistance application for the safety and daily life of the deaf.
Pairing's functions are largely divided into two categories: 'Current Environmental Analysis' and 'Real Time Conversation Analysis'.

### Current Environmental Analysis 🔊
Pairing collect ambient sounds and analyze what sounds are composed of. When a dangerous decibel is set, vibration and push notifications are used to notify users when a sound exceeds that decibel.

When the user sends the data recorded by the surrounding sound to the server as input, the server requests the AI Model to analyze the data. The AI Model analyzes the data and delivers the result as an output to the server, and the server receives it and delivers the analysis result to the user through the app.

### Real Time Conversation Analysis 📝
Pairing records conversations, writes real-time scripts for them, and extracts and shows keywords for conversations based on these scripts.

When a user sends a chat voice as input to an app in real time, the app sends this data to the Google Cloud STT. The Google Cloud STT converts this voice into text, delivers it to the app as output, and the app displays it on the screen and shows it. The script's keyword output delivers the script from which the app was created as input to the ChatGPT API. The ChatGPT API extracts keywords from the script and sends them as output to the app, which shows them on the screen.

## Used Libraries ⚙️
- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Google Cloud STT](https://cloud.google.com/speech-to-text/)
- [ChatGPT API](https://platform.openai.com/docs/guides/text-generation/chat-completions-api)
