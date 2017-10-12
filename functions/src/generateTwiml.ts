import {
  ProxyHandler,
  APIGatewayEvent,
  Context,
  ProxyCallback
} from "aws-lambda";

export const generateTwiml: ProxyHandler = (
  event: APIGatewayEvent,
  context: Context,
  callback: ProxyCallback
) => {
  console.log("w");
  const response = {
    statusCode: 200,
    headers: { contentType: "application/json" },
    body: JSON.stringify({ message: "Success!" })
  };

  callback(null, response);
};
