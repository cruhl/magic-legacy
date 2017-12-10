import * as fs from "fs";
import * as https from "https";

const csv = fs.readFileSync("data/calls.csv");
const lines = csv.toString().split("\n");

// remove headers
lines.shift();
lines.pop();

const recordings = lines.map(line => {
  const [
    sid,
    accountSid,
    callSid,
    duration,
    flag1,
    flag2,
    price,
    apiVersion,
    status,
    dateDeleted,
    channels,
    source,
    dateCreated,
    dateUpdated
  ] = line.split(",");

  const start = new Date(dateCreated).getTime();
  const end = start + parseInt(duration) * 1000;

  return { start, end };
});

fs.writeFileSync("data/calls.json", JSON.stringify(recordings));

// lines.forEach((line, index) => setTimeout(() => download(line), index * 500));

function download(line: any) {
  const [
    sid,
    accountSid,
    callSid,
    duration,
    flag1,
    flag2,
    price,
    apiVersion,
    status,
    dateDeleted,
    channels,
    source,
    dateCreated,
    dateUpdated
  ] = line.split(",");

  const fileName = `data/wav/${new Date(dateCreated).toISOString()}.wav`;
  const fileStream = fs.createWriteStream(fileName);

  const uri = [
    `https://api.twilio.com/2010-04-01/Accounts/`,
    accountSid,
    "/Recordings/",
    sid,
    ".wav?Download=true"
  ].join("");

  https.get(uri, response => {
    response
      .on("data", data => {
        fileStream.write(data);
      })
      .on("end", () => {
        fileStream.end();
        console.log({ fileName, duration: parseInt(duration) });
      });
  });
}
