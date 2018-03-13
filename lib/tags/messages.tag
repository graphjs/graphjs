<graphjs-messages class="box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Messages'}</div>
    </div>
    <div class="content">
        <div class="sidebar" ref="partners">
            <a class={lastMessages[partnerId].is_read ? 'item' : 'unread item'} each={partnerId in partnerIds} data-partner={partnerId} onclick={displayConversation}>
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>{partnerId}</b>
                    {lastMessages[partnerId].message}
                </div>
            </a>
        </div>
        <div class="main">
            <div class="conversation" ref="messages">
                <div class={activeConversation[messageId].to == userId ? 'inbound item' : 'outbound item'} each={messageId in messageIds} data-message={messageId}>
                    <div>
                        <p>{activeConversation[messageId].message}</p>
                    </div>
                    <time>{activeConversation[messageId].timestamp}</time>
                </div>
            </div>
            <textarea placeholder="Write your message here..."></textarea>
        </div>
        <!--
        <div class="sidebar">
            <a class="active item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="unread item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="unread item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
        </div>
        <div class="main">
            <div class="conversation">
                <div class="inbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="outbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <div>
                        <p>It's a living hell.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="inbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <div>
                        <p>It's a living hell.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="outbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
            </div>
            -->
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages.less';
    </style>
    <script>
        import getInbox from '../scripts/getInbox.js';

        this.userId = '46b1e7a138c637eb62dd604bdb039bf8';
        this.lastMessages = {};
        this.partnerIds = [];
        this.activeConversation = {};
        this.messageIds = [];

        this.on('mount', function() {
            fetch('lib/data/sample/conversations.json')
            .then((response) => response.json())
            .then((results) => {
                if(results.success) {
                    this.lastMessages = results.messages;
                    this.partnerIds = Object.keys(this.lastMessages);
                    this.update();
                    this.tagUpdated = true;
                }
            })
            .catch((error) => {
                console.log(error);
            });
        });

        this.on('updated', function() {
            document.querySelector('.sidebar .active') || this.refs.partners.firstElementChild.click()
        });

        this.getConversation = (id) => {
            fetch('lib/data/sample/conversation.json')
            .then((response) => response.json())
            .then((results) => {
                if(results.success) {
                    this.activeConversation = results.messages;
                    this.messageIds = Object.keys(this.activeConversation);
                    this.update();
                }
            })
            .catch((error) => {
                console.log(error);
            });
        }

        this.displayConversation = (event) => {
            let anchors = event.target.parentNode.children;
            for(let anchor of anchors) {
                anchor.classList.remove('active');
            }
            event.target.classList.hasOwnProperty('active') || event.target.classList.add('active');
            let id = event.target.dataset.partner;
            this.getConversation(id);
        }

        /*
        // JSONP Hack
        fetch('http://phonetworks.com:1338/whoami')
        .then((response) => response.text())
        .then((results) => console.log(JSON.parse(results.slice(1, -1))))
        */
    </script>
</graphjs-messages>