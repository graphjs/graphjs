<graphjs-messages-composer class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}>
    <div class="graphjs-header">
        <div class="graphjs-title">{i18n.title}</div>
        <a if={opts.close} class="graphjs-option graphjs-right" onclick={handleOverlay}>
            <svg viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-755.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M768.138179,30.0276818 L763.8,25.6895028 L765.689503,23.8 L770.011119,28.1447263 L774.332735,23.8 L776.222238,25.6895028 L771.884059,30.0276818 L771.888398,30.0320442 L771.884064,30.0363784 L776.222238,34.3414365 L774.332735,36.2309392 L770.011119,31.9093232 L765.689503,36.2309392 L763.8,34.3414365 L768.138174,30.0363784 L768.13384,30.0320442 L768.138179,30.0276818 Z M769.983425,15 C778.270718,15 785,21.6961326 785,29.9834254 C785,38.2707182 778.270718,45 769.983425,45 C761.696133,45 755,38.2707182 755,29.9834254 C755,21.6961326 761.696133,15 769.983425,15 Z M769.983425,42.3480663 C776.779006,42.3480663 782.348066,36.8121547 782.348066,29.9834254 C782.348066,23.1878453 776.812155,17.6187845 769.983425,17.6187845 C763.187845,17.6187845 757.618785,23.1546961 757.618785,29.9834254 C757.651934,36.7790055 763.187845,42.3480663 769.983425,42.3480663 Z"></path>
                </g>
            </svg>
        </a>
    </div>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div if={recipient && userId} class={'graphjs-recipient' + (recipient ? '' : ' graphjs-unknown')} data-recipientlabel={i18n.recipientLabel}>{profile ? profile.username : i18n.noRecipientText}</div>
        <input if={anonymity && !userId} ref="email" type="text" placeholder={i18n.emailPlaceholder}/>
        <form>
            <textarea ref="message" placeholder={opts.placeholder || i18n.messagePlaceholder}></textarea>
            <button ref="submitMessage" onclick={handleMessage}>{i18n.submitButtonText}</button>
            <button if={opts.clear} onclick={handleClear} class="graphjs-danger">{i18n.clearButtonText}</button>
        </form>
        <div if={!loaded && !blocked} class="graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <div class="graphjs-check">
        <svg class="graphjs-checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="graphjs-checkmark_circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="graphjs-checkmark_check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
    </div>
    <graphjs-promo properties="bottom left"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import sendMessage from '../scripts/sendMessage.js';
        import sendAnonymousMessage from '../scripts/sendAnonymousMessage.js';
        import hideOverlay from '../scripts/hideOverlay.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("messages-composer");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['messages-composer'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        this.loaded = false;
        this.failMessages = [];
        this.recipient = opts.to;
        this.anonymity = opts.anonymity == 'on' ? true : false;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';

        this.on('before-mount', function() {
            this.handleUser();
            this.handleRecipient();
        });
        this.on('mount', function() {
            opts.autofocus === 'on' && this.refs.message.focus();
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
                    if(self.anonymity) {
                        self.loaded = true;
                        self.update();
                    } else {
                        self.loaded = false;
                        self.blocked = true;
                        self.update();
                    }
                    //Handle errors
                }
            });
        }
        this.handleRecipient = () => {
            let self = this;
            self.recipient && getProfile(self.recipient, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleMessage = (event) => {
            let self = this;
            event.preventDefault();
            self.refs.submitMessage.classList.add('graphjs-loading');
            let value = self.refs.message.value.replace(/\n+/g, '\n'); // Removes repetitive line breaks
            if(self.anonymity != true) {
                sendMessage(self.recipient, value, function(response) {
                    if(response.success) {
                        self.refs.submitMessage.classList.remove('graphjs-loading');
                        self.checked = true;
                        self.update();
                        if(document.querySelector('graphjs-overlay')) {
                            setTimeout(function() {
                                self.handleOverlay();
                            }, 2500);
                        } else {
                            setTimeout(function() {
                                self.handleRestart();
                            }, 5000);
                        }
                    } else {
                        //Handle errors
                    }
                });
            } else {
                if(self.checkEmailPattern()) {
                    sendAnonymousMessage(self.refs.email.value, self.recipient, value, function(response) {
                        if(response.success) {
                            self.refs.submitMessage.classList.remove('graphjs-loading');
                            self.checked = true;
                            self.update();
                            setTimeout(function() {
                                if(document.querySelector('graphjs-overlay')) {
                                    self.hideOverlay();
                                }
                                self.handleRestart();
                            }, 5000);
                        } else {
                            //Handle errors
                        }
                    });
                }
            }
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.message.value = '';
            this.refs.message.focus();
        }
        this.handleRestart = () => {
            if(this.refs.email) {
                this.refs.email.value = '';
            }
            this.refs.message.value = '';
            this.checked = false;
            this.update();
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateMessagesComposer'
            });
        }
        this.checkEmailPattern = () => {
            let failMessage = i18n.emailPatternErrorText;
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(emailPattern.test(this.refs.email.value)) {
                this.refs.email.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.email.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.handleOverlay = () => hideOverlay();
    </script>
</graphjs-messages-composer>
