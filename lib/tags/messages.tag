<graphjs-messages class={'graphjs-root graphjs-box'} style={
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
            <input ref="searchForPartners" onkeyup={handleFilter} class={!newMessageOption ? 'graphjs-hidden' : ''} type="text" placeholder="Type a name..." />
            <div class="graphjs-suggestions" if={newMessageOption && matchedPartners.length > 0}>
                <a each={matchedPartner in matchedPartners} data-id={matchedPartner.id} onclick={handleNewPartner}>
                    <img src={downsizeImage(matchedPartner.avatar, 40) || 'lib/images/avatars/user.png'} />
                    <b>{matchedPartner.username}</b>
                </a>
            </div>
            <div class="graphjs-list" ref="partners">
                <a class={'graphjs-item' + (list[partner] && list[partner].is_read ? '' : ' graphjs-unread') + (activePartner == partner ? ' graphjs-active' : '')} each={partner in partners} data-partner={partner} onclick={handleDisplay}>
                    <img src={list[partner] && list[partner].avatar ? downsizeImage(list[partner].avatar, 50) : 'lib/images/avatars/user.png'} />
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
            <textarea onkeyup={handleSubmit} placeholder="Write your message here..."></textarea>
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
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">Login to display messages</button>
    </div>
    <a class="graphjs-promo graphjs-bottom graphjs-right" href="http://graphjs.com" target="_blank">
        <svg viewBox="0 0 200 76" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g transform="translate(-620.000000, -18.000000)">
                <path fill="white" d="M674.455446,35.7851486 C670.318365,35.8917598 667.03137,36.6380379 667.03137,41.2223178 L667.03137,57.4805195 L657.623762,57.4805195 L657.623762,27.8959229 L666.464646,27.8959229 L666.464646,31.0409521 L666.577991,31.0409521 C668.221489,28.0025341 670.828416,26.8831169 674.455446,26.8831169 L674.455446,35.7851486 Z M708.118812,57.4555529 L698.942919,57.4555529 L698.942919,54.2598279 L698.832366,54.2598279 C697.174072,57.2957666 693.194167,58.4675325 689.877579,58.4675325 C680.425304,58.4675325 674.455446,51.4369374 674.455446,42.6486936 C674.455446,34.0202361 680.646409,26.8831169 689.877579,26.8831169 C693.249443,26.8831169 697.008243,28.1081448 698.832366,31.0375594 L698.942919,31.0375594 L698.942919,27.8950965 L708.118812,27.8950965 L708.118812,57.4555529 Z M699.207921,42.1556606 C699.207921,37.9181313 696.044608,34.7792208 691.701755,34.7792208 C687.358902,34.7792208 684.356436,38.127392 684.356436,42.2602909 C684.356436,46.2885595 687.573364,49.5844156 691.75537,49.5844156 C696.098224,49.5844156 699.207921,46.3408747 699.207921,42.1556606 Z M746.732673,42.9848228 C746.732673,51.2489434 740.703414,58.5000428 731.659524,58.5000428 C727.974977,58.5000428 724.848694,57.4337046 722.336502,54.8211762 L722.336502,67.3506494 L713.069307,67.3506494 L713.069307,27.8961381 L721.778238,27.8961381 L721.778238,31.1484694 L721.945717,31.1484694 C724.346256,28.2693565 727.807497,26.8831169 731.603698,26.8831169 C741.205852,26.8831169 746.732673,34.4008008 746.732673,42.9848228 Z M736.831683,42.2079758 C736.831683,38.0750769 733.46962,34.7792208 728.910891,34.7792208 C724.352162,34.7792208 720.990099,38.0750769 720.990099,42.2079758 C720.990099,46.2885595 724.409146,49.5844156 728.910891,49.5844156 C733.412636,49.5844156 736.831683,46.2885595 736.831683,42.2079758 Z M777.425743,57.4805195 L768.152664,57.4805195 L768.152664,41.3681994 C768.152664,38.1670762 767.203019,35.1793612 763.180993,35.1793612 C759.158967,35.1793612 757.985876,37.6869077 757.985876,41.048087 L757.985876,57.4805195 L748.712871,57.4805195 L748.712871,18 L757.985876,18 L757.985876,30.5910846 L758.097599,30.5910846 C759.717582,27.8167778 762.957547,26.8564409 766.08579,26.8564409 C769.102309,26.8564409 772.509859,27.8701299 774.520872,30.1109161 C777.48153,33.3653914 777.425669,36.8866269 777.425669,40.9413829 L777.425743,57.4805195 Z M781.386139,58.4675325 L781.386139,54.5194805 L785.346535,54.5194805 L785.346535,58.4675325 L781.386139,58.4675325 Z M784.536438,67.3506494 C783.67726,67.3506494 786.268605,67.3506494 784.523089,67.3506494 L784.523089,64.7049266 C786.093872,64.7049266 783.861369,64.7049266 784.536438,64.7049266 C786.745755,64.7049266 788.280003,63.3219351 788.280003,60.4356921 L788.280003,26.8831169 L791.287129,26.8831169 L791.287129,60.2553019 C791.287129,65.065707 788.586853,67.3506494 784.536438,67.3506494 Z M788.316832,23.9220779 L788.316832,18 L791.287129,18 L791.287129,23.9220779 L788.316832,23.9220779 Z M809.137199,58.4675325 C804.569886,58.4675325 799.570528,56.6238667 796.237624,53.9198236 L798.027517,51.5230581 C801.483863,54.1656457 805.310531,55.6405783 809.322361,55.6405783 C813.581072,55.6405783 816.913977,53.3052683 816.913977,49.6793923 L816.913977,49.5564813 C816.913977,45.8691497 812.963868,44.5171282 808.581715,43.2880176 C803.458917,41.813085 797.780635,40.2766969 797.780635,34.6842441 L797.780635,34.561333 C797.780635,29.5219799 802.039347,25.8961039 808.149672,25.8961039 C811.91462,25.8961039 816.173332,27.2481255 819.321075,29.3376133 L817.716343,31.8572899 C814.815482,29.9521686 811.359136,28.7230581 808.026231,28.7230581 C803.705799,28.7230581 800.866658,31.058368 800.866658,34.1925999 L800.866658,34.3155109 C800.866658,37.8184759 805.12537,39.1090419 809.630963,40.3996079 C814.692041,41.813085 820,43.6567508 820,49.1877481 L820,49.3106592 C820,54.903112 815.185804,58.4675325 809.137199,58.4675325 Z M644.223506,27.5368478 L649.921683,21.9480519 L656.12137,28.0287315 L650.410346,33.6301281 C653.873285,39.6947521 652.97562,47.5094104 647.71735,52.6667441 C646.76394,53.601852 645.72146,54.3963545 644.616695,55.0502516 L646.554631,62.1438924 C653.64101,62.234779 660.092324,66.9045865 662.016984,73.9496353 C664.337851,82.4449639 659.197676,91.1771075 650.536082,93.453424 C641.874487,95.7297404 632.971443,90.6882349 630.650576,82.1929063 C628.719812,75.1255165 631.952703,67.8942312 638.080998,64.3523626 L636.162765,57.3308403 C632.032091,57.3125692 627.90717,55.7578705 624.755545,52.6667441 C618.414818,46.4477319 618.414818,36.364721 624.755545,30.1457088 C630.03049,24.9720204 638.031978,24.1024 644.223506,27.5368478 Z M648.15907,84.8628715 C652.119469,83.8049934 654.469746,79.7468828 653.408561,75.7988279 C652.347375,71.850773 648.276576,69.5078218 644.316177,70.5656999 C640.355778,71.6235781 638.005501,75.6816886 639.066687,79.6297435 C640.127873,83.5777984 644.198671,85.9207496 648.15907,84.8628715 Z M631.085841,46.429232 C633.985774,49.3201261 638.687494,49.3201261 641.587427,46.429232 C644.487359,43.5383379 644.487359,38.8512725 641.587427,35.9603784 C638.687494,33.0694843 633.985774,33.0694843 631.085841,35.9603784 C628.185908,38.8512725 628.185908,43.5383379 631.085841,46.429232 Z"></path>
            </g>
        </svg>
    </a>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages.less';
    </style>
    <script>
        import getConversations from '../scripts/getConversations.js';
        import getConversation from '../scripts/getConversation.js';
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import sendMessage from '../scripts/sendMessage.js';
        import getMembers from '../scripts/getMembers.js';
        import showLogin from '../scripts/showLogin.js';
        
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

        this.on('before-mount', function() {
            this.handleUser();
            this.frequentlyUpdateTime = setInterval(this.handleTime,  60 * 1000);
            //GraphJSCallbacks
            if(!window.GraphJSCallbacks) {
                window.GraphJSCallbacks = {};
            }
            let self = this;
            window.GraphJSCallbacks['updateMessages'] = function() {
                self.blocked = false;
                self.update();
                self.handleUser();
            }
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
                    text = 'Error: Couldn\'t send message';
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
            let query = '.list a[data-partner="' + partner + '"]';
            this.update();
            document.querySelectorAll(query).length > 0 && document.querySelectorAll(query)[0].click();
        }
        this.handleTitle = (id) => {
            this.activePartnerName = this.list.length > 0 ? this.list[id].username : '';
            this.update();
        }
    </script>
</graphjs-messages>