import * as functions from "firebase-functions";
import { twiml } from "twilio";

export const answerCall = functions.https.onRequest((req, res) => {
  const call = new twiml.VoiceResponse();

  call.record({
    playBeep: false,
    recordingStatusCallback:
      "https://us-central1-cruhl-magic.cloudfunctions.net/recordCall"
  });

  call.hangup();

  res
    .type("text/xml")
    .status(200)
    .send(call.toString());
});
