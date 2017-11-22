import * as fs from "fs";
import { promisify } from "util";

import * as speech from "@google-cloud/speech";

const wavFolder = "data/wav";

const speechClient = new speech.SpeechClient({ projectId: "cruhl-magic-app" });

(async function main() {
  fs.readdirSync(wavFolder).forEach((filePath, index, filePaths) => {
    transcribe(filePath);
  });
})();

function transcribe(filePath: string) {
  const request = {
    config: {
      encoding: "LINEAR16",
      sampleRateHertz: 8000,
      languageCode: "en-US"
    },
    interimResults: false
  };

  const recognizeStream = speechClient
    .streamingRecognize(request)
    .on("error", console.error)
    .on("data", (data: any) => console.log(JSON.stringify(data)));

  fs.createReadStream(`${wavFolder}/${filePath}`).pipe(recognizeStream);
}
