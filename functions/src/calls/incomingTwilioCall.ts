import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

import { twiml } from "twilio";

export const incomingTwilioCall: ProxyHandler = (
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
) => {
  const call = new twiml.VoiceResponse();

  call.record({
    playBeep: false,
    recordingStatusCallback:
      "https://us-central1-cruhl-magic.cloudfunctions.net/recordCall"
  });

  call.hangup();

  const response = {
    statusCode: 200,
    headers: { "Content-Type": "text/xml" },
    body: call.toString()
  };

  callback(null, response);
};
