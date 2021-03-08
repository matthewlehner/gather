const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");

const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = (env, options) => {
  const devMode = options.mode !== "production";

  return {
    optimization: {
      minimizer: ["...", new CssMinimizerPlugin()],
    },
    entry: {
      app: ["./js/app.js"],
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "../priv/static/js"),
      publicPath: "/js/",
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: require.resolve("babel-loader"),
          },
        },
        {
          test: /\.css$/,
          use: [
            MiniCssExtractPlugin.loader,
            require.resolve("css-loader"),
            require.resolve("postcss-loader"),
          ],
        },
      ],
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin({ patterns: [{ from: "static/", to: "../" }] }),
    ],
  };
};
