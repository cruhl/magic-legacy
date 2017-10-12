import * as aws from "aws-sdk";
import { Handler, APIGatewayEvent, Context, Callback } from "aws-lambda";

aws.APIGateway.Types;

export const generateTwiml: Handler = (
  event: APIGatewayEvent,
  context: Context,
  callback: Callback
) => {
  const response = {
    statusCode: 200,
    contentType: "application/json",
    body: JSON.stringify({ message: "Success!" })
  };

  callback(null, response);
};
