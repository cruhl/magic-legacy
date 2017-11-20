import { Handler, S3EventRecord, Context, Callback } from "aws-lambda";

import * as AWS from "aws-sdk";
import * as speech from "@google-cloud/speech";

const { GOOGLE_PROJECT_ID } = process.env;

const s3 = new AWS.S3();

const speechClient = new speech.SpeechClient({
  projectId: "cruhl-magic-app"
  // projectId: GOOGLE_PROJECT_ID
});

const mockEvent = {
  s3: {
    bucket: { name: "cruhl-magic-recordings" },
    object: { key: "RE4468de0af589e04fc78c2ab8574bf73d.wav" }
  }
};

(async (callback: (err?: string) => void) => {
  const { bucket, object } = mockEvent.s3;

  const { Body: recording } = await s3
    .getObject({ Bucket: bucket.name, Key: object.key })
    .promise();

  const speechResponse = await speechClient.recognize({
    audio: { content: recording },
    config: {
      encoding: "LINEAR16",
      sampleRateHertz: 8000,
      languageCode: "en-US"
    }
  });

  console.log(JSON.stringify(speechResponse));

  callback();
})(() => {});
