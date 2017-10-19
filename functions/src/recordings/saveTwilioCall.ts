import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

import * as AWS from "aws-sdk";

const { AWS_REGION, RECORDINGS_S3_BUCKET_ID } = process.env;

const s3 = new AWS.S3({ region: AWS_REGION });

export async function saveTwilioCall<ProxyHandler>(
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

  const recordingUrl = JSON.parse(event.body).RecordingUrl;
  if (!recordingUrl) {
    return callback(null, {
      statusCode: 400,
      body: JSON.stringify({
        error: `"RecordingUrl" wasn't found or was undefined.`
      })
    });
  }

  try {
    const result = await s3
      .upload({
        Bucket: `${RECORDINGS_S3_BUCKET_ID}`,
        Key: new Date().toTimeString(),
        Body: "TEST"
      })
      .promise();

    return callback(null, {
      statusCode: 200,
      body: JSON.stringify({
        message: `Recording saved to ${result.Location}!`
      })
    });
  } catch (err) {
    return callback(null, {
      statusCode: 503,
      body: JSON.stringify({ error: `S3 upload failed! ${err.stack}` })
    });
  }
}
