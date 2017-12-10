import * as fs from "fs";
import { promisify } from "util";

import * as AWS from "aws-sdk";

var lex = new AWS.LexRuntime({ region: "us-east-1" });

const wavFolder = "data/wav";

(async function main() {
  fs.readdirSync(wavFolder).forEach((filePath, index, filePaths) => {
    if (index % 5 == 0) transcribe(filePath);
  });
})();

async function transcribe(filePath: string) {
  const audioData = fs.readFileSync(`${wavFolder}/${filePath}`);

  const lexResponse = await lex
    .postContent({
      botAlias: "$LATEST",
      botName: "magic",
      contentType: "audio/x-l16; sample-rate=8000; channel-count=1",
      inputStream: audioData,
      userId: "cruhl-magic-test-user",
      accept: "text/plain; charset=utf-8"
    })
    .promise();

  console.log(lexResponse);
}
