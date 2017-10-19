import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

import { twiml } from "twilio";

export function incomingTwilioCall<ProxyHandler>(
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
) {
  const call = new twiml.VoiceResponse();

  const { API_URL, SAVE_RECORDING_PATH } = process.env;

  call.record({
    playBeep: false,
    recordingStatusCallback: `${API_URL}${SAVE_RECORDING_PATH}`
  });

  call.hangup();

  return callback(null, {
    statusCode: 200,
    headers: { "Content-Type": "text/xml" },
    body: call.toString()
  });
}
