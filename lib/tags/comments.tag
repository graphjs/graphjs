<graphjs-comments class="box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Comments'}</div>
    </div>
    <div class="content" ref="scrollingContent">
        <div class="comment">
            <textarea ref="composer" placeholder="Write your comment here..."></textarea>
            <button onclick={handleComment}>Send Comment</button>
            <button onclick={handleClear} class="danger">Clear</button>
        </div>
        <div class="synopsis"if={comments.length > 0}>
            {comments.length <= 1 ? comments.length + ' comment' : comments.length + ' comments'}
        </div>
        <div each={comment in comments} data-id={comment} class="item">
            <div class="credit" if={authorsData.hasOwnProperty(commentsData[comment].author)}>
                <img src={authorsData[commentsData[comment].author].avatar || 'lib/images/avatars/user.png'} />
                <span>
                    <b>{authorsData[commentsData[comment].author].username || 'Unknown User'}</b>
                    <time>{handleTime(commentsData[comment].createTime) || ''}</time>
                    <a if={commentsData[comment].author == userId} onclick={handleRemove} data-id={comment}>Delete</a>
                </span>
            </div>
            <p>{commentsData[comment].content}</p>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/comments.less';
    </style>
    <script>
        import getComments from '../scripts/getComments.js';
        import addComment from '../scripts/addComment.js';
        import removeComment from '../scripts/removeComment.js';
        import getUser from '../scripts/getUser.js';
        import getProfile from '../scripts/getProfile.js';

        this.page = 1;
        this.pageLimit = 10;
        this.comments = [];
        this.commentsData = {};
        this.authorsData = {};

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
        });

        this.handleUser = () => {
            let self = this;
            getUser(function(response) {
                if(response.success) {
                    self.userId = response.id;
                } else {
                    //Handle errors
                }
            });
        }
        this.handleContent = (callback) => {
            let self = this;
            getComments(window.location.href, function(response) {
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
                    self.update();
                }
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
            addComment(window.location.href, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.refs.composer.value = '';
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            removeComment(event.target.dataset.id, function(response) {
                if(response.success) {
                    self.handleContent();
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleTime = (timestamp) => {
            let date = new Date(parseInt(timestamp) * 1000);
            let day = date.getDate();
            let month = this.months[date.getMonth()];
            let year = date.getFullYear();
            let hour = date.getHours();
            let minute = date.getMinutes();
            return month + ' ' + day + ', ' + year + ' · ' + hour + ':' + minute;
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