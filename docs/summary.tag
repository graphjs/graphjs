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
            <p>For more information, click on the links in the right-hand side menu.</p>
            <p style="display:none;">##### Add more text here...</p>
        </div>
        <!--Customization Block-->
        <div class="block" style="display:none;">
            <h2 id="customization-block">Customization</h2>
            <p>You can customize the main color and define light/dark theme as your preference. To do this, you need to modify <span class="code-block">GraphJS.init</span> function.</p>
            <p>##### Add more text here...</p>
        </div>
        <!--Test Block
        <div class="block">
            <h2 id="test-block">Test</h2>
            <p>This block is here to test several Graph.js components together.</p>
            <graphjs-auth></graphjs-auth>
            <graphjs-comments></graphjs-comments>
            <graphjs-forum></graphjs-forum>
            <graphjs-forum default="list"></graphjs-forum>
            <graphjs-forum default="thread" id="50a5a634eed9d6dad5f64daa3bef6587"></graphjs-forum>
            <graphjs-forum default="composer"></graphjs-forum>
            <graphjs-messages></graphjs-messages>
            <graphjs-profile default="activity" id="48760696099368953dd71a90b727acba"></graphjs-profile>
            <graphjs-profile default="followers" id="48760696099368953dd71a90b727acba"></graphjs-profile>
            <graphjs-profile default="following" id="48760696099368953dd71a90b727acba"></graphjs-profile>
            <graphjs-profile default="groups" id="48760696099368953dd71a90b727acba"></graphjs-profile>
            <graphjs-group default="members" id="33365d758357b6e724c360272ebf8895"></graphjs-group>
            <graphjs-star-list></graphjs-star-list>
            <graphjs-feedback></graphjs-feedback>
            <graphjs-list></graphjs-list>
        </div>
        -->
    </div>
    <script>
        import '../lib/tags/auth.tag';
        import '../lib/tags/comments.tag';
        import '../lib/tags/feedback.tag';
        import '../lib/tags/forum.tag';
        import '../lib/tags/group.tag';
        import '../lib/tags/list.tag';
        import '../lib/tags/messages.tag';
        import '../lib/tags/profile.tag';
        import '../lib/tags/star-list.tag';
    </script>
    <style type="less">
        @import '../lib/styles/variables.less';
        @import '../lib/styles/mixins.less';
        @import '../lib/styles/options.less';
        .summary {
            letter-spacing: 0;
            .block {
                margin-bottom: 2.5em;
                & > p {
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
