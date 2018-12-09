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
            <p>This post is no longer available!</p>
        </div>
        <div if={loaded && !deleted} class="graphjs-post" ref="scrollingContent">
            <h1 if={title} class="graphjs-title">{title}</h1>
            <ul if={loaded} class="graphjs-information">
                <li if={author} class="graphjs-author">
                    <a data-link="profile" data-id={author.id} onclick={handleShow}>{author.username}</a>
                </li>
                <li if={time} class="graphjs-time">
                    <time if={published && time.published}>{timeText}</time>
                    <time if={!published && time.lastEdited} class="graphjs-edited">{timeText}</time>
                </li>
                <li class="graphjs-action">
                    <a ref="edit" if={opts.minor} onclick={edit}>Edit</a>
                    <a ref="publish" if={!published} onclick={publish}>Publish</a>
                    <a ref="unpublish" if={published} class="graphjs-danger">Unpublish</a>
                    <a ref="delete" onclick={delete} class="graphjs-danger">Delete</a>
                </li>
            </ul>
            <div ref="body" if={body} class="graphjs-body graphjs-article"></div>
            <!--
            <div class="graphjs-replies">
                <div each={entry, index in entries} data-id={entry.id} class="graphjs-item">
                    <div class="graphjs-credit" if={authorsData.hasOwnProperty(entry.author)}>
                        <img data-link="profile" data-id={entry.author} onclick={handleShow} src={authorsData[entry.author].avatar ? downsizeImage(authorsData[entry.author].avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                        <span>
                            <b data-link="profile" data-id={entry.author} onclick={handleShow}>{authorsData[entry.author].username || 'Unknown User'}</b>
                            <time data-timestamp={entry.timestamp}>{handleTime(entry.timestamp)}</time>
                            <a if={entry.author == userId} onclick={handleEdit} data-id={entry.id}>Edit</a>
                            <a if={entry.author == userId} onclick={index == 0 ? handleDestroy : handleRemove} data-id={entry.id}>Delete</a>
                        </span>
                    </div>
                    <p>{entry.content}</p>
                </div>
            </div>
            -->
        </div>
        <div class="graphjs-reply" if={entries.length > 0}>
            <div onclick={handleComposer} class="graphjs-synopsis">
                <b if={entries.length > 1}>{entries.length <= 2 ? (entries.length - 1) + ' reply' : (entries.length - 1) + ' replies'}</b>
                <a if={!composerReady}>Write a Reply</a>
                <a class={composerReady ? 'graphjs-icon' : 'graphjs-reverse graphjs-icon'}>
                    <svg viewBox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path>
                    </svg>
                </a>
            </div>
            <form class={userId ? '' : 'graphjs-loading graphjs-blocked'}>
                <textarea ref="composer" placeholder="Write your reply here..."></textarea>
                <button ref="submit" onclick={handleReply}>Send Reply</button>
                <button onclick={handleClear} class="graphjs-danger">Clear</button>
                <div if={!loaded} class="graphjs-loader">
                    <div class="graphjs-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <button if={!userId} onclick={handleBlock} class="graphjs-blockage">Login to write a reply</button>
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
        import removeBlogComment from '../scripts/removeBlogComment.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import showBlogList from '../scripts/showBlogList.js';

        analytics("blog-post");

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline'
            : 'graphjs-box';

        this.entries = [];
        this.authorsData = {};
        this.composerReady = true;
        this.body = '';
        this.rendered = false;

        let self = this;

        this.on('before-mount', function() {
            this.handleUser();
            this.frequentlyUpdateTime = setInterval(this.handleTimeUpdate,  60 * 1000);
        });
        this.on('mount', function() {
            this.loaded && !this.rendered && this.handleRender();
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });

        this.restart = () => {
            this.blocked = false;
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
            link.innerHTML = 'Publishing...';
            publishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = true;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = 'Couldn\'t be published!';
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = 'Publish';
                        }, 2500);
                    }
                }
            });
        }
        this.unpublish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = 'Unpublishing...';
            unpublishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = false;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = 'Couldn\'t be unpublished!';
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = 'Unpublish';
                        }, 2500);
                    }
                }
            });
        }
        this.delete = (event) => {
            let link = event.currentTarget;
            if (window.confirm('Are you sure to delete this blog post?')) {
                link.setAttribute('disabled', 'disabled');
                link.innerHTML = 'Deleting...';
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
                            link.innerHTML = 'Couldn\'t be deleted!';
                            setTimeout(function() {
                                link.removeAttribute('disabled');
                                link.innerHTML = 'Delete';
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
                    showBlogPost({
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
                event.target.innerText = 'Edit';
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
                event.target.innerText = 'Save';
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            if (window.confirm('Are you sure to delete this reply?')) {
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
            if (window.confirm('Are you sure to remove this post?')) {
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
        this.handleShow = (event) => {
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
                text = 'Now';
            } else if(1 <= time && time < 60) {
                amount = time;
                text = amount == 1 ? amount + ' second ago' : amount + ' seconds ago';
            } else if(60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = amount == 1 ? amount + ' minute ago' : amount + ' minutes ago';
            } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = amount == 1 ? amount + ' hour ago' : amount + ' hours ago';
            } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = amount == 1 ? amount + ' day ago' : amount + ' days ago';
            } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = amount == 1 ? amount + ' week ago' : amount + ' weeks ago';
            } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = amount == 1 ? amount + ' month ago' : amount + ' months ago';
            } else if(time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = amount == 1 ? amount + ' year ago' : amount + ' years ago';
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