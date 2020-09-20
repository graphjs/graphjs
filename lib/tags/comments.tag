<graphjs-comments
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Comments'}</div>
    </div>
    <div class="graphjs-content" ref="scrollingContent">
        <div class="graphjs-synopsis" if={comments.length <= 0}>
            {language.noCommentsMessage}
        </div>
        <div class={'graphjs-comment' + (blocked ? ' graphjs-loading graphjs-blocked' : '')}>
            <textarea ref="composer" placeholder={language.commentsInputPlaceholder}></textarea>
            <button ref="submit" onclick={handleComment}>{language.submitButton}</button>
            <button hide={true} onclick={handleClear} class="graphjs-danger">{language.clearButton}</button>
            <div if={!loaded && !blocked} class="graphjs-loader">
                <div class="graphjs-dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
            <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{language.loginButton}</button>
        </div>
        <div class="graphjs-synopsis" ref="counter" if={comments.length > 0}>
            {language.commentCount.replace('%s',commentCount)}
        </div>
        <div each={comment in comments} data-id={comment} class="graphjs-item">
            <div class="graphjs-credit" if={authorsData.hasOwnProperty(commentsData[comment].author)}>
                <img data-link="profile" data-id={commentsData[comment].author} onclick={handleShow} src={authorsData[commentsData[comment].author].avatar ? downsizeImage(authorsData[commentsData[comment].author].avatar, 50) : (defaultAvatar == "gravatar" ? gravatar.url(authorsData[commentsData[comment].author].email, {s: '50', d: 'retro'}, true) : defaultAvatar)} />
                <span>
                    <b data-link="profile" data-id={commentsData[comment].author} onclick={handleShow}>{authorsData[commentsData[comment].author].username || language.unknowUser}</b>
                    <time data-timestamp={commentsData[comment].createTime}>{handleTime(commentsData[comment].createTime)}</time>
                    <a if={commentsData[comment].author == userId} onclick={handleEdit} data-id={comment}>{language.commentEditButton}</a>
                    <a if={commentsData[comment].author == userId} onclick={handleRemove} data-id={comment}>{language.commentDeleteButton}</a>
                </span>
            </div>
            <p>{commentsData[comment].content}</p>
        </div>
    </div>
    <graphjs-promo if={!loaded} properties="top right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import language from '../scripts/language.js';
        import getSession from '../scripts/getSession.js';
        import getComments from '../scripts/getComments.js';
        import addComment from '../scripts/addComment.js';
        import editComment from '../scripts/editComment.js';
        import removeComment from '../scripts/removeComment.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';

        import gravatar from 'gravatar';
        this.gravatar = gravatar;

        analytics("comments");

        this.language = language('comments', opts);

        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.page = opts.page ? parseInt(opts.page) : 1;
        this.pageLimit = opts.limit ? parseInt(opts.limit) : 10;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.comments = [];
        this.commentsData = {};
        this.authorsData = {};
        this.url = opts.url ? opts.url : window.location.href.replace(/\/$/, "");
        this.commentCount = 0;

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
            let url = self.url;
            getComments(url, function(response) {
                if(response.success) {
                    self.comments = [];
                    self.commentCount = 0;
                    for(let comment of response.comments) {
                        let key = Object.keys(comment)[0];
                        self.comments.push(key);
                        self.commentsData[key] = comment[key];
                        self.commentCount++;
                        callback && callback();
                        getProfile(comment[key].author, function(response) {
                            if(response.success) {
                                self.authorsData[comment[key].author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.updateCounter();
                    self.loaded = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
            self.update();
        }
        this.updateCounter = () => {
            this.refs.counter = this.language.commentCount.replace('%s',this.commentCount);
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
            let url = self.url;
            addComment(url, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.refs.composer.value = '';
                    self.commentCount++;
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
                event.target.innerText = this.language.commentEditButton;
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
                event.target.innerText = this.language.commentSaveButton;
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(this.language.commentDeleteConfirmation)) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                
                self.update();
                removeComment(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.commentCount--;
                        element.parentNode.removeChild(element);
                        self.updateCounter();
                        self.update();
                        //self.handleContent();
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
                text = this.language.commentTimeNow;
            } else if(1 <= time && time < 60) {
                amount = time;
                text = this.language.commentTimeSeconds.replace('%s',amount);
            } else if(60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = this.language.commentTimeMinutes.replace('%s',amount);
            } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = this.language.commentTimeHours.replace('%s',amount);
            } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = this.language.commentTimeDays.replace('%s',amount);
            } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = this.language.commentTimeWeeks.replace('%s',amount);
            } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = this.language.commentTimeMonths.replace('%s',amount);
            } else if(time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = this.language.commentTimeYears.replace('%s',amount);
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
