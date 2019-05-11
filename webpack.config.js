const path = require('path');
const webpack = require('webpack');
const CompressionPlugin = require("compression-webpack-plugin");
const TerserPlugin = require('terser-webpack-plugin')
const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");

const mode = process.env.NODE_ENV || 'development';

const SpeedMeasure = new SpeedMeasurePlugin({
    disabled: mode === 'production'
});

module.exports = SpeedMeasure.wrap({
    mode,
    entry: {
        graph: './lib/app.js'
    },
    output: {
        path: __dirname + "/dist",
        filename: "[name].js",
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
                test: /\.css$/,
                use: [
                    {
                        loader: "style-loader"
                    }, {
                        loader: "css-loader"
                    }]
            },
            {
                test: /\.(jpg|png|gif|woff|svg)$/,
                use: 'url-loader?limit=100000'
            }
        ]
    },
    plugins: [
        new webpack.optimize.AggressiveMergingPlugin(),
        new CompressionPlugin({
            algorithm: 'gzip'
        }),
        /*new webpack.DefinePlugin({
            'process.env.modules': JSON.stringify(process.env.modules)
        })*/
    ],
    optimization: {
        nodeEnv: mode,
        minimizer: [
            new TerserPlugin({
                terserOptions: {
                    parallel: true,
                    warnings: false,
                    output: {
                        comments: false
                    },
                },
            })
        ]
    },
    watchOptions: {
        ignored: /node_modules/
    },
    devServer: {
        host: 'localhost',
        port: 8080,
        publicPath: '/',
        contentBase: './',
        hot: false,
        inline: false,
        progress: false,
        open: true,
        openPage: '../test'
    },
    /*watch: true*/
})