<graphjs-feed-activity
    class="graphjs-root graphjs-element graphjs-inline"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-content">
        <div class="graphjs-activity" if={activity.length > 0}>
            <div each={item in activity} class="graphjs-item">
                <div class="graphjs-credit" if={authorsData.hasOwnProperty(item.author.id)}>
                    <img data-link="profile" data-id={item.author.id} onclick={handleShow} src={authorsData[item.author.id].avatar ? downsizeImage(authorsData[item.author.id].avatar, 50) : defaultAvatar} />
                    <span>
                        <b data-link="profile" data-id={item.author.id} onclick={handleShow}>{authorsData[item.author.id].username || 'Unknown User'}</b>
                        <time data-timestamp={item.timestamp}>{handleTime(item.timestamp)}</time>
                        <a if={item.author.id == userId} onclick={handleRemove} data-id={item.id}>Delete</a>
                    </span>
                </div>
                <div class="graphjs-entry">
                    <div if={item.text} class="graphjs-text">{item.text}</div>
                    <div if={item.urls.length > 0 && item.type == 'photo'} class="graphjs-media graphjs-photo">
                        <a onclick={handleDisplay}>
                            <img src={getThumbnail(item.urls[0], 600)} />
                        </a>
                    </div>
                    <div if={item.urls.length > 0 && item.type == 'video'} class="graphjs-media graphjs-video">
                        <a onclick={handleDisplay}>
                            <svg viewBox="20 13 67 74">
                                <path d="M82.8,43.5l-50.5-29C27.3,11.7,21,15.3,21,21V79c0,5.8,6.3,9.3,11.3,6.5l50.5-29C87.8,53.6,87.8,46.4,82.8,43.5z"/>
                            </svg>
                            <img src={getThumbnail(item.urls[0], 600)} />
                        </a>
                    </div>
                    <div if={item.urls.length > 0 && item.type == 'photoAlbum'} class="graphjs-media graphjs-photoalbum">
                        <a each={url in item.urls} onclick={handleDisplay}>
                            <div class="graphjs-container" style={'background-image: url(' + getThumbnail(url, 200) + ');'}></div>
                        </a>
                    </div>
                </div>
                <!--
                <div class="graphjs-comments">
                    <div class="graphjs-synopsis" if={item.comments.length <= 0}>
                        No comments yet.
                    </div>
                    <div class="graphjs-synopsis" if={item.comments.length > 0}>
                        {item.comments.length} comments
                    </div>
                    <div class={'graphjs-comment' + (blocked ? ' graphjs-loading graphjs-blocked' : '')}>
                        <textarea ref="composer" placeholder={i18n.commentsInputPlaceholder}></textarea>
                        <button ref="submit" onclick={handleComment}>{i18n.submitButtonText}</button>
                        <div if={!loaded && !blocked} class="graphjs-loader">
                            <div class="graphjs-dots">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </div>
                        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
                    </div>
                    <div each={comment in comments} data-id={comment} class="graphjs-item">
                        <div class="graphjs-credit" if={authorsData.hasOwnProperty(commentsData[comment].author)}>
                            <img data-link="profile" data-id={commentsData[comment].author} onclick={handleShow} src={authorsData[commentsData[comment].author].avatar ? downsizeImage(authorsData[commentsData[comment].author].avatar, 50) : defaultAvatar} />
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
                -->
            </div>
        </div>
    </div>
    <script>
        import getSession from '../scripts/getSession.js';
        import getStatusUpdates from '../scripts/getStatusUpdates.js';
        import getStatusUpdate from '../scripts/getStatusUpdate.js';
        import removeStatusUpdate from '../scripts/removeStatusUpdate.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import showDisplay from '../scripts/showDisplay.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.activity = [];
        this.authorsData = {};
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

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
        this.getThumbnail = (url, size) => {
            return downsizeImage(
              url.substr(0, url.lastIndexOf('.')) + '.jpg',
              size
            );
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
            getStatusUpdates(function(response) {
                if(response.success) {
                    self.activity = response.updates.reverse();
                    self.update();
                    for(let item of self.activity) {
                        getProfile(item.author.id, function(response) {
                            if(response.success) {
                                self.authorsData[item.author.id] = response.profile;
                            }
                            self.update();
                        });
                    }
                }
                self.loaded = true;
                self.update();
            });
        }
        this.handleNewContent = (id) => {
            let self = this;
            getStatusUpdate(id, function(response) {
                if(response.success) {
                  let newItem = response.update;
                    self.activity = [
                      newItem,
                      ...self.activity
                    ];
                    self.update();
                    getProfile(newItem.author.id, function(response) {
                        if(response.success) {
                            self.authorsData[newItem.author.id] = response.profile;
                        }
                        self.update();
                    });
                }
                self.update();
            });
        }
        this.handleDisplay = (event) => {
            event.preventDefault();
            showDisplay('123123123', {
                type: 'album',
                owner: '48760696099368953dd71a90b727acba',
                timestamp: 1524747012,
                album: [
                    'https://res.cloudinary.com/ozanilbey/image/upload/c_limit,fl_png8,w_360/favogue/cover.png',
                    'https://res.cloudinary.com/ozanilbey/image/upload/c_limit,fl_png8,w_360/piccture/cover.png',
                    'https://res.cloudinary.com/ozanilbey/image/upload/c_limit,fl_png8,w_360/cardz/cover.png',
                    'https://res.cloudinary.com/ozanilbey/image/upload/c_limit,fl_png8,w_360/brush/cover.png',
                    'https://res.cloudinary.com/ozanilbey/image/upload/c_limit,fl_png8,w_360/fihrist/cover.png'
                ]
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm('Are you sure to delete this item?')) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeStatusUpdate(event.target.dataset.id, function(response) {
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
</graphjs-feed-activity>