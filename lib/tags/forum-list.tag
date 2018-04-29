<graphjs-forum-list
    class={'root' + (opts.minor ? '' : ' box')}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="header">
        <div class="title">{opts.title || 'Community Forum'}</div>
    </div>
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <div class="bar">
            <div class="search">
                <div class="icon">
                    <svg viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" id="Shape" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000) "></path>

                        </g>
                    </svg>
                </div>
                <input onkeyup={handleFilter} type="text" placeholder="Search in posts..." />
            </div>
            <button data-link="compose" onclick={opts.minor ? handleCallback : handleShow}>
                <svg viewBox="0 0 21 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g transform="translate(-20.000000, -17.000000)" fill="black" fill-rule="nonzero">
                        <path d="M38.1489476,17 L22.6361271,17 C21.3968108,17 20.3925373,18.0239842 20.3925373,19.2876244 L20.3925373,30.4860904 C20.3925373,31.7497305 21.3968108,32.7737148 22.6361271,32.7737148 L24.7515117,32.7737148 L24.7515117,36.5428483 C24.7515117,36.9132256 25.1574946,37.1310946 25.4566399,36.9132256 L31.4609134,32.7737148 L38.1489476,32.7737148 C39.3882638,32.7737148 40.3925373,31.7497305 40.3925373,30.4860904 L40.3925373,19.2876244 C40.3925373,18.0239842 39.3882638,17 38.1489476,17 Z M31.2728027,25.8802653 L31.2728027,28.6472015 L29.1594735,28.6472015 L29.1594735,25.8802653 L26.3925373,25.8802653 L26.3925373,23.7669362 L29.1594735,23.7669362 L29.1594735,21 L31.2728027,21 L31.2728027,23.7669362 L34.0397388,23.7669362 L34.0397388,25.8802653 L31.2728027,25.8802653 Z"></path>
                    </g>
                </svg>
                <span>New Thread</span>
            </button>
        </div>
        <div class="list">
            <a each={matchedThread, index in matchedThreads} class="item" data-link="thread" data-id={matchedThread} onclick={opts.minor ? handleCallback : handleShow} if={matchedThreads.length > 0 && index + 1 >= parseInt(((page - 1) * pageLimit + 1), 10) && index + 1 <= Math.min(matchedThreads.length, parseInt(page * pageLimit, 10))}>
                <div class="title">
                    {threadsData[matchedThread] && threadsData[matchedThread].title}
                </div>
                <div class="views" if={threadsData[matchedThread].views}>
                    <svg viewBox="0 0 19 12" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(0.000000, -19.000000)" d="M18.5059451,24.5206612 C16.1180812,21.0826446 12.8730354,19 9.32185322,19 C5.77067104,19 2.52562526,21.1157025 0.137761378,24.5206612 C-0.0459204592,24.8181818 -0.0459204592,25.1818182 0.137761378,25.4793388 C2.52562526,28.9173554 5.77067104,31 9.32185322,31 C12.8730354,31 16.1180812,28.8842975 18.5059451,25.4793388 C18.7202405,25.1818182 18.7202405,24.785124 18.5059451,24.5206612 Z M13.2403991,25.2479339 C13.1179445,27.3636364 11.5260353,29.0826446 9.56676233,29.214876 C7.2095121,29.3801653 5.25023917,27.2644628 5.40330737,24.7190083 C5.52576192,22.6033058 7.11767118,20.8842975 9.0769441,20.7520661 C11.4341943,20.5867769 13.3934673,22.7024793 13.2403991,25.2479339 Z M11.4341943,25.1157025 C11.3729671,26.2396694 10.5157852,27.1652893 9.47492142,27.231405 C8.18914856,27.3305785 7.14828482,26.1735537 7.24012573,24.8181818 C7.30135301,23.6942149 8.15853492,22.768595 9.19939866,22.7024793 C10.4545579,22.6033058 11.5260353,23.7603306 11.4341943,25.1157025 Z"></path>
                    </svg>
                    {threadsData[matchedThread].views}
                </div>
                <time data-time={threadsData[matchedThread] && threadsData[matchedThread].timestamp}>
                    {threadsData[matchedThread] && handleTime(threadsData[matchedThread].timestamp)}
                </time>
                <div class="contributors" if={threadsData[matchedThread].contributors}>
                    <img each={contributor, index in threadsData[matchedThread].contributors} src={contributor.avatar || 'lib/images/avatars/user.png'} />
                </div>
            </a>
            <div class="placeholder item" if={matchedThreads.length <= 0}>
                There isn't any thread available.
            </div>
        </div>
        <div class="controls" if={matchedThreads.length > pageLimit}>
            <a class={page == 1 ? 'disabled' : ''} data-target="first" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-316.000000, -236.000000)" d="M320.8,294.640939 L321.4,294.640939 C324,294.640939 326.1,292.540939 326.1,289.940939 L326.1,270.140939 L367.6,294.040939 C370.7,295.840939 374.6,293.640939 374.6,290.040939 L374.6,240.640939 C374.6,237.040939 370.7,234.840939 367.6,236.640939 L326,260.540939 L326,240.740939 C326,238.140939 323.9,236.040939 321.3,236.040939 L320.7,236.040939 C318.1,236.040939 316,238.140939 316,240.740939 L316,290.040939 C316.1,292.540939 318.2,294.640939 320.8,294.640939 Z"></path>
                </svg>
            </a>
            <a class={page == 1 ? 'disabled' : ''} data-target="previous" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-288.000000, -111.000000)" d="M289.5,139.023766 L337.3,111.423766 C339.3,110.223766 341.8,111.723766 341.8,114.023766 L341.8,169.223766 C341.8,171.523766 339.3,173.023766 337.3,171.823766 L289.5,144.223766 C287.5,143.023766 287.5,140.223766 289.5,139.023766 Z"></path>
                </svg>
            </a>
            <p>{'Displaying ' + parseInt(((page - 1) * pageLimit + 1), 10) + '-' + Math.min(matchedThreads.length, parseInt(page * pageLimit, 10)) + ' of ' + matchedThreads.length}</p>
            <a class={page == Math.ceil(matchedThreads.length / pageLimit) ? 'disabled' : ''} data-target="next" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-218.000000, -205.000000)" d="M270.5,238.223766 L222.7,265.823766 C220.7,267.023766 218.2,265.523766 218.2,263.223766 L218.2,208.023766 C218.2,205.723766 220.7,204.223766 222.7,205.423766 L270.5,233.023766 C272.5,234.223766 272.5,237.023766 270.5,238.223766 Z"></path>
                </svg>
            </a>
            <a class={page == Math.ceil(matchedThreads.length / pageLimit) ? 'disabled' : ''} data-target="last" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-172.000000, 0.000000)" d="M225.7,0.140939378 L225.1,0.140939378 C222.5,0.140939378 220.4,2.24093938 220.4,4.84093938 L220.4,24.6409394 L179,0.640939378 C175.9,-1.15906062 172,1.04093938 172,4.64093938 L172,54.1409394 C172,57.7409394 175.9,59.9409394 179,58.1409394 L220.5,34.2409394 L220.5,54.0409394 C220.5,56.6409394 222.6,58.7409394 225.2,58.7409394 L225.8,58.7409394 C228.4,58.7409394 230.5,56.6409394 230.5,54.0409394 L230.5,4.84093938 C230.4,2.24093938 228.3,0.140939378 225.7,0.140939378 Z"></path>
                </svg>
            </a>
        </div>
        <div if={!loaded} class="placeholder loader">
            <div class="bar rectangle fill"></div>
            <div class="list">
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="title line fill"></div>
                    <div class="time line fill"></div>
                    <div class="contributors">
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                        <div class="avatar circle fill"></div>
                    </div>
                </div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to display forum</button>
    </div>
    <a class="bottom promo" href="http://graphjs.com">
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
        @import '../styles/components/forum-list.less';
        .controls {
            width: 100%;
            height: 3em;
            padding: .5em;
            color: @text-color-strong;
            line-height: 2em;
            text-align: center;
            vertical-align: middle;
            background-color: fade(@secondary-color, 10%);
            .disable-selection;
            & > * {
                .disable-selection;
            }
            a {
                display: inline-block;
                opacity: .65;
                width: auto;
                height: 2em;
                padding: 0 .35em;
                font-size: 1em;
                text-align: center;
                vertical-align: middle;
                .transition(opacity .35s ease);
                &:hover {
                    opacity: 1;
                }
                &.disabled {
                    opacity: .35;
                    pointer-events: none;
                }
                svg {
                    height: .8em;
                    vertical-align: middle;
                    path {
                        fill: @text-color-strong;
                    }
                }
            }
            p {
                display: inline-block;
                opacity: .65;
                padding: 0 .65em;
                font-size: .9em;
                line-height: inherit;
            }
        }
    </style>
    <script>
        import getUser from '../scripts/getUser.js';
        import getThreads from '../scripts/getThreads.js';
        import showForumCompose from '../scripts/showForumCompose.js';
        import showForumThread from '../scripts/showForumThread.js';
        import showLogin from '../scripts/showLogin.js';

        this.blocked = false;
        this.access = opts.access || 'public';
        this.page = 1;
        this.pageLimit = opts.pageLimit || 10;
        this.threads = [];
        this.threadsData = {};
        this.matchedThreads = [];

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
        });

        this.handleUser = () => {
            let self = this;
            getUser(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                } else {
                    if(self.access != 'private') {
                    } else {
                        self.loaded = false;
                        self.blocked = true;
                    }
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.handleContent = () => {
            let self = this;
            getThreads(function(response) {
                if(response.success) {
                    for(let thread of response.threads) {
                        self.threads.push(thread.id);
                        self.threadsData[thread.id] = {
                            id: thread.id,
                            title: thread.title,
                            author: thread.author,
                            timestamp: thread.timestamp
                        }
                        let contributors = typeof(thread.contributors) == 'object' ? thread.contributors : {};
                        let limit = 5;
                        let count = Math.min(Object.keys(contributors).length, limit);
                        self.threadsData[thread.id]['contributors'] = {};
                        for(let i = 0; i < count; i++) {
                            let key = Object.keys(contributors)[i];
                            self.threadsData[thread.id].contributors[i] = contributors[key];
                        }
                    }
                    self.matchedThreads = self.threads;
                    self.loaded = true;
                    self.update();
                } else {
                    self.loaded = false;
                    //Handle error
                }
            });
        }
        this.handleCallback = (properties) => {
            if(properties.target) {
                properties.preventDefault();
                let dataset = Object.assign({}, properties.currentTarget.dataset);
                opts.callback(dataset);
            } else {
                opts.callback(properties);
            }
        }
        this.handleShow = (event) => {
            event.preventDefault();
            let dataset = event.currentTarget.dataset;
            switch(dataset.link) {
                case 'compose':
                    showForumCompose({
                        scroll: true
                    });
                    break;
                case 'thread':
                    showForumThread({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleFilter = (event) => {
            let self = this;
            self.matchedThreads = self.threads.filter(item => self.threadsData[item].title.toLowerCase().startsWith(event.target.value.toLowerCase()));
        }
        this.handlePagination = (event) => {
            let self = this;
            let target = event.target.dataset.target;
            let lastPage = Math.ceil(self.matchedThreads.length / self.pageLimit);
            switch(target) {
                case 'first':
                    self.page = 1;
                    break;
                case 'previous':
                    self.page = self.page == 1 ? 1 : self.page - 1;
                    break;
                case 'next':
                    self.page = self.page == lastPage ? lastPage : self.page + 1;
                    break;
                case 'last':
                    self.page = lastPage;
                    break;
            }
        }
        this.handleTime = (timestamp) => {
            let time = timestamp * 1000;
            let passedTime = Math.floor((Date.now() - time) / 1000);
            let date = new Date(time);
            if(passedTime < 60 * 60 * 24) {
                return date.getHours() + ':' + ((date.getMinutes() < 10 ? '0' : '') + date.getMinutes());
            } else if(passedTime >= 60 * 60 * 24 && passedTime < 60 * 60 * 24 * 365) {
                return this.months[date.getMonth()].substring(0, 3) + ', ' + date.getDate();
            } else {
                return this.months[date.getMonth()].substring(0, 3) + ' \'' + date.getFullYear().toString().substring(2, 4);
            }
        }
        this.months = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
        ];
    </script>
</graphjs-forum-list>