<graphjs-forum-thread class={(opts.minor ? '' : 'box') + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')} onclick={blocked ? handleBlock : ''}>
    <div class="header">
        <a class="option left" data-link="list" onclick={opts.minor ? handleCallback : handleShow}>
            <svg fill="blue" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M29.9834254,15 C38.2707182,15 45,21.6961326 45,29.9834254 C45,38.2707182 38.2707182,45 29.9834254,45 C21.6961326,45 15,38.2707182 15,29.9834254 C15,21.6961326 21.6961326,15 29.9834254,15 Z M29.9834254,42.3480663 C36.7790055,42.3480663 42.3480663,36.8121547 42.3480663,29.9834254 C42.3480663,23.1878453 36.8121547,17.6187845 29.9834254,17.6187845 C23.1878453,17.6187845 17.6187845,23.1546961 17.6187845,29.9834254 C17.6519337,36.7790055 23.1878453,42.3480663 29.9834254,42.3480663 Z M25.4088398,29.9834254 L31.6077348,36.1823204 L33.4972376,34.2928177 L29.1546961,29.9834254 L33.4972376,25.640884 L31.6077348,23.7513812 L25.4088398,29.9834254 Z"></path>
                </g>
            </svg>
        </a>
        <div class="title">{opts.title || 'Thread by ' + (currentAuthor || 'Forum User')}</div>
    </div>
    <div class="content">
        <div class="thread" ref="scrollingContent">
            <div class="title" if={title}>
                <h1>{title}</h1>
            </div>
            <div class="replies">
                <div each={entry in entries} class="item">
                    <div class="credit" if={authorsData.hasOwnProperty(entry.author)}>
                        <img src={authorsData[entry.author].avatar || 'lib/images/avatars/user.png'} />
                        <span>
                            <b>{authorsData[entry.author].username || 'Unknown User'}</b>
                            <time>{handleTime(entry.timestamp) || ''}</time>
                        </span>
                    </div>
                    <p>{entry.content}</p>
                </div>
            </div>
        </div>
        <div class="reply" if={entries.length > 0}>
            <div onclick={handleComposer} class="synopsis">
                <!--
                <b>100 views</b>
                -->
                <b if={entries.length > 1}>{entries.length < 2 ? (entries.length - 1) + ' reply' : (entries.length - 1) + ' replies'}</b>
                <a>{composerReady ? 'Cancel Reply' : 'Write a Reply'}</a>
                <a class={composerReady ? 'icon' : 'reverse icon'}>
                    <svg viewBox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path>
                    </svg>
                </a>
            </div>
            <form>
                <textarea ref="composer" placeholder="Write your reply here..."></textarea>
                <button onclick={handleReply}>Send Reply</button>
                <button onclick={handleClear} class="danger">Clear</button>
            <form>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/forum-thread.less';
    </style>
    <script>
        import getUser from '../scripts/getUser.js';
        import getThread from '../scripts/getThread.js';
        import replyThread from '../scripts/replyThread.js';
        import showForumList from '../scripts/showForumList.js';
        import getProfile from '../scripts/getProfile.js';
        import showLogin from '../scripts/showLogin.js';

        this.blocked = false;
        this.id = opts.id;
        this.entries = [];
        this.authorsData = {};
        this.composerReady = false;

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
        });

        this.handleUser = () => {
            let self = this;
            getUser(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.loaded = true;
                    self.update();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.handleContent = (callback) => {
            let self = this;
            self.id && getThread(self.id, function(response) {
                if(response.success) {
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
            });
        }
        this.handleComposer = () => {
            this.root.classList.toggle('composer');
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
            replyThread(self.id, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.handleContent(/*function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    }*/);
                    self.composerReady = false;
                    self.refs.composer.value = '';
                    self.root.classList.toggle('composer');
                    self.update();
                } else {
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
                    showForumList();
                    break;
            }
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
</graphjs-forum-thread>