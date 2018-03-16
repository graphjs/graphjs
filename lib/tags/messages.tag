<graphjs-messages class="box">
    <div class="header">
        <!--
        <a class="option left" data-link="compose" onclick={opts.minor ? opts.callback : ''}>
            <svg viewBox="0 0 48 49" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <path d="M6.99999997,8 C-2.34864061,17.3811577 -2.33107019,32.561963 7.03926101,41.9214552 C16.4095922,51.2809474 31.5904076,51.2809474 40.9607388,41.9214552 C50.33107,32.561963 50.3486404,17.3811577 40.9999998,8 C36.4967549,3.48109156 30.3796353,0.941074346 23.9999999,0.941074346 C17.6203645,0.941074346 11.5032449,3.48109156 6.99999997,8 Z M38.14,39.14 C32.4205153,44.8612123 23.8176848,46.5734345 16.3434555,43.4781684 C8.86922619,40.3829024 3.99572907,33.0897945 3.99572907,25 C3.99572907,16.9102055 8.86922619,9.6170976 16.3434555,6.52183155 C23.8176848,3.4265655 32.4205153,5.13878771 38.14,10.86 C45.9476388,18.669997 45.9476388,31.330003 38.14,39.14 Z"></path>
                <path d="M32,23 L26,23 L26,17 C26,15.8954305 25.1045695,15 24,15 C22.8954305,15 22,15.8954305 22,17 L22,23 L16,23 C14.8954305,23 14,23.8954305 14,25 C14,26.1045695 14.8954305,27 16,27 L22,27 L22,33 C22,34.1045695 22.8954305,35 24,35 C25.1045695,35 26,34.1045695 26,33 L26,27 L32,27 C33.1045695,27 34,26.1045695 34,25 C34,23.8954305 33.1045695,23 32,23 Z"></path>
            </svg>
        </a>
        -->
        <div class="title">{opts.title || 'Messages'}</div>
    </div>
    <div class="content">
        <!--
        <div class="sidebar" ref="partners">
            <a class={item.is_read ? 'item' : 'unread item'} each={item in list} data-partner={item.partner} onclick={handleDisplay}>
                <img src={item.avatar || 'lib/images/avatars/user.png'} />
                <div>
                    <b>{item.username}</b>
                    {item.message}
                </div>
            </a>
        </div>
        -->
        <div class="sidebar" ref="partners">
            <a class={list[partner] && list[partner].is_read ? 'item' : 'unread item'} each={partner in partners} data-partner={partner} onclick={handleDisplay}>
                <img src={list[partner] && list[partner].avatar ? list[partner].avatar : 'lib/images/avatars/user.png'} />
                <div>
                    <b>{list[partner] && list[partner].username}</b>
                    {list[partner] && list[partner].message}
                </div>
            </a>
        </div>
        <div class="main">
            <div class="conversation" ref="messages">
                <div class={activeMessages[message].to == userId ? 'inbound item' : 'outbound item'} each={message in messages} data-message={message}>
                    <div>
                        <p>{activeMessages[message].message}</p>
                    </div>
                    <time data-timestamp={activeMessages[message].timestamp}></time>
                </div>
            </div>
            <textarea onkeyup={handleSubmit} placeholder="Write your message here..."></textarea>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages.less';
    </style>
    <script>
        import getConversations from '../scripts/getConversations.js';
        import getConversation from '../scripts/getConversation.js';
        import getUser from '../scripts/getUser.js';
        import getProfile from '../scripts/getProfile.js';
        import sendMessage from '../scripts/sendMessage.js';

        this.handleConversations = () => {
            let self = this;
            getConversations(function(response) {
                if(response.success) {
                    self.handleList(response.messages);
                } else {
                    //Handle errors
                }
            });
        }
        this.handleConversation = (id) => {
            let self = this;
            getConversation(id, function(response) {
                if(response.success) {
                    self.activePartner = id;
                    self.activeMessages = response.messages;
                    self.messages = Object.keys(self.activeMessages).reverse();
                    self.update();
                    self.handleTime();
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleList = (messages) => {
            let self = this;
            self.list = [];
            self.partners = Object.keys(messages).reverse();
            for(let partner of self.partners) {
                getProfile(partner, function(response) {
                    if(response.success) {
                        let item = {
                            partner: partner,
                            avatar: response.profile.Avatar,
                            username: response.profile.Username,
                            message: messages[partner].message,
                            is_read: messages[partner].is_read
                        }
                        self.list[partner] = item;
                    } else {
                        //Handle errors
                    }
                    self.update();
                });
            }
        }
        this.handleTime = () => {
            let items = document.querySelectorAll('graphjs-messages time');
            for(let item of items) {
                let timestamp = item.dataset.timestamp;
                let time = Math.floor((Date.now() - (parseInt(timestamp) * 1000)) / 1000);
                let amount;
                let text;
                if(time < 1) {
                    amount = time;
                    text = 'Now';
                } else if(1 <= time && time < 60) {
                    amount = time;
                    text = amount == 1 ? amount + ' second' : amount + ' seconds';
                } else if(60 <= time && time < 60 * 60) {
                    amount = Math.floor(time / 60);
                    text = amount == 1 ? amount + ' minute' : amount + ' minutes';
                } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                    amount = Math.floor(time / 60 / 60);
                    text = amount == 1 ? amount + ' hour' : amount + ' hours';
                } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                    amount = Math.floor(time / 60 / 60 / 24);
                    text = amount == 1 ? amount + ' day' : amount + ' days';
                } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                    amount = Math.floor(time / 60 / 60 / 24 / 7);
                    text = amount == 1 ? amount + ' week' : amount + ' weeks';
                } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                    amount = Math.floor(time / 60 / 60 / 24 / 30);
                    text = amount == 1 ? amount + ' month' : amount + ' months';
                } else {
                    amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                    text = amount == 1 ? amount + ' year' : amount + ' years';
                }
                item.innerHTML = text;
            }
        }
        this.handleSubmit = (event) => {
            let self = this;
            if (event.keyCode == 13) {
                let value = event.target.value;
                event.target.value = '';
                let randomNumber = Math.floor(Math.random() * 1000000);
                self.activeMessages[randomNumber] = {from: this.userId, is_read: false, message: value, timestamp: Date.now(), to: this.activePartner};
                self.messages.push(randomNumber);
                self.refs.messages.scrollTop = self.refs.messages.scrollHeight;
                self.partners.sort(function(x, y) {
                    return x == self.activePartner ? -1 : y == self.activePartner ? 1 : 0;
                });
                self.update();
                let anchors = self.refs.partners.children;
                for(let anchor of anchors) {
                    anchor.classList.remove('active');
                }
                let firstAnchor = self.refs.partners;
                firstAnchor.firstElementChild.classList.add('active') || firstAnchor.firstElementChild.classList.add('active');
                sendMessage(self.activePartner, value, function(response) {
                    if(response.success) {
                        self.handleConversation(self.activePartner);
                    } else {
                        //Handle errors
                    }
                });
            }
        }
        this.handleDisplay = (event) => {
            let anchors = this.refs.partners.children;
            for(let anchor of anchors) {
                anchor.classList.remove('active');
            }
            event.target.classList.hasOwnProperty('unread') || event.target.classList.remove('unread');
            event.target.classList.hasOwnProperty('active') || event.target.classList.add('active');
            let id = event.target.dataset.partner;
            this.handleConversation(id);
        }
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

        this.userId = '';
        this.activePartner = '';
        this.partners = [];
        this.activeMessages = {};
        this.messages = [];
        this.list = [];
        this.frequentlyUpdateTime;

        this.on('mount', function() {
            this.handleUser();
            this.handleConversations();
            this.frequentlyUpdateTime = setInterval(this.handleTime,  60 * 1000);
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });

        this.on('updated', function() {
            document.querySelector('.sidebar .active') || this.refs.partners.firstElementChild.click()
            this.refs.messages.scrollTop = this.refs.messages.scrollHeight;
        });

    </script>
</graphjs-messages>