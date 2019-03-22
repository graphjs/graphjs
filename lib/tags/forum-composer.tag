<graphjs-forum-composer
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header">
        <div class="graphjs-title">{language.title}</div>
        <a class="graphjs-option graphjs-right" data-link="list" onclick={opts.minor ? handleCallback : handleShow}>
            <svg viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
                </g>
            </svg>
        </a>
    </div>
    <div class="graphjs-warning" if={warningMessages.length > 0}>
        <ul if={warningMessages.length > 0} class="graphjs-fail">
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <form>
            <input ref="title" type="text" placeholder={language.titleInputPlaceholder} />
            <textarea ref="body" placeholder={language.composerInputPlaceholder}></textarea>
            <span style="visibility: hidden">
                <b style="visibility: hidden">Supported formats:</b> Markdown
            </span>
            <button ref="submit" data-link="thread" onclick={handleSubmit}>{language.submitButton}</button>
            <button data-link="list" onclick={opts.minor ? handleCallback : handleShow} class="graphjs-danger">{language.cancelButton}</button>
        </form>
        <div if={!loaded && !blocked} class="graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{language.loginButton}</button>
    </div>
    <graphjs-promo if={loaded} properties="bottom left"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import language from '../scripts/language.js';
        import getSession from '../scripts/getSession.js';
        import startThread from '../scripts/startThread.js';
        import showForumList from '../scripts/showForumList.js';
        import showForumThread from '../scripts/showForumThread.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("forum-composer");

        this.language = language('forum-composer', opts);

        this.blocked = false;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.warningMessages = [];

        this.on('before-mount', function() {
            this.handleUser();
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
            showLogin({
                action: 'updateForumCompose'
            });
        }
        this.checkTitle = () => {
            let warningMessage = this.language.titleWarning;
            if(this.refs.title.value.length >= 1) {
                this.refs.title.classList.remove('graphjs-error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.title.classList.add('graphjs-error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.checkTextBody = () => {
            let warningMessage = this.language.textWarning;
            if(this.refs.body.value.length >= 1) {
                this.refs.body.classList.remove('graphjs-error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.body.classList.add('graphjs-error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.validateForm = () => {
            let validTitle = this.checkTitle();
            let validTextBody = this.checkTextBody();
            if(
                validTitle && validTextBody
            ) {
                return true;
            } else {
                this.refs.submit.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.add('graphjs-loading');
            this.validateForm() && startThread(
                self.refs.title.value,
                self.refs.body.value,
                function(response) {
                    if(response.success) {
                        if(opts.minor) {
                            self.refs.submit.classList.remove('graphjs-loading');
                            self.handleCallback({
                                link: 'thread',
                                id: response.id
                            });
                        } else {
                            self.refs.submit.classList.remove('graphjs-loading');
                            showForumThread({
                                id: response.id,
                                scroll: true
                            });
                        }
                    } else {
                        self.refs.submit.classList.remove('graphjs-loading');
                        self.update();
                        if(response.reason)
                            window.alert(self.language.serverError.replace('%s',response.reason));
                        //Handle error
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
                    showForumList({
                        scroll: true
                    });
                    break;
                case 'thread':
                    showForumThread({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
    </script>
</graphjs-forum-composer>