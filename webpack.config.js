const path = require('path')
const webpack = require('webpack')

module.exports = {
    entry: './lib/app.js',
    output: {
        library: "Pho",
        libraryTarget: "window",
        filename: "pho.js",
        publicPath: "",
        auxiliaryComment: "Test Comment"
    },
    devtool: 'inline-source-map',
    module: {
        rules: [
            {
                test: /\.tag$/,
                exclude: /node_modules/,
                loader: 'riot-tag-loader',
                options: {
                    type: 'es6',
                    hot: true
                }
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader'
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
                test: /\.(png|woff|svg)$/,
                loader: 'url-loader?limit=100000'
            }
        ]
    }
}