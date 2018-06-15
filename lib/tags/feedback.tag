<graphjs-feedback class={'graphjs-root' + (opts.type == 'inline' ? ' graphjs-inline' : ' graphjs-box')} style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Feedback'}</div>
    </div>
    <div class="graphjs-content" ref="scrollingContent">
        <div class="graphjs-synopsis" if={feedbacks.length <= 0}>
            No feedback yet. Be the first person to leave feedback!
        </div>
        <div each={feedback in feedbacks} data-id={feedback} class="graphjs-item" if={feedbacks}>
            <img class="graphjs-author" src={downsizeImage(authorsData[feedbacksData[feedback].author].avatar, 50) || 'lib/images/avatars/user.png'} if={authorsData.hasOwnProperty(feedbacksData[feedback].author)} />
            <div class="graphjs-memo">
                <span class="graphjs-rating">
                     <svg each={item, index in Array(5)} viewBox="0 -4 80 80">
                         <path fill={index < feedbacksData[feedback].rating ? 'rgb(239, 191, 23)' : 'rgb(175, 175, 175)'} d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                     </svg>
                </span>
                <p>{feedbacksData[feedback].content}</p>
                <b>{authorsData[feedbacksData[feedback].author].username}</b>
            </div>
        </div>
        <div class={'graphjs-item graphjs-feedback'}>
            <img class="graphjs-author" src={profile ? downsizeImage(profile.avatar, 50) : 'lib/images/avatars/user.png'} />
            <div class={'graphjs-memo' + (userId ? '' : ' graphjs-loading graphjs-blocked')}>
                <fieldset class="rating">
                	<input id="rate-5" type="radio" name="rating" value={5}>
                	<label for="rate-5">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-4" type="radio" name="rating" value={4}>
                	<label for="rate-4">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-3" type="radio" name="rating" value={3}>
                	<label for="rate-3">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-2" type="radio" name="rating" value={2}>
                	<label for="rate-2">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-1" type="radio" name="rating" value={1}>
                	<label for="rate-1">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                </fieldset>
                <textarea ref="composer" placeholder="Write your own feedback here..."></textarea>
                <a ref="submit" onclick={handleFeedback}>Send Feedback</a>
                <div if={!loaded && !blocked} class="graphjs-inline graphjs-loader">
                    <div class="graphjs-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <button if={blocked} onclick={handleBlock} class="graphjs-blockage">Login to leave feedback</button>
            </div>
        </div>
    </div>
    <a class="graphjs-promo graphjs-top graphjs-right" href="http://graphjs.com" target="_blank">
        <svg viewBox="0 0 200 76" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g transform="translate(-620.000000, -18.000000)">
                <path fill="white" d="M674.455446,35.7851486 C670.318365,35.8917598 667.03137,36.6380379 667.03137,41.2223178 L667.03137,57.4805195 L657.623762,57.4805195 L657.623762,27.8959229 L666.464646,27.8959229 L666.464646,31.0409521 L666.577991,31.0409521 C668.221489,28.0025341 670.828416,26.8831169 674.455446,26.8831169 L674.455446,35.7851486 Z M708.118812,57.4555529 L698.942919,57.4555529 L698.942919,54.2598279 L698.832366,54.2598279 C697.174072,57.2957666 693.194167,58.4675325 689.877579,58.4675325 C680.425304,58.4675325 674.455446,51.4369374 674.455446,42.6486936 C674.455446,34.0202361 680.646409,26.8831169 689.877579,26.8831169 C693.249443,26.8831169 697.008243,28.1081448 698.832366,31.0375594 L698.942919,31.0375594 L698.942919,27.8950965 L708.118812,27.8950965 L708.118812,57.4555529 Z M699.207921,42.1556606 C699.207921,37.9181313 696.044608,34.7792208 691.701755,34.7792208 C687.358902,34.7792208 684.356436,38.127392 684.356436,42.2602909 C684.356436,46.2885595 687.573364,49.5844156 691.75537,49.5844156 C696.098224,49.5844156 699.207921,46.3408747 699.207921,42.1556606 Z M746.732673,42.9848228 C746.732673,51.2489434 740.703414,58.5000428 731.659524,58.5000428 C727.974977,58.5000428 724.848694,57.4337046 722.336502,54.8211762 L722.336502,67.3506494 L713.069307,67.3506494 L713.069307,27.8961381 L721.778238,27.8961381 L721.778238,31.1484694 L721.945717,31.1484694 C724.346256,28.2693565 727.807497,26.8831169 731.603698,26.8831169 C741.205852,26.8831169 746.732673,34.4008008 746.732673,42.9848228 Z M736.831683,42.2079758 C736.831683,38.0750769 733.46962,34.7792208 728.910891,34.7792208 C724.352162,34.7792208 720.990099,38.0750769 720.990099,42.2079758 C720.990099,46.2885595 724.409146,49.5844156 728.910891,49.5844156 C733.412636,49.5844156 736.831683,46.2885595 736.831683,42.2079758 Z M777.425743,57.4805195 L768.152664,57.4805195 L768.152664,41.3681994 C768.152664,38.1670762 767.203019,35.1793612 763.180993,35.1793612 C759.158967,35.1793612 757.985876,37.6869077 757.985876,41.048087 L757.985876,57.4805195 L748.712871,57.4805195 L748.712871,18 L757.985876,18 L757.985876,30.5910846 L758.097599,30.5910846 C759.717582,27.8167778 762.957547,26.8564409 766.08579,26.8564409 C769.102309,26.8564409 772.509859,27.8701299 774.520872,30.1109161 C777.48153,33.3653914 777.425669,36.8866269 777.425669,40.9413829 L777.425743,57.4805195 Z M781.386139,58.4675325 L781.386139,54.5194805 L785.346535,54.5194805 L785.346535,58.4675325 L781.386139,58.4675325 Z M784.536438,67.3506494 C783.67726,67.3506494 786.268605,67.3506494 784.523089,67.3506494 L784.523089,64.7049266 C786.093872,64.7049266 783.861369,64.7049266 784.536438,64.7049266 C786.745755,64.7049266 788.280003,63.3219351 788.280003,60.4356921 L788.280003,26.8831169 L791.287129,26.8831169 L791.287129,60.2553019 C791.287129,65.065707 788.586853,67.3506494 784.536438,67.3506494 Z M788.316832,23.9220779 L788.316832,18 L791.287129,18 L791.287129,23.9220779 L788.316832,23.9220779 Z M809.137199,58.4675325 C804.569886,58.4675325 799.570528,56.6238667 796.237624,53.9198236 L798.027517,51.5230581 C801.483863,54.1656457 805.310531,55.6405783 809.322361,55.6405783 C813.581072,55.6405783 816.913977,53.3052683 816.913977,49.6793923 L816.913977,49.5564813 C816.913977,45.8691497 812.963868,44.5171282 808.581715,43.2880176 C803.458917,41.813085 797.780635,40.2766969 797.780635,34.6842441 L797.780635,34.561333 C797.780635,29.5219799 802.039347,25.8961039 808.149672,25.8961039 C811.91462,25.8961039 816.173332,27.2481255 819.321075,29.3376133 L817.716343,31.8572899 C814.815482,29.9521686 811.359136,28.7230581 808.026231,28.7230581 C803.705799,28.7230581 800.866658,31.058368 800.866658,34.1925999 L800.866658,34.3155109 C800.866658,37.8184759 805.12537,39.1090419 809.630963,40.3996079 C814.692041,41.813085 820,43.6567508 820,49.1877481 L820,49.3106592 C820,54.903112 815.185804,58.4675325 809.137199,58.4675325 Z M644.223506,27.5368478 L649.921683,21.9480519 L656.12137,28.0287315 L650.410346,33.6301281 C653.873285,39.6947521 652.97562,47.5094104 647.71735,52.6667441 C646.76394,53.601852 645.72146,54.3963545 644.616695,55.0502516 L646.554631,62.1438924 C653.64101,62.234779 660.092324,66.9045865 662.016984,73.9496353 C664.337851,82.4449639 659.197676,91.1771075 650.536082,93.453424 C641.874487,95.7297404 632.971443,90.6882349 630.650576,82.1929063 C628.719812,75.1255165 631.952703,67.8942312 638.080998,64.3523626 L636.162765,57.3308403 C632.032091,57.3125692 627.90717,55.7578705 624.755545,52.6667441 C618.414818,46.4477319 618.414818,36.364721 624.755545,30.1457088 C630.03049,24.9720204 638.031978,24.1024 644.223506,27.5368478 Z M648.15907,84.8628715 C652.119469,83.8049934 654.469746,79.7468828 653.408561,75.7988279 C652.347375,71.850773 648.276576,69.5078218 644.316177,70.5656999 C640.355778,71.6235781 638.005501,75.6816886 639.066687,79.6297435 C640.127873,83.5777984 644.198671,85.9207496 648.15907,84.8628715 Z M631.085841,46.429232 C633.985774,49.3201261 638.687494,49.3201261 641.587427,46.429232 C644.487359,43.5383379 644.487359,38.8512725 641.587427,35.9603784 C638.687494,33.0694843 633.985774,33.0694843 631.085841,35.9603784 C628.185908,38.8512725 628.185908,43.5383379 631.085841,46.429232 Z"></path>
            </g>
        </svg>
    </a>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/feedback.less';
        @prefix: graphjs;

        @{prefix}-feedback.@{prefix}-root {
            display: block;
            color: @text-color-normal;
            .@{prefix}-content {
                .@{prefix}-feedback {
                    display: inline-block;
                    width: 100%;
                    textarea {
                        width: 100%;
                        height: 7.5em;
                        &.@{prefix}-closed {
                            height: 0;
                            border: none;
                        }
                    }
                    button {
                        float: right;
                        width: auto;
                        margin-top: .5em;
                        margin-left: .5em;
                        font-size: .9em;
                    }
                    & + .@{prefix}-synopsis {
                        margin-top: 2.5em;
                    }
                }
                .@{prefix}-synopsis {
                    display: inline-block;
                    width: 100%;
                    margin-bottom: 1.25em;
                    button {
                        float: right;
                        width: auto;
                        font-size: .75em;
                    }
                }
                .@{prefix}-item {
                    margin-bottom: 1.25em;
                    .clearfix;
                    &:last-child {
                        margin-bottom: 0;
                    }
                    .@{prefix}-author {
                        float: left;
                        width: 3em;
                        height: 3em;
                        .border-radius(@border-radius-full);
                    }
                    .@{prefix}-memo {
                        float: left;
                        display: block;
                        position: relative;
                        width: calc(100% - 4em);
                        margin-left: 1em;
                        padding: 1em;
                        .border-radius(@border-radius-large);
                        border: 1px solid fade(@default-color, 3%);
                        background-color: white;
                        .box-shadow(e("0 0 15px 0 fade(black, 5%), 0 2px 1px 0px fade(black, 7.5%)"));
                        &::before {
                            content: "\0025C0";
                            position: absolute;
                            top: 1em;
                            left: calc(-1em * 2 /3);
                            color: white;
                            font-size: 1em;
                            text-shadow: -1px 0px 2px rgba(0, 0, 0, .15);
                        }
                        span {
                            display: block;
                            width: 100%;
                            height: 1em;
                            margin: 0;
                            margin-bottom: 1em;
                            padding: 0;
                            svg {
                                width: auto;
                                height: inherit;
                                vertical-align: top;
                            }
                        }
                        fieldset {
                            margin-bottom: 1em;
                        }
                        textarea {
                            height: auto;
                            margin: 0;
                            padding: 0;
                            border: none;
                        }
                        a {
                            margin-right: 1em;
                            .text-color-states(@text-color-normal);
                            .bold-font;
                            font-size: .9em;
                            text-transform: uppercase;
                            &:last-of-type {
                                margin-right: 0;
                            }
                            &.graphjs-danger {
                                .text-color-states(@danger-color);
                            }
                        }
                        p {
                            margin: 0;
                            font-size: 1em;
                            line-height: 150%;
                        }
                        b {
                            display: inline-block;
                            margin-top: .5em;
                            &::before {
                                content: "\2014";
                            }
                        }
                    }
                }
            }
        }
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getFeedback from '../scripts/getFeedback.js';
        import addFeedback from '../scripts/addFeedback.js';
        import removeFeedback from '../scripts/removeFeedback.js';
        import getProfile from '../scripts/getProfile.js';
        import showLogin from '../scripts/showLogin.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.feedbacks = [];
        this.feedbacksData = {};
        this.authorsData = {};

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
            //GraphJSCallbacks
            if(!window.GraphJSCallbacks) {
                window.GraphJSCallbacks = {};
            }
            let self = this;
            window.GraphJSCallbacks['updateFeedback'] = function() {
                self.blocked = false;
                self.update();
                self.handleUser();
            }
        });

        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                    self.handleInformation();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleInformation = () => {
            let self = this;
            self.userId && getProfile(self.userId, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    console.log(self.profile)
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleContent = (callback) => {
            let self = this;
            let url = window.location.href.replace(/\/$/, "");
            //getFeedback(url, function(response) {
                /*
                #
                #
                #
                */
                let response = {
                    "success":true,
                    "feedback":[
                        {
                            "9eee25f7881b4a3a83b54fcba0091260": {
                                "content": "The Mock Turtle's heavy sobs. Lastly, she pictured to herself how she was up to the game..",
                                "rating": 3,
                                "createTime": 1524747009,
                                "author": "40ba20f42c49d289bc30af768b965a91"
                            }
                        },
                        {
                            "96112c5a5f2ba385324e7dfd50ffa4d5": {
                                "content":"Caterpillar. Alice said to the jury, in a.",
                                "rating": 1,
                                "createTime": 1524747026,
                                "author": "48b7cac56b5993b12d17c71797dc0f48"
                            }
                        },
                        {
                            "910b5c87cfd9188c5953188b64125dfd": {
                                "content": "So she began again: 'Ou est ma chatte?' which was full of soup. 'There's.",
                                "rating": 2,
                                "createTime": 1524747053,
                                "author": "48b7f95e51fa1eeb4098f57cead68d74"
                            }
                        },
                        {
                            "95e8bcc4a9f100c3b385f39b234e47be": {
                                "content": "Alice. 'That's very.",
                                "rating": 4,
                                "createTime": 1524747100,
                                "author": "4a19102be3dc61b31ee2783c3a0698c2"
                            }
                        },
                        {
                            "990997c3e253ed270075da7644ab2a12": {
                                "content": "Yo!",
                                "rating": 5,
                                "createTime": 1525116051,
                                "author": "48760696099368953dd71a90b727acba"
                            }
                        },
                        {
                            "9624104a8aeac0bdfa49d6315ee7f355": {
                                "content": "This is a test comment.",
                                "rating": 2,
                                "createTime": 1525519888,
                                "author": "48760696099368953dd71a90b727acba"
                            }
                        }
                    ]
                };
                /*
                #
                #
                #
                */
                if(response.success) {
                    self.feedbacks = [];
                    for(let feedback of response.feedback) {
                        let key = Object.keys(feedback)[0];
                        self.feedbacks.push(key);
                        self.feedbacksData[key] = feedback[key];
                        callback && callback();
                        getProfile(feedback[key].author, function(response) {
                            if(response.success) {
                                self.authorsData[feedback[key].author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.loaded = true;
                    self.update();
                } else {
                    //Handle errors
                }
            //});
            self.update();
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateFeedback'
            });
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.composer.value = '';
            this.refs.composer.focus();
        }
        this.handleFeedback = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.add('graphjs-loading');
            let url = window.location.href.replace(/\/$/, "");
            addFeedback(url, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.refs.composer.value = '';
                    self.update();
                } else {
                    self.refs.submit.classList.remove('graphjs-loading');
                    //Handle error
                }
            });
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm('Are you sure to delete this item?')) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeFeedback(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
        }
    </script>
</graphjs-feedback>