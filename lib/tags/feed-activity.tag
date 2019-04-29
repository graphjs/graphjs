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
            <graphjs-feed-item each={item in activity} id={item.id} activity={item}></graphjs-feed-item>
        </div>
    </div>
    <script>
        import language from '../scripts/language.js';
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

        this.language = language('comments', opts);
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
        this.offset = opts.offset ? opts.offset : 0;
        this.count = opts.count ? opts.count : 20;

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
            getStatusUpdates(self.offset, self.count, function(response) {
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