const fs = require("fs");

const SpeechToTextV1 = require("watson-developer-cloud/speech-to-text/v1");

const wavFolder = "data/wav";

const credentialsJson = fs.readFileSync("data/ibm.json").toString();
const { username, password } = JSON.parse(credentialsJson);

fs.readdirSync(wavFolder).forEach((filePath, index, filePaths) => {
  if (filePath == "2017-12-10T04:40:53.000Z.wav") transcribe(filePath);
});

function transcribe(filePath) {
  const speechToText = new SpeechToTextV1({ username, password });

  const params = {
    audio: fs.createReadStream(`${wavFolder}/${filePath}`),
    content_type: "audio/wav",

    model: "en-US_NarrowbandModel",
    timestamps: true,
    word_confidence: true,
    smart_formatting: true,
    speaker_labels: true
  };

  speechToText.recognize(params, (err, response) => {
    if (err) throw err;
    fs.writeFileSync("data/transcription.json", JSON.stringify(response));
  });
}
