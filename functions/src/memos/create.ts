import { Handler, S3EventRecord, Context, Callback } from "aws-lambda";

export function createMemo<Handler>(
  event: S3EventRecord,
  context: Context,
  callback: Callback
) {
  return callback(null);
}
