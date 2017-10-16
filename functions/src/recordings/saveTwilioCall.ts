import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

export const saveTwilioCall: ProxyHandler = (
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify({ message: "Recording saved!" })
  };

  callback(null, response);
};
