// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
//import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
import { getAuth, GoogleAuthProvider } from 'firebase/auth';
import { getStorage } from 'firebase/storage';
import { getFirestore } from 'firebase/firestore';

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC4TuxFKDFwJ0SRgtVI_gEEYM97P1fnxdQ",
  authDomain: "learners-bc137.firebaseapp.com",
  projectId: "learners-bc137",
  storageBucket: "learners-bc137.appspot.com",
  messagingSenderId: "205023071868",
  appId: "1:205023071868:web:23f934a53f5d0718bd03f9",
  measurementId: "G-SRJQTKPM2T"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// Initialize Firebase
const app = initializeApp(firebaseConfig);
//const analytics = getAnalytics(app);
const auth = getAuth(app);
const db = getFirestore(app);
const storage1 = getStorage(app);

}