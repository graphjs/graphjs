const path = require('path');
const webpack = require('webpack');
const CompressionPlugin = require("compression-webpack-plugin");
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');

module.exports = {
    entry: './lib/app.js',
    output: {
        library: "GraphJS",
        libraryTarget: "window",
        filename: "dist/graph.js",
        publicPath: "",
        auxiliaryComment: "Test Comment"
    },
    devtool: 'inline-source-map',
    module: {
        rules: [
            {
                test: /\.tag$/,
                exclude: /node_modules/,
                use: {
                    loader: 'riot-tag-loader',
                    options: {
                        type: 'es6',
                        hot: true,
                        sourcemap: true
                    }
                }
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: 'babel-loader'
            },
            {
                test: /\.less$/,
                use: [
                    {
                        loader: "style-loader"
                    }, {
                        loader: "css-loader"
                    }, {
                        loader: "less-loader"
                    }
                ]
            },
            {
                test: /\.(jpg|png|gif|woff|svg)$/,
                use: 'url-loader?limit=100000'
            }
        ]
    },
    plugins: [
        new UglifyJsPlugin(),
        //new webpack.optimize.AggressiveMergingPlugin(),
        new CompressionPlugin({
            algorithm: 'gzip'
        })
    ],
    node: {
        fs: "empty"
    }
}