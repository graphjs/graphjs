<graphjs-blog-post
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div if={notExisting} class="graphjs-nonexistent">
            <p>{i18n.noPostText}</p>
        </div>
        <div if={loaded && !deleted} class="graphjs-post" ref="scrollingContent">
            <ul class="graphjs-action" if={authorized}>
                <li if={opts.minor}>
                    <a ref="edit" onclick={edit}>Edit</a>
                </li>
                <li if={!published}>
                    <a ref="publish" onclick={publish}>Publish</a>
                </li>
                <li if={published}>
                    <a ref="unpublish" onclick={unpublish} class="graphjs-danger">Unpublish</a>
                </li>
                <li>
                    <a ref="delete" onclick={delete} class="graphjs-danger">Delete</a>
                </li>
            </ul>
            <h1 if={title} class="graphjs-title">
                <a if={opts.minor}  class="graphjs-back" onclick={handleCallback} data-link="list">
                    <svg fill="blue" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M29.9834254,15 C38.2707182,15 45,21.6961326 45,29.9834254 C45,38.2707182 38.2707182,45 29.9834254,45 C21.6961326,45 15,38.2707182 15,29.9834254 C15,21.6961326 21.6961326,15 29.9834254,15 Z M29.9834254,42.3480663 C36.7790055,42.3480663 42.3480663,36.8121547 42.3480663,29.9834254 C42.3480663,23.1878453 36.8121547,17.6187845 29.9834254,17.6187845 C23.1878453,17.6187845 17.6187845,23.1546961 17.6187845,29.9834254 C17.6519337,36.7790055 23.1878453,42.3480663 29.9834254,42.3480663 Z M25.4088398,29.9834254 L31.6077348,36.1823204 L33.4972376,34.2928177 L29.1546961,29.9834254 L33.4972376,25.640884 L31.6077348,23.7513812 L25.4088398,29.9834254 Z"></path>
                        </g>
                    </svg>
                </a>
                {title}
            </h1>
            <ul if={loaded} class="graphjs-information">
                <li if={author} class="graphjs-author" data-authorbeforetext={i18n.authorBeforeText}>
                    <a data-link="profile" data-id={author.id} onclick={handleShow}>{author.username}</a>
                </li>
                <li if={time} class="graphjs-time" data-publishedtimebeforetext={i18n.publishedTimeBeforeText} data-edittimebeforetext={i18n.editTimeBeforeText}>
                    <time if={published && time.published && opts.minor}>
                        <a href={window.location.href}>{timeText}</a>
                    </time>
                    <time if={published && time.published && !opts.minor}>{timeText}</time>
                    <time if={!published && time.lastEdited} class="graphjs-edited">{timeText}</time>
                </li>
            </ul>
            <div ref="body" if={body} class="graphjs-body graphjs-article"></div>
            <!--
            <div class="graphjs-replies">
                <div each={entry, index in entries} data-id={entry.id} class="graphjs-item">
                    <div class="graphjs-credit" if={authorsData.hasOwnProperty(entry.author)}>
                        <img data-link="profile" data-id={entry.author} onclick={handleShow} src={authorsData[entry.author].avatar ? downsizeImage(authorsData[entry.author].avatar, 50) : defaultAvatar} />
                        <span>
                            <b data-link="profile" data-id={entry.author} onclick={handleShow}>{authorsData[entry.author].username || i18n.unknownUserText}</b>
                            <time data-timestamp={entry.timestamp}>{handleTime(entry.timestamp)}</time>
                            <a if={entry.author == userId} onclick={handleEdit} data-id={entry.id}>{i18n.editLinkText}</a>
                            <a if={entry.author == userId} onclick={index == 0 ? handleDestroy : handleRemove} data-id={entry.id}>{i18n.deleteLinkText}</a>
                        </span>
                    </div>
                    <p>{entry.content}</p>
                </div>
            </div>
            -->
        </div>
        <div class="graphjs-reply" if={entries.length > 0}>
            <div onclick={handleComposer} class="graphjs-synopsis">
                <b if={entries.length > 1}>{entries.length <= 2 ? ((entries.length - 1) + ' '+i18n.replyText) : ((entries.length - 1) + ' '+i18n.repliesText)}</b>
                <a if={!composerReady}>{i18n.replyComposerText}</a>
                <a class={composerReady ? 'graphjs-icon' : 'graphjs-reverse graphjs-icon'}>
                    <svg viewBox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path>
                    </svg>
                </a>
            </div>
            <form class={userId ? '' : 'graphjs-loading graphjs-blocked'}>
                <textarea ref="composer" placeholder={i18n.replyInputPlaceholder}></textarea>
                <button ref="submit" onclick={handleReply}>{i18n.replyButtonText}</button>
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
            <div class="graphjs-information graphjs-line graphjs-fill"></div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
        </div>
    </div>
    <graphjs-promo if={loaded} properties="bottom right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getBlogPost from '../scripts/getBlogPost.js';
        import commentBlogPost from '../scripts/commentBlogPost.js';
        import publishBlogPost from '../scripts/publishBlogPost.js';
        import unpublishBlogPost from '../scripts/unpublishBlogPost.js';
        import removeBlogPost from '../scripts/removeBlogPost.js';
        import removeBlogComment from '../scripts/removeBlogComment.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import showBlogList from '../scripts/showBlogList.js';

        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        analytics("blog-post");

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline'
            : 'graphjs-box';

        this.authorized = false;
        this.entries = [];
        this.authorsData = {};
        this.composerReady = true;
        this.body = '';
        this.rendered = false;

        let self = this;

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['blog-composer'];
        i18n = {...i18n,...opts}
        this.i18n = i18n;
        
        this.on('before-mount', function() {
            this.handleUser();
            this.frequentlyUpdateTime = setInterval(this.handleTimeUpdate,  60 * 1000);
        });
        this.on('mount', function() {
            this.loaded && this.handleRender();
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });
        this.on('before-unmount', function() {
            this.removeHash();
        });

        this.restart = () => {
            this.blocked = false;
            this.authorized = false;
            this.userId = false;
            this.update();
            this.handleUser(function() {
                self.loaded && self.handleRender();
            });
        }
        this.handleUser = (callback) => {
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                }
                self.handleContent();
                callback && callback();
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateBlogPost'
            });
        }
        this.handleContent = () => {
            self.id && getBlogPost(self.id, function(response) {
                if(response.success) {
                    self.title = response.blog.title;
                    self.body = response.blog.summary;
                    self.author = response.blog.author;
                    self.time = {
                        started: response.blog.start_time,
                        lastEdited: response.blog.last_edit,
                        published: response.blog.publish_time
                    };
                    self.published = !response.blog.is_draft;
                    self.loaded = true;
                    getProfile(self.userId, function(response) {
                        if(response.success) {
                            self.authorized = response.profile.is_editor;
                        }
                        self.update();
                    });
                    self.update();
                    self.handleRender();
                    let time = response.blog.is_draft ? response.blog.last_edit : response.blog.publish_time;
                    self.printTime(time * 1000);
                    // getBlogComments
                    /*
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
                    */
                } else {
                    self.notExisting = true;
                    self.update();
                }
            });
        }
        this.handleRender = () => {
            if(this.body && !this.rendered) {
                this.refs.body.innerHTML = this.body;
            }
            this.rendered = true;
        }
        this.edit = () => {
            this.handleCallback({
                link: 'composer',
                id: self.id
            });
        }
        this.publish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = i18n.publishProgressText;
            publishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = true;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = i18n.publishErrorText;
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = i18n.publishLinkText;
                        }, 2500);
                    }
                }
            });
        }
        this.unpublish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = i18n.unpublishProgressText;
            unpublishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = false;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = i18n.unpublishErrorText;
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = i18n.unpublishLinkText;
                        }, 2500);
                    }
                }
            });
        }
        this.delete = (event) => {
            let link = event.currentTarget;
            if (window.confirm(i18n.deleteConfirmationText)) {
                link.setAttribute('disabled', 'disabled');
                link.innerHTML = i18n.deleteProgressText;
                removeBlogPost(self.id, function(response) {
                    if(response.success) {
                        self.notExisting = true;
                        self.update();
                        opts.minor && self.handleCallback({
                            link: 'list'
                        });
                    } else {
                        if(link) {
                            link.setAttribute('disabled', 'disabled');
                            link.innerHTML = i18n.deleteErrorText;
                            setTimeout(function() {
                                link.removeAttribute('disabled');
                                link.innerHTML = i18n.deleteLinkText;
                            }, 2500);
                        }
                    }
                });
            }
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
            self.refs.submit.classList.add('graphjs-loading');
            commentBlogPost(self.id, self.refs.composer.value, function(response) {
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
                this.removeHash();
                let dataset = Object.assign({}, properties.currentTarget.dataset);
                opts.callback(dataset);
            } else {
                opts.callback(properties);
            }
        }
        this.removeHash = () => {
            if(opts.minor && window.location.hash.includes(this.id + '-GJS')) {
                history.pushState('', document.title, window.location.pathname + window.location.search);
            }
        }
        this.handleShow = (event) => {
            event.preventDefault();
            let dataset = event.currentTarget.dataset;
            switch(dataset.link) {
                case 'list':
                    showBlogPost({
                        scroll: true
                    });
                    break;
                case 'profile':
                    showProfile({
                        id: dataset.id,
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
                event.target.innerText = i18n.editLinkText;
                if(textBox.innerText != '') {
                    editBlogComment(event.target.dataset.id, textBox.innerText, function(response) {
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
                event.target.innerText = i18n.saveLinkText;
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            if (window.confirm(i18n.replyDeleteConfirmation)) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeBlogComment(event.target.dataset.id, function(response) {
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
            if (window.confirm(i18n.postDeleteConfirmation)) {
                let query = '[data-link="list"]';
                let element = document.querySelectorAll(query)[0];
                removeBlogPost(event.target.dataset.id, function(response) {
                    if(response.success) {
                        element.click();
                    } else {
                        //Handle error
                    }
                });
            }
        }
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
        this.printTime = (timestamp) => {
            if(timestamp) {
                let time = new Date(timestamp);
                this.timeText = this.months[time.getMonth()] + ' ' + time.getDate();
                this.update();
            } else {
                this.timeText = '';
                this.update();
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
</graphjs-blog-post>