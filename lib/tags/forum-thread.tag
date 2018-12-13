<graphjs-forum-thread
    class={'graphjs-element graphjs-root graphjs-composer ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header">
        <a class="graphjs-option graphjs-left" data-link="list" onclick={opts.minor ? handleCallback : handleShow}>
            <svg fill="blue" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M29.9834254,15 C38.2707182,15 45,21.6961326 45,29.9834254 C45,38.2707182 38.2707182,45 29.9834254,45 C21.6961326,45 15,38.2707182 15,29.9834254 C15,21.6961326 21.6961326,15 29.9834254,15 Z M29.9834254,42.3480663 C36.7790055,42.3480663 42.3480663,36.8121547 42.3480663,29.9834254 C42.3480663,23.1878453 36.8121547,17.6187845 29.9834254,17.6187845 C23.1878453,17.6187845 17.6187845,23.1546961 17.6187845,29.9834254 C17.6519337,36.7790055 23.1878453,42.3480663 29.9834254,42.3480663 Z M25.4088398,29.9834254 L31.6077348,36.1823204 L33.4972376,34.2928177 L29.1546961,29.9834254 L33.4972376,25.640884 L31.6077348,23.7513812 L25.4088398,29.9834254 Z"></path>
                </g>
            </svg>
        </a>
        <div if={window.innerWidth < 768} class="graphjs-title">{i18n.title.replace("%s",(currentAuthor || i18n.defaultUser))}</div>
        <div if={window.innerWidth >= 768} class="graphjs-title">{i18n.title.replace("%s",(currentAuthor || i18n.defaultUser))}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div if={loaded} class="graphjs-thread" ref="scrollingContent">
            <div class="graphjs-title" if={title}>
                <h1>{title}</h1>
            </div>
            <div class="graphjs-replies">
                <div each={entry, index in entries} data-id={entry.id} class="graphjs-item">
                    <div class="graphjs-credit" if={authorsData.hasOwnProperty(entry.author)}>
                        <img data-link="profile" data-id={entry.author} onclick={handleShow} src={authorsData[entry.author].avatar ? downsizeImage(authorsData[entry.author].avatar, 50) : defaultAvatar} />
                        <span>
                            <b data-link="profile" data-id={entry.author} onclick={handleShow}>{authorsData[entry.author].username || i18n.unknowUserText}</b>
                            <time data-timestamp={entry.timestamp}>{handleTime(entry.timestamp)}</time>
                            <a if={entry.author == userId} onclick={handleEdit} data-id={entry.id}>{i18n.threadEditButtonText}</a>
                            <a if={entry.author == userId} onclick={index == 0 ? handleDestroy : handleRemove} data-id={entry.id}>{i18n.threadDeleteButtonText}</a>
                        </span>
                    </div>
                    <p>{entry.content}</p>
                </div>
            </div>
        </div>
        <div if={loaded} class="graphjs-reply" if={entries.length > 0}>
            <div onclick={handleComposer} class="graphjs-synopsis">
                <b if={entries.length > 1}>{i18n.repliesNumberText.replace("%s",(entries.length - 1))}</b>
                <a if={!composerReady}>{i18n.replyLinkText}</a>
                <a class={composerReady ? 'graphjs-icon' : 'graphjs-reverse graphjs-icon'}>
                    <svg viewBox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path>
                    </svg>
                </a>
            </div>
            <form class={userId ? '' : 'graphjs-loading graphjs-blocked'}>
                <textarea ref="composer" placeholder={i18n.composerInputPlaceholder}></textarea>
                <button ref="submit" onclick={handleReply}>{i18n.submitButtonText}</button>
                <button onclick={handleClear} class="graphjs-danger">{i18n.clearButtonText}</button>
                <div if={!loaded} class="graphjs-loader">
                    <div class="graphjs-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <button if={!userId} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
            <form>
        </div>
        <div if={!loaded} class="graphjs-placeholder graphjs-loader">
            <div class="graphjs-title graphjs-line graphjs-fill"></div>
            <div class="graphjs-creator">
                <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                <div class="graphjs-information">
                    <div class="graphjs-line graphjs-fill"></div>
                    <div class="graphjs-line graphjs-fill"></div>
                </div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <hr class="graphjs-fill" />
            <div class="graphjs-creator">
                <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                <div class="graphjs-information">
                    <div class="graphjs-line graphjs-fill"></div>
                    <div class="graphjs-line graphjs-fill"></div>
                </div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <hr class="graphjs-fill" />
            <div class="graphjs-creator">
                <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                <div class="graphjs-information">
                    <div class="graphjs-line graphjs-fill"></div>
                    <div class="graphjs-line graphjs-fill"></div>
                </div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginDisplayButtonText}</button>
    </div>
    <graphjs-promo if={loaded} properties="bottom left"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getThread from '../scripts/getThread.js';
        import replyThread from '../scripts/replyThread.js';
        import removeReply from '../scripts/removeReply.js';
        import showForumList from '../scripts/showForumList.js';
        import editReply from '../scripts/editReply.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("forum-thread");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['forum-thread'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.access = opts.access || 'public';
        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.entries = [];
        this.authorsData = {};
        this.composerReady = true;

        this.on('before-mount', function() {
            this.handleUser();
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
                    self.handleContent();
                } else {
                    if(self.access != 'private') {
                        self.handleContent();
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
            showLogin({
                action: 'updateForumThread'
            });
        }
        this.handleContent = (callback) => {
            let self = this;
            self.id && getThread(self.id, function(response) {
                if(response.success) {
                    i18n.title = response.title;
                    self.title = response.title;
                    self.entries = response.messages;
                    self.update();
                    callback && callback();
                    for(let entry of self.entries) {
                        getProfile(entry.author, function(response) {
                            if(response.success) {
                                self.currentAuthor = self.currentAuthor || response.profile.username;
                                self.authorsData[entry.author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.update();
                }
                self.loaded = true;
                self.update();
            });
        }
        this.handleComposer = () => {
            this.root.classList.toggle('graphjs-composer');
            if(this.composerReady) {
                this.composerReady = false;
                this.refs.composer.value = '';
            } else {
                this.composerReady = true;
                this.refs.composer.focus();
            }
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.composer.value = '';
            this.refs.composer.focus();
        }
        this.handleReply = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.add('graphjs-loading');
            replyThread(self.id, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.composerReady = false;
                    self.refs.composer.value = '';
                    self.root.classList.toggle('graphjs-composer');
                    self.update();
                } else {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.update();
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
                case 'list':
                    showForumList({
                        scroll: true
                    });
                    break;
            }
        }
        this.handleEdit = (event) => {
            event.preventDefault();
            let textBox = event.target.parentNode.parentNode.nextElementSibling;
            let currentText = textBox.innerText;
            if(textBox.hasAttribute('contenteditable')) {
                textBox.removeAttribute('contenteditable');
                textBox.classList.remove('graphjs-editable');
                event.target.innerText = i18n.threadEditButtonText;
                if(textBox.innerText != '') {
                    editReply(event.target.dataset.id, textBox.innerText, function(response) {
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
                event.target.innerText = i18n.threadSaveButtonText;
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(i18n.replyDeleteConfirmationText)) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeReply(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
        }
        this.handleDestroy = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(i18n.threadDeleteConfirmationText)) {
                let query = '[data-link="list"]';
                let element = document.querySelectorAll(query)[0];
                removeReply(event.target.dataset.id, function(response) {
                    if(response.success) {
                        element.click();
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
</graphjs-forum-thread>