const path = require("path");

const { FUNCTION } = process.env;

if (!FUNCTION) {
  throw new Error(
    'The function name (i.e. createCall) must be passed in via an environment variable named "FUNCTION"!'
  );
}

module.exports = {
  entry: `./${FUNCTION}/src/index.ts`,
  target: "node",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        exclude: /node_modules/,
        use: [
          {
            loader: "ts-loader",
            options: {
              configFile: path.resolve(__dirname, `${FUNCTION}/tsconfig.json`),
              onlyCompileBundledFiles: true
            }
          }
        ]
      }
    ]
  },
  resolve: {
    extensions: [".ts", ".js"]
  },
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, `${FUNCTION}/build`),
    libraryTarget: "commonjs"
  }
};
