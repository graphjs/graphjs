<graphjs-comments class="graphjs-element graphjs-root graphjs-box" style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Comments'}</div>
    </div>
    <div class="graphjs-content" ref="scrollingContent">
        <div class="graphjs-synopsis" if={comments.length <= 0}>
            {i18n.noCommentsMessageText}
        </div>
        <div class={'graphjs-comment' + (blocked ? ' graphjs-loading graphjs-blocked' : '')}>
            <textarea ref="composer" placeholder={i18n.commentsInputPlaceholder}></textarea>
            <button ref="submit" onclick={handleComment}>{i18n.submitButtonText}</button>
            <button hide={true} onclick={handleClear} class="graphjs-danger">{i18n.clearButtonText}</button>
            <div if={!loaded && !blocked} class="graphjs-inline graphjs-loader">
                <div class="graphjs-dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
        </div>
        <div class="graphjs-synopsis"if={comments.length > 0}>
            {commentCountText.replace('%s',comments.length)}
        </div>
        <div each={comment in comments} data-id={comment} class="graphjs-item">
            <div class="graphjs-credit" if={authorsData.hasOwnProperty(commentsData[comment].author)}>
                <img data-link="profile" data-id={commentsData[comment].author} onclick={handleShow} src={authorsData[commentsData[comment].author].avatar ? downsizeImage(authorsData[commentsData[comment].author].avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                <span>
                    <b data-link="profile" data-id={commentsData[comment].author} onclick={handleShow}>{authorsData[commentsData[comment].author].username || i18n.unknowUserText}</b>
                    <time data-timestamp={commentsData[comment].createTime}>{handleTime(commentsData[comment].createTime)}</time>
                    <a hide={true} if={commentsData[comment].author == userId} onclick={handleEdit} data-id={comment}>{i18n.commentEditButtonText}</a>
                    <a if={commentsData[comment].author == userId} onclick={handleRemove} data-id={comment}>{i18n.commentDeleteButtonText}</a>
                </span>
            </div>
            <p>{commentsData[comment].content}</p>
        </div>
    </div>
    <a class="graphjs-promo graphjs-top graphjs-right" href="https://graphjs.com" target="_blank">
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
        @import '../styles/components/comments.less';
    </style>
    <script>
        import analytics from '../scripts/analytics.js';    
        import getSession from '../scripts/getSession.js';
        import getComments from '../scripts/getComments.js';
        import addComment from '../scripts/addComment.js';
        import editComment from '../scripts/editComment.js';
        import removeComment from '../scripts/removeComment.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("comments");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['comments'];
        i18n = {...i18n,...opts}
        this.i18n = i18n;
        
        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.page = opts.page ? parseInt(opts.page) : 1;
        this.pageLimit = opts.limit ? parseInt(opts.limit) : 10;
        this.comments = [];
        this.commentsData = {};
        this.authorsData = {};

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
            this.frequentlyUpdateTime = setInterval(this.handleTimeUpdate,  60 * 1000);
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });

        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser();
        }
        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleContent = (callback) => {
            let self = this;
            let url = window.location.href.replace(/\/$/, "");
            getComments(url, function(response) {
                if(response.success) {
                    self.comments = [];
                    for(let comment of response.comments) {
                        let key = Object.keys(comment)[0];
                        self.comments.push(key);
                        self.commentsData[key] = comment[key];
                        callback && callback();
                        getProfile(comment[key].author, function(response) {
                            if(response.success) {
                                self.authorsData[comment[key].author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.loaded = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
            self.update();
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateComments'
            });
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.composer.value = '';
            this.refs.composer.focus();
        }
        this.handleComment = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.add('graphjs-loading');
            let url = window.location.href.replace(/\/$/, "");
            addComment(url, self.refs.composer.value, function(response) {
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
        this.handleEdit = (event) => {
            event.preventDefault();
            let textBox = event.target.parentNode.parentNode.nextElementSibling;
            let currentText = textBox.innerText;
            if(textBox.hasAttribute('contenteditable')) {
                textBox.removeAttribute('contenteditable');
                textBox.classList.remove('graphjs-editable');
                event.target.innerText = i18n.commentEditButtonText;
                if(textBox.innerText != '') {
                    editComment(event.target.dataset.id, textBox.innerText, function(response) {
                        if(response.success) {
                            self.handleContent();
                        } else {
                            //Handle error
                        }
                    });
                }
            } else {
                textBox.contentEditable = true;
                textBox.focus();
                event.target.innerText = i18n.commentSaveButtonText;
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(i18n.commentDeleteConfirmationText)) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeComment(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
        }
        this.handleShow = (event) => {
            let self = this;
            let dataset = event.target.dataset;
            switch(dataset.link) {
                case 'profile':
                    showProfile({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        /*
        this.handleTime = (timestamp) => {
            let date = new Date(parseInt(timestamp) * 1000);
            let day = date.getDate();
            let month = this.months[date.getMonth()];
            let year = date.getFullYear();
            let hour = date.getHours();
            let minute = date.getMinutes();
            return month + ' ' + day + ', ' + year + ' · ' + hour + ':' + minute;
        }
        */
        this.handleTimeUpdate = () => {
            let items = document.querySelectorAll('graphjs-comments time');
            for(let item of items) {
                if(item.dataset.hasOwnProperty('timestamp')) {
                    let timestamp = item.dataset.timestamp;
                    item.innerHTML = this.handleTime(timestamp);
                }
            }
        }
        this.handleTime = (timestamp) => {
            let text;
            let time = Math.floor((Date.now() - (parseInt(timestamp) * 1000)) / 1000);
            let amount;
            if(time < 1) {
                amount = time;
                text = i18n.commentTimeNowText;
            } else if(1 <= time && time < 60) {
                amount = time;
                text = i18n.commentTimeSecondsText.replace('%s',amount);
            } else if(60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = i18n.commentTimeMinutesText.replace('%s',amount);
            } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = i18n.commentTimeHoursText.replace('%s',amount);
            } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = i18n.commentTimeDaysText.replace('%s',amount);
            } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = i18n.commentTimeWeeksText.replace('%s',amount);
            } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = i18n.commentTimeMonthsText.replace('%s',amount);
            } else if(time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = i18n.commentTimeYearsText.replace('%s',amount);
            } else {
                //Handle errors
            }
            return text;
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
</graphjs-comments>
