const path = require("path");

module.exports = {
  entry: "./src/index.ts",
  target: "node",
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"]
  },
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "build"),
    library: "index",
    libraryTarget: "commonjs2"
  },
  devServer: {
    inline: true,
    stats: {
      colors: true
    }
  }
};
