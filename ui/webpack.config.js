const path = require("path");

module.exports = {
  entry: {
    app: ["./src/index.js"]
  },

  output: {
    path: path.resolve(`${__dirname}/build`),
    filename: "[name].js"
  },

  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: "elm-webpack?verbose=true&warn=true"
        // loader: "elm-webpack?verbose=true&warn=true&debug=true"
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: "file?name=[name].[ext]"
      },
      {
        test: /\.(css|scss)$/,
        loaders: ["style", "css", "sass"]
      },
      {
        test: /\.json$/,
        loaders: ["json-loader"]
      }
    ],

    noParse: /\.elm$/
  },

  devServer: {
    inline: true,
    stats: {
      colors: true
    }
  }
};
