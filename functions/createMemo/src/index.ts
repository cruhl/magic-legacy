import { Handler, S3EventRecord, Context, Callback } from "aws-lambda";

import * as AWS from "aws-sdk";
import * as speech from "@google-cloud/speech";

import { exec } from "child_process";
import * as path from "path";
import * as tmp from "tmp-promise";
import * as fs from "fs";
import { promisify } from "util";

const { GOOGLE_PROJECT_ID } = process.env;

const s3 = new AWS.S3();

const speechClient = new speech.SpeechClient({
  projectId: "cruhl-magic-app"
  // projectId: GOOGLE_PROJECT_ID
});

const mockEvent = {
  s3: {
    bucket: { name: "cruhl-magic-recordings" },
    object: { key: "2017-11-08T16:23:00.149Z.wav" }
  }
};

(async (callback: (err?: string) => void) => {
  const { bucket, object } = mockEvent.s3;

  const { Body: recording } = await s3
    .getObject({ Bucket: bucket.name, Key: object.key })
    .promise();

  const wavFile = await tmp.file({ postfix: ".wav" });
  const flacFile = await tmp.file({ postfix: ".flac" });

  await promisify(fs.writeFile)(wavFile.path, recording);
  await promisify(exec)(
    `${path.resolve(
      __dirname,
      "bin/sox-14.4.2"
    )} ${wavFile.path} ${flacFile.path}`
  );

  const recordingFile = await promisify(fs.readFile)(flacFile.path);
  const recordingBytes = recordingFile.toString("base64");

  const speechResponse = await speechClient.recognize({
    audio: {
      content: recordingBytes
    },
    config: {
      encoding: "FLAC",
      sampleRateHertz: 8000,
      languageCode: "en-US"
    }
  });

  const response = speechResponse[0];
  const transcription = response.results
    .map((result: any) => result.alternatives[0].transcript)
    .join("\n");

  console.log(`Transcription: ${transcription}`);

  callback();
})(() => {});
