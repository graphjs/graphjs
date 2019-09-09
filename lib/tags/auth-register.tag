<graphjs-auth-register
    class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}
>
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
            <input ref="username" type="text" placeholder={language.usernamePlaceholder} autofocus/>
            <input ref="email" type="text" placeholder={language.emailPlaceholder} />
            <input if={customQuestion1} ref="customQuestion1" type="text" placeholder={customQuestion1}/>
            <input if={customQuestion2} ref="customQuestion2" type="text" placeholder={customQuestion2}/>
            <input if={customQuestion3} ref="customQuestion3" type="text" placeholder={customQuestion3}/>
            <input ref="password" type="password" placeholder={language.passwordPlaceholder} autocomplete="off" />
            <input ref="confirmation" type="password" placeholder={language.confirmPasswordPlaceholder} autocomplete="off" />
            <button ref="submit" onclick={handleSubmit}>{language.submitButton}</button>
            <div class="graphjs-option graphjs-single">
                <a data-link="login" onclick={opts.minor ? opts.callback : handleLoginBox}>{language.loginLink}</a>
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
        import language from '../scripts/language.js';
        import register from '../scripts/register.js';
        import login from '../scripts/login.js';
        import showAlert from '../scripts/showAlert.js';
        import showLogin from '../scripts/showLogin.js';
        import showVerify from '../scripts/showVerify.js';
        import hideOverlay from '../scripts/hideOverlay.js';
        import getCustomFields from '../scripts/getCustomFields.js';
        

        analytics("auth-register");

        this.language = language('auth-register', opts);

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';

        this.handleLoginBox = () => showLogin();

        this.failMessages = [];

        this.customQuestion1 = "";
        this.customQuestion1Must = false;
        this.customQuestion2 = "";
        this.customQuestion1Must = false;
        this.customQuestion3 = "";
        this.customQuestion1Must = false;

        this.on('before-mount', function() {
            this.handleCustomFields();
        });
        this.handleCustomFields = () => {
            let self=this;
            getCustomFields(function(response) {
                if(response.success) {
                    self.customQuestion1 = response.custom_field1;
                    self.customQuestion2 = response.custom_field2;
                    self.customQuestion3 = response.custom_field3;
                    self.customQuestion1Must = !!response.custom_field1_must;
                    self.customQuestion2Must = !!response.custom_field2_must;
                    self.customQuestion3Must = !!response.custom_field3_must;
                }
                self.update();
            });
        }

        this.checkUsernameMinimumLength = () => {
            let usernameMinimumLengthLimit = 1;
            let failMessage = language.usernameMinLengthError;
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
            let failMessage = this.language.usernameMaxLengthError.replace('%s',usernameMaximumLengthLimit);
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
            let failMessage = this.language.usernamePatternError;
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
        this.checkCustomQuestions = () => {
            const failMessage = this.language.customQuestionError;
            const customQ1FailMessage = failMessage.replace('%s','1');
            const customQ2FailMessage = failMessage.replace('%s','2');
            const customQ3FailMessage = failMessage.replace('%s','3');
            this.refs.customQuestion1 && this.refs.customQuestion1.classList.remove('graphjs-error');
            this.refs.customQuestion2 && this.refs.customQuestion2.classList.remove('graphjs-error');
            this.refs.customQuestion3 && this.refs.customQuestion3.classList.remove('graphjs-error');
            this.failMessages.includes(customQ1FailMessage) && this.failMessages.splice(this.failMessages.indexOf(customQ1FailMessage), 1);
            this.failMessages.includes(customQ2FailMessage) && this.failMessages.splice(this.failMessages.indexOf(customQ2FailMessage), 1);
            this.failMessages.includes(customQ3FailMessage) && this.failMessages.splice(this.failMessages.indexOf(customQ3FailMessage), 1);
            if(this.customQuestion1Must && this.refs.customQuestion1 && this.refs.customQuestion1.value.trim() === "") {
                this.refs.customQuestion1.classList.add('graphjs-error');
                this.failMessages.push(customQ1FailMessage);
                return false;
            }
            if(this.customQuestion2Must && this.refs.customQuestion1 && !this.refs.customQuestion2.value.trim() === "") {
                this.refs.customQuestion2.classList.add('graphjs-error');
                this.failMessages.push(customQ2FailMessage);
                return false;
            }
            if(this.customQuestion3Must && this.refs.customQuestion1 && !this.refs.customQuestion3.value.trim() !== "") {
                this.refs.customQuestion3.classList.add('graphjs-error');
                this.failMessages.push(customQ3FailMessage);
                return false;
            }
            return true;
        }
        this.checkEmailPattern = () => {
            let failMessage = this.language.emailPatternError;
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
            let failMessage = this.language.passwordMinLengthError.replace('%s',passwordMinimumLengthLimit);
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
            let failMessage = this.language.passwordMaxLengthError.replace('%s',passwordMaximumLengthLimit);
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
            let failMessage = this.language.passwordMatchError;
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
            let validCustomQuestions = this.checkCustomQuestions();
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            let validPasswordMaximumLength = this.checkPasswordMaximumLength();
            let validPasswordMatch = this.checkPasswordMatch();
            if(
                validUsernameMinimumLength && validUsernameMaximumLength && validUsernamePattern && // Username
                validEmailPattern && // Email
                validCustomQuestions && // custom questions
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
            let customQuestion1 = self.refs.customQuestion1 ? self.refs.customQuestion1.value : "";
            let customQuestion2 = self.refs.customQuestion2 ? self.refs.customQuestion2.value : "";
            let customQuestion3 = self.refs.customQuestion3 ? self.refs.customQuestion3.value : "";
            self.refs.username.className = '';
            self.refs.email.className = '';
            self.refs.password.className = '';
            self.failMessages = [];
            if(self.validateInformation()) {
            	register(
            		username,
            		email,
            		password,
                    customQuestion1,
                    customQuestion2,
                    customQuestion3,
                    function(response) {
                        if(response.success) {
                            if(response.pending_moderation) {
                                self.refs.submit.classList.remove('graphjs-loading');
                                if(opts.minor) {
                                    opts.callback();
                                    opts.refresh();
                                } else {
                                    hideOverlay();
                                }
                                showAlert({
                                    'title': 'Pending Membership',
                                    'message': 'Please wait while your request is reviewed by the moderators.',
                                });
                                Array.from(document.getElementsByTagName('graphjs-auth-register')).forEach((item) => {
                                            item.style.display="none";
                                        });
                                return;
                            }
                            if(response.id && response.pending_verification) {
                                self.refs.submit.classList.remove('graphjs-loading');
                                if(opts.minor) {
                                    opts.callback();
                                    opts.refresh();
                                } else {
                                    hideOverlay();
                                }
                                showVerify({
                                    'id': response.id
                                });
                                Array.from(document.getElementsByTagName('graphjs-auth-register')).forEach((item) => {
                                            item.style.display="none";
                                        });
                                return;
                            }
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
                                            'message': 'Please log in to continue.',
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
                            self.refs.customQuestion1 && self.refs.customQuestion1.classList.add('graphjs-error');
                            self.refs.customQuestion2 && self.refs.customQuestion2.classList.add('graphjs-error');
                            self.refs.customQuestion3 && self.refs.customQuestion3.classList.add('graphjs-error');
                            self.refs.submit.classList.remove('graphjs-loading');
                            self.update();
                        }
                    }
            	);
            }
        }

        this.on('mount', () => this.refs.username.focus());
    </script>
</graphjs-auth-register>
