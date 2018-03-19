<graphjs-messages class="box">
    <div class="header">
        <div class="title">{this.activePartnerName.length > 0 ? 'Messages with ' +  this.activePartnerName : 'Messages'}</div>
        <a class="option left" onclick={handleNewMessage}>
            <svg class="new" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <path transform="translate(-755.000000, -15.000000)" d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
            </svg>
        </a>
    </div>
    <div class="content">
        <div class="sidebar">
            <input ref="searchForPartners" class={!newMessageOption && 'hidden'} type="text" placeholder="Type a name..." />
            <div class="list" ref="partners">
                <a class={list[partner] && list[partner].is_read ? 'item' : 'unread item'} each={partner in partners} data-partner={partner} onclick={handleDisplay}>
                    <img src={list[partner] && list[partner].avatar ? list[partner].avatar : 'lib/images/avatars/user.png'} />
                    <div>
                        <b>{list[partner] && list[partner].username}</b>
                        {list[partner] && list[partner].message}
                    </div>
                </a>
            </div>
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
            <textarea onselect={handleTextSelection} onclick={handleTextSelection} onkeyup={handleSubmit} placeholder="Write your message here..."></textarea>
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
            let text;
            for(let item of items) {
                if(item.dataset.hasOwnProperty('timestamp')) {
                    let timestamp = item.dataset.timestamp;
                    let time = Math.floor((Date.now() - (parseInt(timestamp) * 1000)) / 1000);
                    let amount;
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
                    } else if(time >= 60 * 60 * 24 * 30 * 12) {
                        amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                        text = amount == 1 ? amount + ' year' : amount + ' years';
                    } else {
                        //Handle errors
                    }
                } else {
                    text = 'Error: Couldn\'t send message'
                }
                item.innerHTML = text;
                item.classList.add('error');
            }
        }
        this.handleSubmit = (event) => {
            let self = this;
            if (event.keyCode == 13) {
                event.preventDefault();
                let value = event.target.value.replace(/\n+/g, '\n'); // Removes repetitive line breaks
                if(!event.shiftKey) {
                    event.target.value = '';
                    let randomNumber = Math.floor(Math.random() * 1000000);
                    self.activeMessages[randomNumber] = {from: this.userId, is_read: false, message: value, timestamp: false, to: this.activePartner};
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
                    sendMessage(self.activePartner, encodeURI(value), function(response) {
                        if(response.success) {
                            self.handleConversation(self.activePartner);
                        } else {
                            //Handle errors
                        }
                    });
                }
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
            this.handleTitle(id);
        }
        this.handleNewMessage = (event) => {
            event.target.firstElementChild.classList.toggle('new');
            this.newMessageOption = this.newMessageOption ? false : true;
            this.newMessageOption && this.refs.searchForPartners.focus();
        }
        this.handleTitle = (id) => {
            let query = 'a[data-partner="' + id + '"] b';
            this.activePartnerName = document.querySelectorAll(query)[0].innerHTML;
            this.update();
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
        this.activePartnerName = '';
        this.partners = [];
        this.activeMessages = {};
        this.messages = [];
        this.list = [];
        this.frequentlyUpdateTime;
        this.newMessageOption = false;
        this.selectedTextLength = 0;

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