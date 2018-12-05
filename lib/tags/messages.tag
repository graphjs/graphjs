<graphjs-messages class={'graphjs-element graphjs-root ' + boxStyle} style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <div class="graphjs-header">
        <a class="graphjs-option graphjs-left" onclick={handleNewMessage} if={loaded}>
            <svg class={newMessageOption ? '' : 'graphjs-new'} viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <path transform="translate(-755.000000, -15.000000)" d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
            </svg>
        </a>
        <div class="graphjs-title">{'Messages' + (activePartnerName != '' ? ' with ' +  activePartnerName : '')}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div class="graphjs-sidebar">
            <input ref="searchForPartners" onkeyup={handleFilter} class={!newMessageOption ? 'graphjs-hidden' : ''} type="text" placeholder={i18n.nameSearchPlaceholder} />
            <div class="graphjs-suggestions" if={newMessageOption && matchedPartners.length > 0}>
                <a each={matchedPartner in matchedPartners} data-id={matchedPartner.id} onclick={handleNewPartner}>
                    <img src={matchedPartner.avatar ? downsizeImage(matchedPartner.avatar, 40) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                    <b>{matchedPartner.username}</b>
                </a>
            </div>
            <div class="graphjs-list" ref="partners">
                <a class={'graphjs-item' + (list[partner] && list[partner].is_read ? '' : ' graphjs-unread') + (activePartner == partner ? ' graphjs-active' : '')} each={partner in partners} data-partner={partner} onclick={handleDisplay}>
                    <img src={list[partner] && list[partner].avatar ? downsizeImage(list[partner].avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                    <div>
                        <b>{list[partner] && list[partner].username}</b>
                        {list[partner] && list[partner].message}
                    </div>
                </a>
            </div>
        </div>
        <div class="graphjs-main">
            <div class="graphjs-conversation" ref="messages">
                <div class={activeMessages[message].to == userId ? 'graphjs-inbound graphjs-item' : 'graphjs-outbound graphjs-item'} each={message in messages} data-message={message}>
                    <div>
                        <p>{activeMessages[message].message}</p>
                    </div>
                    <time data-timestamp={activeMessages[message].timestamp}></time>
                </div>
            </div>
            <textarea onkeyup={handleSubmit} placeholder={i18n.messageInputPlaceholder}></textarea>
        </div>
        <div if={!loaded} class="graphjs-placeholder graphjs-loader">
            <div class="graphjs-left">
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <hr class="graphjs-fill" />
                <div class="graphjs-user">
                    <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    <div class="graphjs-information">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
            </div>
            <hr class="graphjs-vertical graphjs-fill" />
            <div class="graphjs-right">
                <div class="graphjs-message">
                    <div class="graphjs-text graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-message">
                    <div class="graphjs-text graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-message">
                    <div class="graphjs-text graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-message">
                    <div class="graphjs-text graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                </div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <graphjs-promo properties="bottom right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getConversations from '../scripts/getConversations.js';
        import getConversation from '../scripts/getConversation.js';
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import sendMessage from '../scripts/sendMessage.js';
        import getMembers from '../scripts/getMembers.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("messages");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['messages'];
        i18n = {...i18n,...opts}
        this.i18n = i18n;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.userId = '';
        this.activePartner = '';
        this.activePartnerName = '';
        this.partners = [];
        this.possiblePartnersData = {}
        this.possiblePartners = [];
        this.matchedPartners = [];
        this.activeMessages = {};
        this.messages = [];
        this.list = [];
        this.frequentlyUpdateTime;
        this.newMessageOption = false;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';

        this.on('before-mount', function() {
            this.handleUser();
            this.frequentlyUpdateTime = setInterval(this.handleTime,  60 * 1000);
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });
        this.on('updated', function() {
            if(this.activePartner == '') {
                if(this.refs.partners.firstElementChild) {
                    this.activePartner = this.refs.partners.firstElementChild.dataset.partner;
                    this.update();
                    this.refs.partners.firstElementChild.click();
                }
            }
            if(!this.activePartnerName && this.activePartnerName == '') {
                this.activePartnerName = this.list.hasOwnProperty(this.activePartner) ? this.list[this.activePartner].username : '';
            }
            this.refs.messages.scrollTop = this.refs.messages.scrollHeight;
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
                    self.handleConversations();
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
            showLogin({
                action: 'updateMessages'
            });
        }
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
                            avatar: response.profile.avatar,
                            username: response.profile.username,
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
            self.loaded = true;
            self.update();
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
                        text = i18n.messageTimeNowText;
                    } else if(1 <= time && time < 60) {
                        amount = time;
                        text = i18n.messageTimeSecondsText.replace('%s',amount);
                    } else if(60 <= time && time < 60 * 60) {
                        amount = Math.floor(time / 60);
                        text = i18n.messageTimeMinutesText.replace('%s',amount);
                    } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                        amount = Math.floor(time / 60 / 60);
                        text = i18n.messageTimeHoursText.replace('%s',amount);
                    } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                        amount = Math.floor(time / 60 / 60 / 24);
                        text = i18n.messageTimeDaysText.replace('%s',amount);
                    } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                        amount = Math.floor(time / 60 / 60 / 24 / 7);
                        text = i18n.messageTimeWeeksText.replace('%s',amount);
                    } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                        amount = Math.floor(time / 60 / 60 / 24 / 30);
                        text = i18n.messageTimeMonthsText.replace('%s',amount);
                    } else if(time >= 60 * 60 * 24 * 30 * 12) {
                        amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                        text = i18n.messageTimeYearsText.replace('%s',amount);
                    } else {
                        //Handle errors
                    }
                } else {
                    text = i18n.failErrorText;
                    item.classList.add('graphjs-error');
                }
                item.innerHTML = text;
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
                    self.activeMessages[randomNumber] = {from: self.userId, is_read: false, message: value, timestamp: false, to: self.activePartner};
                    self.messages.push(randomNumber);
                    self.refs.messages.scrollTop = self.refs.messages.scrollHeight;
                    self.partners.sort(function(x, y) {
                        return x == self.activePartner ? -1 : y == self.activePartner ? 1 : 0;
                    });
                    self.update();
                    let anchors = self.refs.partners.children;
                    for(let anchor of anchors) {
                        anchor.classList.remove('graphjs-active');
                    }
                    let anchorsBox = self.refs.partners;
                    anchorsBox.firstElementChild.classList.add('graphjs-active') || anchorsBox.firstElementChild.classList.add('graphjs-active');
                    let box = anchorsBox.firstElementChild.lastElementChild;
                    let title = box.firstElementChild;
                    let text = document.createTextNode(value);
                    box.innerHTML = '';
                    box.appendChild(title)
                    box.appendChild(text);
                    sendMessage(self.activePartner, value, function(response) {
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
            let id = event.target.dataset.partner;
            this.activePartner = id;
            let anchors = this.refs.partners.children;
            this.newMessageOption = false;
            this.matchedPartners = [];
            for(let anchor of anchors) {
                anchor.classList.remove('graphjs-active');
            }
            if(this.list.hasOwnProperty(id)) {
                this.list[id].is_read = true;
            }
            event.target.classList.remove('graphjs-unread');
            event.target.classList.add('graphjs-active');
            this.handleConversation(id);
            this.handleTitle(id);
        }
        this.handleNewMessage = (event) => {
            this.refs.searchForPartners.value = '';
            this.matchedPartners = [];
            this.newMessageOption = this.newMessageOption ? false : true;
            this.newMessageOption && this.refs.searchForPartners.focus();
            this.handlePossiblePartners();
            this.update();
        }
        this.handlePossiblePartners = () => {
            let self = this;
            Object.keys(self.possiblePartners).length > 0 || getMembers(function(response) {
                if(response.success) {
                    self.possiblePartnersData = response.members;
                    for(let member of Object.keys(response.members)) {
                        let item = {
                            id: member,
                            username: response.members[member].username,
                            avatar: response.members[member].avatar
                        }
                        self.possiblePartners.push(item);
                    }
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleFilter = (event) => {
            let self = this;
            self.matchedPartners = self.possiblePartners.filter(item => item.username.toLowerCase().startsWith(event.target.value.toLowerCase()));
        }
        this.handleNewPartner = (event) => {
            this.newMessageOption = false;
            let partner = event.target.dataset.id;
            let data = this.possiblePartnersData[partner];
            let message;
            if(this.partners.includes(partner)) {
                let index = this.partners.indexOf(partner);
                this.partners.splice(index, 1);
                message = this.list[partner].message || '';
            }
            this.partners.unshift(partner);
            this.list[partner] = {
                partner: partner,
                avatar: data.avatar,
                username: data.username,
                message: message,
                is_read: true
            };
            this.update();
            let query = 'a[data-partner="' + partner + '"]';
            document.querySelectorAll(query).length > 0 && document.querySelectorAll(query)[0].click();
        }
        this.handleTitle = (id) => {
            this.activePartnerName = this.list.length > 0 ? this.list[id].username : '';
            this.update();
        }
    </script>
</graphjs-messages>