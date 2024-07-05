![Logo](https://github.com/GhostsDragons/LC_web/blob/Updates/Banner.jpg)

# Web Application
####  A Learners' Club student's learning platform

![Static Badge](https://badgen.net/github/last-commit/micromatch/micromatch)

Learners' Club is an educational organization made for the students, by the students. They are targeting the students of **Grade  9 to 12** as well as **JEE** and **NEET** aspirants to help them achieve their goals with the help of effective resources.

This web application is the organization's platform to host all its courses.

This application is built using **Flutter** for the development of the front end to provide a seamless and interactive UX. The application is hosted using Firebase hosting services. It uses Firestore Database and Firebase Storage for text and document-based data respectively.

## Team
App name: LC Web App  
Development Team :  
Hari Goyal (Web developer : May 2024 - till date),  
Aaryan Bhagat (Frontend developer : May 2024 - till date),  
Design Team : Mihir Iyer
Management : Hari Goyal (Sr Manager : June 2023 - Till date),
Web URL : [Learners' Club](https://app.learners-club.org)

## About this file
The purpose of this file is to provide overview, setup instructions and background information of the project. If you have joined this project as a part of the development team, please ensure this file is up to date.

**Note : Any dependencies added / modified to this project which affect the running of the code in this git repository must be listed in this file. All developers must ensure that the instructions mentioned in this file are sufficient to enable a new developer to obtain a executable copy of the lastest code in this repository, without invlvement from any other human assistance.**

## Software Requirements
1. Flutter: 3.22.2
2. Dart: 3.4.3

## Contributing
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`.
3. Commit your changes.
4. Push your branch: `git push origin feature-name`.
5. Create a pull request.

## Setup Instructions
1. ``git clone https://github.com/GhostsDragons/LC_web.git``
2. ``cd LC_web``
3. ``flutter pub get``

## Running the app locally
> ``flutter run -d chrome``

## Adding dependencies
To add a new dependency to the project follow the curresponding steps:
1. Search for the package name on [pub.deb](https://pub.dev/)
2. In the root directory of the project run ``flutter pub add <package_name>``
3. Import the package into the file and start working

## Build the application
Before building an application, make sure all warnings and errors have been taken care of with the help the following 2 steps:
1. ``dart fix --dry-run``
   This will list down all the warnings and syntax errors that are not according to the given standards
2. ``dart fix --apply``
   This will make the necessary changes to the application

To build the application to be deployed the web server:
1. ``flutter build web``
2. ``firebase hosting:channel:deploy preview-channel``
   Deploy the new application on a preview channel to test the application before deploying it to the main branch
3. ``firebase deploy``
   Deploy the web application to the main server

## Colors opacacity
user the folloewing hex codes to set the opcacity of the colors


- 100% — FF
- 95% — F2
- 90% — E6
- 85% — D9
- 80% — CC
- 75% — BF
- 70% — B3
- 65% — A6
- 60% — 99
- 55% — 8C
- 50% — 80
- 45% — 73
- 40% — 66
- 35% — 59
- 30% — 4D
- 25% — 40
- 20% — 33
- 15% — 26
- 10% — 1A
- 5% — 0D
- 0% — 00

# Features

### **Version 1.0**
- [x] Authentication
    - [x] Authenticate existing and new user using email and password
      Date: 13th June, 2024
    - [x] Authenticate users using Google
      Date: 29th June, 2024
- [x] Firebase
    - [x] Firebase Storage structure
      Date: 30th June
    - [ ] Firebase Storage Rules
    - [x] Firebase Firestore Structure
      Date: 2nd July, 2024
    - [ ] Firebase Firestore Rules
    - [x] Web Hosting
      Date: 10th June, 2024
- [ ] Profile Functionality
    - [ ] Edit Profile
    - [ ] View Profile
- [ ] Course Functionality
    - [ ] Cource Catalog
    - [ ] Course Overview
    - [ ] Payment gateway
    - [ ] Course Page
