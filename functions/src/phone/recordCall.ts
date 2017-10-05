import * as functions from "firebase-functions";

import * as firebase from "firebase/storage";
import axios from "axios";

const config = {
  apiKey: "AIzaSyCy21PEcm_vd865bMzrzqKR6TUUGJ79PMg",
  storageBucket: "gs://cruhl-magic.appspot.com"
};

firebase.initializeApp(config);

firebase
  .storage()
  .ref()
  .child("calls/call.wav")
  .putString("2")
  .then(snapshot => {
    console.log("Success!");
  });

export const recordCall = functions.https.onRequest((req, res) => {
  res.status(200).end();

  axios.get(req.body.RecordingUrl).then(res => {
    firebase
      .storage()
      .ref()
      .child("calls/call.wav")
      .put(req.body.RecordingUrl)
      .then(snapshot => {
        console.log("Success!");
      });
  });
});
