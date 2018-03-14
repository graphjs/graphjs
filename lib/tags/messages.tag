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
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages.less';
    </style>
    <script>
        import getConversations from '../scripts/getConversations.js';
        this.handleConversations = () => {
            let self = this;
            getConversations(function(response) {
                if(response.success) {
                    self.lastMessages = response.messages;
                    self.partnerIds = Object.keys(self.lastMessages);
                    self.update();
                    self.tagUpdated = true;
                } else {
                    //Handle errors
                }
            });
        }
        import getConversation from '../scripts/getConversation.js';
        this.handleConversation = (id) => {
            let self = this;
            getConversation(id, function(response) {
                if(response.success) {
                    self.activeConversation = response.messages;
                    self.messageIds = Object.keys(self.activeConversation);
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }

        this.userId = '46b1e7a138c637eb62dd604bdb039bf8';
        this.lastMessages = {};
        this.partnerIds = [];
        this.activeConversation = {};
        this.messageIds = [];

        this.on('mount', function() {
            this.handleConversations();
        });

        this.on('updated', function() {
            document.querySelector('.sidebar .active') || this.refs.partners.firstElementChild.click()
        });

        /*
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
        */

        this.displayConversation = (event) => {
            let anchors = event.target.parentNode.children;
            for(let anchor of anchors) {
                anchor.classList.remove('active');
            }
            event.target.classList.hasOwnProperty('active') || event.target.classList.add('active');
            let id = event.target.dataset.partner;
            this.handleConversation(id);
        }

        /*
        // JSONP Hack
        fetch('http://phonetworks.com:1338/whoami')
        .then((response) => response.text())
        .then((results) => console.log(JSON.parse(results.slice(1, -1))))
        */
    </script>
</graphjs-messages>