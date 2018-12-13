<graphjs-auth-register class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Register'}</div>
    </div>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <form>
            <input ref="username" type="text" placeholder={i18n.usernamePlaceholder}/>
            <input ref="email" type="text" placeholder={i18n.emailPlaceholder}/>
            <input ref="password" type="password" placeholder={i18n.passwordPlaceholder}/>
            <input ref="confirmation" type="password" placeholder={i18n.confirmPasswordPlaceholder}/>
            <button ref="submit" onclick={handleSubmit}>{i18n.submitButtonText}</button>
            <div class="graphjs-option graphjs-single">
                <a data-link="login" onclick={opts.minor ? opts.callback : handleLoginBox}>{i18n.loginLinkText}</a>
            </div>
        </form>
    </div>
    <div class="graphjs-check">
        <svg class="graphjs-checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="graphjs-checkmark_circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="graphjs-checkmark_check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
    </div>
    <graphjs-promo properties="bottom right" detach={opts.box === 'disabled'}></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import register from '../scripts/register.js';
        import login from '../scripts/login.js';
        import showAlert from '../scripts/showAlert.js';
        import showLogin from '../scripts/showLogin.js';
        import hideOverlay from '../scripts/hideOverlay.js';

        analytics("auth-register");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['auth-register'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline' + (opts.box === 'disabled' ? ' graphjs-promo-pad' : '')
            : 'graphjs-box';

        this.handleLoginBox = () => showLogin();

        this.failMessages = [];

        this.checkUsernameMinimumLength = () => {
            let usernameMinimumLengthLimit = 1;
            let failMessage = i18n.usernameMinLengthErrorText;
            if(this.refs.username.value.length >= usernameMinimumLengthLimit) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernameMaximumLength = () => {
            let usernameMaximumLengthLimit = 36;
            let failMessage = i18n.usernameMaxLengthErrorText.replace('%s',usernameMaximumLengthLimit);
            if(this.refs.username.value.length <= usernameMaximumLengthLimit) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernamePattern = () => {
            let failMessage = i18n.usernamePatternErrorText;
            let usernamePattern = /^[a-zA-Z0-9-_]+$/;
            if(usernamePattern.test(this.refs.username.value)) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
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
        this.checkPasswordMinimumLength = () => {
            let passwordMinimumLengthLimit = 5;
            let failMessage = i18n.passwordMinLengthErrorText.replace('%s',passwordMinimumLengthLimit);
            if(this.refs.password.value.length >= passwordMinimumLengthLimit) {
                this.refs.password.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMaximumLength = () => {
            let passwordMaximumLengthLimit = 255;
            let failMessage = i18n.passwordMaxLengthErrorText.replace('%s',passwordMaximumLengthLimit);
            if(this.refs.password.value.length <= passwordMaximumLengthLimit) {
                this.refs.password.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMatch = () => {
            let failMessage = i18n.passwordMatchErrorText;
            if(this.refs.password.value == this.refs.confirmation.value) {
                this.refs.confirmation.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.confirmation.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.validateInformation = () => {
            let validUsernameMinimumLength = this.checkUsernameMinimumLength();
            let validUsernameMaximumLength = this.checkUsernameMaximumLength();
            let validUsernamePattern = this.checkUsernamePattern();
            let validEmailPattern = this.checkEmailPattern();
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            let validPasswordMaximumLength = this.checkPasswordMaximumLength();
            let validPasswordMatch = this.checkPasswordMatch();
            if(
                validUsernameMinimumLength && validUsernameMaximumLength && validUsernamePattern && // Username
                validEmailPattern && // Email
                validPasswordMinimumLength && validPasswordMaximumLength && validPasswordMatch // Password
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
            let username = self.refs.username.value;
            let email = self.refs.email.value;
            let password = self.refs.password.value;
            self.refs.username.className = '';
            self.refs.email.className = '';
            self.refs.password.className = '';
            self.failMessages = [];
            if(self.validateInformation()) {
            	register(
            		username,
            		email,
            		password,
                    function(response) {
                        if(response.success) {
                            //Auto-Login
                            login(
                                username,
                                password,
                                function(response) {
                                    if(response.success) {
                                        self.checked = true;
                                        self.refs.submit.classList.remove('graphjs-loading');
                                        self.update();
                                        Array.from(document.getElementsByClassName('graphjs-element')).forEach((item) => {
                                            item._tag && item._tag.restart && item._tag.restart();
                                        });
                                        if(opts.minor) {
                                            opts.callback();
                                            opts.refresh();
                                        } else {
                                            setTimeout(function() {
                                                hideOverlay();
                                            }, 2500);
                                        }
                                        /*
                                        showAlert({
                                            'title': 'Register Successful!',
                                            'message': 'You are successfully registered and automatically logged in.'
                                        });
                                        */
                                    } else {
                                        self.refs.submit.classList.remove('graphjs-loading');
                                        showAlert({
                                            'title': 'Register Successful!',
                                            'message': 'Please login to continue.',
                                            'affirmative': 'Login',
                                            'negative': 'Cancel',
                                            'show': 'login'
                                        });
                                    }
                                }
                            );
                        } else {
                            let failMessage = response.reason || 'We couldn\'t register you.';
                            self.failMessages = [];
                            self.failMessages.push(failMessage);
                            self.refs.username.className = 'graphjs-error';
                            self.refs.email.className = 'graphjs-error';
                            self.refs.password.className = 'graphjs-error';
                            self.refs.confirmation.className = 'graphjs-error';
                            self.refs.submit.classList.remove('graphjs-loading');
                            self.update();
                        }
                    }
            	);
            }
        }
    </script>
</graphjs-auth-register>
