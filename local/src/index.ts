import * as fs from "fs";
import * as https from "https";

const csv = fs.readFileSync("data/recordings.csv");
const lines = csv.toString().split("\n");

lines.forEach((line, index) => setTimeout(() => download(line), index * 250));

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

  if (sid == "Sid" || !dateCreated) return;

  const fileName = `data/wav/${new Date(dateCreated).toISOString()}.wav`;
  const file = fs.createWriteStream(fileName);

  https.get(
    `https://api.twilio.com/2010-04-01/Accounts/${accountSid}/Recordings/${sid}.wav?Download=true`,
    response => {
      response
        .on("data", data => {
          file.write(data);
        })
        .on("end", () => {
          file.end();
          console.log({ fileName, duration });
        });
    }
  );
}
