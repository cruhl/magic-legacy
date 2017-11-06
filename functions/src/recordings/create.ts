import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

import * as AWS from "aws-sdk";
import * as queryString from "query-string";
import * as https from "https";

const { RECORDINGS_S3_BUCKET_ID } = process.env;

const s3 = new AWS.S3();

export async function createRecording<ProxyHandler>(
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
): Promise<void> {
  if (typeof event.body != "string") {
    return callback(null, {
      statusCode: 400,
      body: JSON.stringify({ error: "No request body is present!" })
    });
  }

  const recordingUrl = queryString.parse(event.body).RecordingUrl;
  if (!recordingUrl) {
    return callback(null, {
      statusCode: 400,
      body: JSON.stringify({
        error: `"RecordingUrl" wasn't found or was undefined.`
      })
    });
  }

  try {
    https.get(`${recordingUrl}.mp3?Download=true`, async data => {
      const upload = await s3
        .upload({
          Bucket: `${RECORDINGS_S3_BUCKET_ID}`,
          Key: `${new Date().toISOString()}.mp3`,
          Body: data
        })
        .promise();

      return callback(null, {
        statusCode: 200,
        body: JSON.stringify({
          message: `Recording saved! ${upload.Location}`
        })
      });
    });
  } catch (err) {
    return callback(null, {
      statusCode: 503,
      body: JSON.stringify({ error: `S3 upload failed! ${err.stack}` })
    });
  }
}
