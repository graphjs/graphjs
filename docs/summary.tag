<docs-summary>
    <h1>{opts.label}</h1>
    <div class="summary">
        <!--Introduction Block-->
        <div class="block">
            <h2 id="introduction-block">Introduction</h2>
            <p>Graph.js is a Javascript client-side library to help developers easily enable social features on their web sites. GraphJS is built upon the Pho framework, and it's open source. With only a few lines of code, you can easily add authentication, comments, messages, forum, groups, profiles etc. to your static web pages.</p>
        </div>
        <!--Getting Started Block-->
        <div class="block">
            <h2 id="gettingstarted-block">Getting Started</h2>
            <p>
                To get started with Graph.js, you need to include <span class="code-block">graph.js</span> file to your project. Then you can initiate it with <span class="code-block">GraphJS.init</span> function.
            </p>
            <div class="code-block">GraphJS.init("YOUR_PUBLIC_ID_GOES_HERE");</div>
        </div>
        <!--Usage Block-->
        <div class="block">
            <h2 id="usage-block">Usage</h2>
            <p>Building a social web site is very easy.</p>
            <p>##### Add more text here...</p>
        </div>
        <!--Customization Block-->
        <div class="block">
            <h2 id="customization-block">Customization</h2>
            <p>You can customize the main color and define light/dark theme as your preference. To do this, you need to modify <span class="code-block">GraphJS.init</span> function.</p>
            <p>##### Add more text here...</p>
        </div>
        <!--Credits Block-->
        <div class="block">
            <h2 id="credits-block">Credits</h2>
            <p>© Copyright 2018
                <a href="https://groups-inc.com" target="_blank">GROU.PS Inc.</a>, All rights reserved.</p>
            <p>Kudos to
                <a href="http://emresokullu.com" target="_blank">Emre Sokullu</a>,
                <a href="https://ozanilbey.com" target="_blank">Ozan Ilbey Yilmaz</a>
            </p>
        </div>
    </div>
    <style type="less">
        @import '../lib/styles/variables.less';
        @import '../lib/styles/mixins.less';
        @import '../lib/styles/options.less';
        .summary {
            letter-spacing: 0;
            .block {
                margin-bottom: 2.5em;
                p {
                    font-size: 1.1em;
                    line-height: 165%;
                }
                .code-block {
                    padding: .35em .65em;
                    color: white;
                    .border-radius(@border-radius-small);
                    background-color: rgb(93, 60, 246);
                    .box-shadow(0 0 15px 0 fade(black, 5%));
                    word-wrap: break-word;
                    white-space: pre-wrap;
                }
                div.code-block {
                    margin: 1em 0;
                    padding: 1em 1.5em;
                    color: @text-color-normal;
                    font-size: 1.1em;
                    line-height: 150%;
                    background-color: white;
                }
            }
        }
    </style>
</docs-summary>
