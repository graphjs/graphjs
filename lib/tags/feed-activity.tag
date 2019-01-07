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
                        <a data-id={item.id} onclick={handleDisplay}>
                            <img src={getThumbnail(item.urls[0], 600)} />
                        </a>
                    </div>
                    <div if={item.urls.length > 0 && item.type == 'video'} class="graphjs-media graphjs-video">
                        <a data-id={item.id} onclick={handleDisplay}>
                            <svg viewBox="20 13 67 74">
                                <path d="M82.8,43.5l-50.5-29C27.3,11.7,21,15.3,21,21V79c0,5.8,6.3,9.3,11.3,6.5l50.5-29C87.8,53.6,87.8,46.4,82.8,43.5z"/>
                            </svg>
                            <img src={getThumbnail(item.urls[0], 600)} />
                        </a>
                    </div>
                    <div if={item.urls.length > 0 && item.type == 'photoAlbum'} class="graphjs-media graphjs-photoalbum">
                        <a each={url, index in item.urls} data-id={item.id} data-index={index} onclick={handleDisplay}>
                            <div class="graphjs-container" style={'background-image: url(' + getThumbnail(url, 200) + ');'}></div>
                        </a>
                    </div>
                </div>
                <div class="graphjs-interaction">
                    <div class="graphjs-synopsis">
                        <div class="graphjs-rating-indicator">
                            <a class={'graphjs-' + reaction + ' graphjs-icon ' + (userId ? 'graphjs-authorized' : 'graphjs-unauthorized') + (item.upvoted ? ' graphjs-upvoted' : '')} data-id={item.id} onclick={userId ? (item.upvoted ? removeUpvote : handleUpvote) : ''}>
                                <svg if={reaction == 'default'} viewBox="0 0 62 58">
                                    <path transform="translate(-19.000000, 0.000000)" d="M78.55,20.92 L60,18.22 L51.41,0.88 C51.1430837,0.342731823 50.5949178,0.00297581751 49.995,0.00297581751 C49.3950822,0.00297581751 48.8469163,0.342731823 48.58,0.88 L40,18.22 L21.43,20.92 C20.7357885,21.0320591 20.1641226,21.5260416 19.9525703,22.1966625 C19.7410179,22.8672834 19.9257511,23.5998777 20.43,24.09 L33.86,37.2 L30.64,56 C30.5260197,56.6400466 30.78705,57.289052 31.3124543,57.6719377 C31.8378586,58.0548234 32.535622,58.1045341 33.11,57.8 L50,48.92 L66.89,57.8 C67.464378,58.1045341 68.1621414,58.0548234 68.6875457,57.6719377 C69.21295,57.289052 69.4739803,56.6400466 69.36,56 L66.14,37.2 L79.58,24.1 C80.0914811,23.6064567 80.2769729,22.8645697 80.0579562,22.1883821 C79.8389395,21.5121946 79.2537111,21.0199434 78.55,20.92 Z"></path>
                                </svg>
                                <svg if={reaction == 'like'} viewBox="0 0 42 54">
                                    <path transform="translate(-21, 0)" d="M62.973,24.929 C62.727,26.613 61.768,28.044 60.453,28.9 C60.152,29.099 59.844,29.372 59.515,29.619 L59.385,29.626 C60.631,31.886 60.487,33.536 59.042,35.693 C58.816,36.035 58.645,36.295 58.419,36.528 C59.74,39.253 58.994,42.499 56.666,44.327 C56.755,45.422 56.885,46.504 56.755,47.586 C56.399,50.729 54.099,52.92 50.778,53.31 C50.21,53.372 49.621,53.426 49.032,53.454 C48.635,53.475 48.224,53.488 47.813,53.495 C44.616,53.187 41.418,52.728 38.228,52.345 C35.25,51.996 32.285,51.489 29.088,50.955 C27.814,50.736 26.507,50.517 25.137,50.305 L25.137,50.305 C23.2995486,50.305 21.81,48.8154514 21.81,46.978 L21.81,30.584 C21.81,30.057 21.817,29.53 21.831,29.002 C21.831,28.858 21.838,28.714 21.838,28.571 C21.859,27.955 21.893,27.332 21.934,26.709 C22.064,24.648 25.275,24.429 26.597,23.827 C27.165,23.567 27.645,23.245 28.069,22.875 C28.24,22.731 28.404,22.574 28.562,22.416 C29.452,21.567 30.281,20.608 31.13,19.623 C31.349,19.377 31.561,19.123 31.774,18.884 C33.287,17.152 34.629,15.666 35.889,14.338 C36.587,13.599 37.183,12.791 37.683,11.901 C38.566,10.333 39.162,8.505 39.504,6.321 C39.689,5.123 39.853,3.808 39.997,2.322 C40.072,1.541 40.469,0.59 41.914,0.514 C43.229,0.452 44.495,0.822 45.591,1.507 C47.357,2.616 48.658,4.54 48.919,6.772 C49.124,8.497 48.905,10.23 48.221,12.386 C47.612,14.296 47.043,16.261 46.482,18.165 L46.044,19.671 L46.27,19.664 C48.146,19.568 50.022,19.472 51.898,19.37 C53.733,19.274 55.575,19.178 57.416,19.082 C57.614,19.075 57.813,19.062 58.012,19.048 C58.594,19.117 59.114,19.233 59.594,19.39 C59.772,19.445 59.93,19.513 60.08,19.582 C60.176,19.616 60.251,19.657 60.34,19.698 C60.402,19.732 60.463,19.78 60.518,19.814 C60.586,19.855 60.662,19.896 60.723,19.944 C60.798,20.006 60.874,20.054 60.935,20.108 C62.378,21.19 63.233,23.101 62.973,24.929 Z"></path>
                                </svg>
                                <svg if={reaction == 'love'} viewBox="0 0 81 71">
                                    <path transform="translate(-10.000000, 0.000000)" d="M67.5,1 C61.5,1 56.7,3.2 52.4,7.4 C52.4,7.4 52.4,7.4 52.4,7.4 L50,10.4 L47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C47.6,7.5 47.6,7.5 47.6,7.5 C43.4,3.3 38.5,0.9 32.5,0.9 C26.5,0.9 20.8,3.2 16.6,7.5 C12.4,11.7 10,17.4 10,23.4 C10,29.4 12.3,35.1 16.6,39.3 L46.5,69.4 C47.4,70.3 48.7,70.9 50.1,70.9 C51.4,70.9 52.7,70.4 53.7,69.4 L83.6,39.3 C87.8,35.1 90.2,29.4 90.2,23.4 C90.2,17.4 87.9,11.7 83.6,7.5 C79.2,3.3 73.5,1 67.5,1 Z"></path>
                                </svg>
                                <svg if={reaction == 'save'} viewBox="0 0 72 88">
                                    <path transform="translate(-15.000000, 0.000000)" d="M86.291,44.172 L86.291,8.734 C86.291,4.069 82.525,0.303 77.86,0.303 L24.114,0.303 C19.463,0.303 15.683,4.069 15.683,8.734 L15.683,44.171 L15.682,44.171 L15.682,87.949 L50.987,69.682 L86.292,87.949 L86.291,44.172 Z"></path>
                                </svg>
                            </a>
                            <span>{item.upvotes}</span>
                        </div>
                        <div class="graphjs-comments-indicator" if={item.comments}>
                            <a class={'graphjs-icon ' + (userId ? 'graphjs-authorized' : 'graphjs-unauthorized')} data-id={item.id} onclick={userId ? handleFocus : ''}>
                                <svg viewBox="11 15 80 70">
                                    <path d="M88.208,20.576c0-2.2-1.8-4-4-4H15.792c-2.2,0-4,1.8-4,4v44.75c0,2.2,1.8,4,4,4h32.416c2.2,0,5.495,1.002,7.323,2.227   l16.854,11.296c1.828,1.225,3.305,0.427,3.281-1.773l-0.082-7.75c-0.023-2.2,1.758-4,3.958-4h4.666c2.2,0,4-1.8,4-4V20.576z"/>
                                </svg>
                            </a>
                            <span class="graphjs-counter">{item.comments.length}</span>
                            <span if={item.busy}>Sending...</span>
                        </div>
                    </div>
                    <div class="graphjs-comment" if={loaded && userId}>
                        <textarea data-id={item.id} onkeyup={handleComment} placeholder={i18n.commentsInputPlaceholder}></textarea>
                        <div if={!loaded} class="graphjs-loader">
                            <div class="graphjs-dots">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="graphjs-comments" if={item.comments && item.comments.length > 0}>
                    <div class={'graphjs-comment' + (item.commentsData[comment].pseudo ? ' graphjs-pseudo' : '')} id={'comment-' + comment} each={comment in item.comments} data-id={comment}>
                        <div class="graphjs-credit" if={authorsData.hasOwnProperty(item.commentsData[comment].author)}>
                            <img data-link="profile" data-id={item.commentsData[comment].author} onclick={handleShow} src={authorsData[item.commentsData[comment].author].avatar ? downsizeImage(authorsData[item.commentsData[comment].author].avatar, 50) : defaultAvatar} />
                            <span>
                                <b data-link="profile" data-id={item.commentsData[comment].author} onclick={handleShow}>{authorsData[item.commentsData[comment].author].username || i18n.unknowUserText}</b>
                                <time data-timestamp={item.commentsData[comment].createTime}>{handleTime(item.commentsData[comment].createTime)}</time>
                                <small if={item.commentsData[comment].pseudo} class="graphjs-separated">Sending...</small>
                                <small if={item.commentsData[comment].failed} class="graphjs-separated">Couldn't send!</small>
                                <a hide={true} if={!item.commentsData[comment].pseudo && item.commentsData[comment].author == userId} onclick={handleEdit} data-id={comment}>{i18n.commentEditButtonText}</a>
                                <a if={!item.commentsData[comment].pseudo && item.commentsData[comment].author == userId} onclick={handleRemoveComment} data-id={comment} data-parent={item.id}>{i18n.commentDeleteButtonText}</a>
                            </span>
                        </div>
                        <p>{item.commentsData[comment].content}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        import getSession from '../scripts/getSession.js';
        import getStatusUpdates from '../scripts/getStatusUpdates.js';
        import getStatusUpdate from '../scripts/getStatusUpdate.js';
        import removeStatusUpdate from '../scripts/removeStatusUpdate.js';
        import getStatusUpdateComments from '../scripts/getStatusUpdateComments.js';
        import commentStatusUpdate from '../scripts/commentStatusUpdate.js';
        import removeStatusUpdateComment from '../scripts/removeStatusUpdateComment.js';
        import upvote from '../scripts/upvote.js';
        import getUpvote from '../scripts/getUpvote.js';
        import removeUpvote from '../scripts/removeUpvote.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import showDisplay from '../scripts/showDisplay.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['comments'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        import {downsizeImage, getThumbnail} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;
        this.getThumbnail = getThumbnail;

        let self = this;
        this.blocked = false;
        this.activity = [];
        this.authorsData = {};
        this.reaction = opts.reaction || 'love';
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
            this.update();
            this.handleUser();
            this.handleContent();
        }
        this.handleUser = () => {
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.blocked = false;
                    self.update();
                } else {
                    self.userId = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleContent = (callback) => {
            getStatusUpdates(function(response) {
                if(response.success) {
                    self.activity = response.updates.reverse();
                    self.activity.forEach(activity => {
                        activity.commentsData = {}
                        activity.upvoted = false;
                        activity.upvotes = 0;
                        getUpvote(activity.id, function(response) {
                            if(response.success) {
                                activity.upvoted = response.starred;
                                activity.upvotes = response.count;
                            }
                        });
                        self.update();
                    });
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
                self.handleComments();
            });
        }
        this.handleComments = () => {
            for(let item of this.activity) {
                this.handleCommentsByItem(item);
            }
        }
        this.handleCommentsByItem = (item) => {
            getStatusUpdateComments(item.id, function(response) {
                if(response.success) {
                    item.comments = [];
                    self.update();
                    let authors = Object.keys(self.authorsData);
                    response.comments.forEach(comment => {
                        let key = Object.keys(comment)[0];
                        item.comments.push(key);
                        item.commentsData[key] = comment[key];
                        !authors.includes(comment[key].author) && getProfile(comment[key].author, function(response) {
                            if(response.success) {
                                self.authorsData[comment[key].author] = response.profile;
                                self.update();
                            }
                        });
                        self.update();
                    });
                }
            });
        }
        this.handleNewContent = (id) => {
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
        this.handleUpvote = (event) => {
            event.preventDefault();
            let id = event.target.dataset.id;
            // Find related activity
            let activity = self.activity.filter(item => item.id === id)[0];
            if(activity.upvoted) {
                activity.upvoted = false;
                activity.upvotes -= 1;
                self.update();
                removeUpvote(id, function(response) {
                    if(response.success) {
                        // Do nothing
                    } else {
                        activity.upvoted = true;
                        activity.upvotes += 1;
                        self.update();
                    }
                });
            } else {
                activity.upvoted = true;
                activity.upvotes += 1;
                self.update();
                upvote(id, function(response) {
                    if(response.success) {
                        // Do nothing
                    } else {
                        activity.upvoted = false;
                        activity.upvotes -= 1;
                        self.update();
                    }
                });
            }
        }
        this.handleComment = (event) => {
            if (event.keyCode == 13) {
                event.preventDefault();
                let value = event.target.value.replace(/\n+/g, '\n'); // Removes repetitive line breaks
                if(!event.shiftKey) {
                    // Reset input
                    event.target.value = '';
                    // Get related activity
                    let id = event.target.dataset.id;
                    let activity = self.activity.filter(item => item.id === id)[0];
                    // Create pseudo comment
                    let randomNumber = Math.floor(Math.random() * 1000000);
                    let timestamp = (new Date()).getTime();
                    activity.comments.push(randomNumber);
                    activity.commentsData[randomNumber] = {
                        content: value,
                        author: self.userId,
                        createTime: timestamp,
                        pseudo: true
                    };
                    self.update();
                    // Scroll to comment
                    document.getElementById('comment-' + randomNumber).scrollIntoView({
                        behavior: 'smooth'
                    });
                    // Make request for new comment
                    commentStatusUpdate(id, value, function(response) {
                        if(response.success) {
                            // Re-render all comments belong to the activity
                            self.handleCommentsByItem(activity);
                        } else {
                            // Modify pseudo comment
                            activity.commentsData[randomNumber].pseudo = false;
                            activity.commentsData[randomNumber].failed = true;
                            self.update();
                        }
                    });
                }
            }
        }
        this.handleFocus = (event) => {
            event.preventDefault();
            let query = 'textarea[data-id="' + event.target.dataset.id + '"]';
            let element = document.querySelectorAll(query)[0];
            element && element.focus();
        }
        this.handleDisplay = (event) => {
            event.preventDefault();
            let id = event.currentTarget.dataset.id;
            let index = event.currentTarget.dataset.index;
            let data = this.activity.filter(item => item.id === id)[0];
            data && showDisplay(data, index);
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.handleRemove = (event) => {
            event.preventDefault();
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
        this.handleRemoveComment = (event) => {
            event.preventDefault();
            let itemId = event.target.dataset.id;
            let parentId = event.target.dataset.parent;
            if (window.confirm('Are you sure to delete this comment?')) {
                // Find related activity
                let activity = self.activity.filter(item => item.id === parentId)[0];
                // Leave related item out
                let itemIndex = activity.comments.indexOf(itemId);
                activity.comments = activity.comments.filter(id => id !== itemId);
                self.update();
                // Make request to remove comment
                removeStatusUpdateComment(itemId, function(response) {
                    if(response.success) {
                        // Remove from commments data
                        delete activity.commentsData[itemId];
                    } else {
                        // Add back to comments list
                        activity.comments.splice(itemIndex, 0, itemId);
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