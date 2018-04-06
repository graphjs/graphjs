<graphjs-forum-compose class={'root' + (opts.minor ? '' : ' box') + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')} onclick={blocked ? handleBlock : ''}>
    <div class="header">
        <div class="title">{opts.title || 'New Thread'}</div>
        <a class="option right" data-link="list" onclick={opts.minor ? handleCallback : handleShow}>
            <svg viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
                </g>
            </svg>
        </a>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul if={warningMessages.length > 0} class="fail">
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form>
            <input ref="title" type="text" placeholder="Enter your post title here..." />
            <textarea ref="body" placeholder="Compose your post here..."></textarea>
            <span>
                <b>Supported formats:</b> Markdown
            </span>
            <button data-link="thread" onclick={handleSubmit}>Publish</button>
            <button data-link="list" onclick={opts.minor ? handleCallback : handleShow} class="danger">Cancel</button>
        </form>
    </div>
    <a class="promo" href="http://graphjs.com">
        powered by <img src="lib/images/identity/logo.svg" />
    </a>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/forum-compose.less';
    </style>
    <script>
        import getUser from '../scripts/getUser.js';
        import startThread from '../scripts/startThread.js';
        import showForumList from '../scripts/showForumList.js';
        import showForumThread from '../scripts/showForumThread.js';
        import showLogin from '../scripts/showLogin.js';

        this.blocked = false;
        this.warningMessages = [];

        this.on('before-mount', function() {
            this.handleUser();
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
        this.checkTitle = () => {
            let warningMessage = 'Title is too short.';
            if(this.refs.title.value.length >= 10) {
                this.refs.title.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.title.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.checkTextBody = () => {
            let warningMessage = 'Text body is too short.';
            if(this.refs.body.value.length >= 10) {
                this.refs.body.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.body.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.validateForm = () => {
            let validTitle = this.checkTitle();
            let validTextBody = this.checkTextBody();
            return (
                validTitle &&
                validTextBody
            ) ? true : false;
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            let self = this;
            this.validateForm() && startThread(
                self.refs.title.value,
                self.refs.body.value,
                function(response) {
                    if(opts.minor) {
                        if(response.success) {
                            self.handleCallback({
                                link: 'thread',
                                id: response.id
                            });
                        } else {
                            //Handle error
                        }
                    } else {
                        if(response.success) {
                            showForumThread({
                                id: response.id
                            })
                        } else {
                            //Handle error
                        }
                    }
                }
            );
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
                case 'thread':
                    showForumThread({
                        id: dataset.id
                    });
                    break;
            }
        }
    </script>
</graphjs-forum-compose>