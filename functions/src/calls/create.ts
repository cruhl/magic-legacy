import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

import { twiml } from "twilio";

const { API_URL, API_SAVE_RECORDING_PATH } = process.env;

export function createCall<ProxyHandler>(
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
) {
  const call = new twiml.VoiceResponse();

  call.record({
    recordingStatusCallback: `${API_URL}${API_SAVE_RECORDING_PATH}`
  });

  call.hangup();

  return callback(null, {
    statusCode: 200,
    headers: { "Content-Type": "text/xml" },
    body: call.toString()
  });
}
