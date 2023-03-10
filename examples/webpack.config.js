const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { ModuleFederationPlugin } = require("webpack").container;
module.exports = {
  entry: "./src/index.ts",
  mode: "development",
  output: {
    filename: "index.js",
    libraryTarget: "umd",
    path: path.resolve(__dirname, "dist"),
  },
  /**
   * This external config, causes more headache for some reason.
   */
  // externals: {
  //   react: "react amd",
  //   "React-DOM": "ReactDOM amd",
  // },
  devtool: "source-map",
  module: {
    rules: [
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /node_modules\/vfile\/core\.js/,
        use: [
          {
            loader: "imports-loader",
            options: {
              type: "commonjs",
              imports: ["single process/browser process"],
            },
          },
        ],
      },
      {
        test: /\.(png|jpe?g|gif)$/i,
        use: [
          {
            loader: "file-loader",
          },
        ],
      },
      {
        test: /\.(ts|js)x?$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: [
              "@babel/preset-env",
              "@babel/preset-react",
              "@babel/preset-typescript",
            ],
          },
        },
      },
      {
        test: /\.(ts|js)x?$/,
        exclude: /node_modules/,
        use: ["ts-loader"],
      },
    ],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, "dist", "index.html"),
    },
    historyApiFallback: true,
    compress: true,
    port: 3001,
    host: "0.0.0.0",
    allowedHosts: "all",
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: `${__dirname}/public/index.html`,
      filename: "./index.html",
      contentBase: path.join(__dirname, "dist"),
    }),
    new ModuleFederationPlugin({
      shared: {
        // adds react as shared module
        react: {
          requiredVersion: "react",
          singleton: true,
          eager: true,
        },
      },
    }),
  ],
  resolve: {
    extensions: [".js", ".ts", ".jsx", ".tsx"],
    alias: {
      "@core/auth-provider-router": path.resolve(
        __dirname,
        "../packages/@core/auth-provider-router"
      ),
    },
  },
};
