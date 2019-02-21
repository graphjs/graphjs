<graphjs-auth-login
    class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title}</div>
    </div>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <form>
            <input ref="username" type="text" placeholder={language.usernamePlaceholder} />
            <input ref="password" type="password" placeholder={language.passwordPlaceholder}/>
            <button ref="submit" onclick={handleSubmit}>{language.submitButton}</button>
            <div class="graphjs-option graphjs-double">
                <a data-link="register" onclick={opts.minor ? opts.callback : handleRegisterBox}>{language.registerLink}</a>
                <a data-link="reset" onclick={opts.minor ? opts.callback : handleResetBox}>{language.resetLink}</a>
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
        import login from '../scripts/login.js';
        import showAlert from '../scripts/showAlert.js';
        import showRegister from '../scripts/showRegister.js';
        import showReset from '../scripts/showReset.js';
        import hideOverlay from '../scripts/hideOverlay.js';

        analytics('auth-login');

        this.language = language('auth-login', opts);

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';

        this.handleRegisterBox = () => showRegister();
        this.handleResetBox = () => showReset();

        this.failMessages = [];

        this.checkUsernameMinimumLength = () => {
            let usernameMinimumLengthLimit = 1;
            let failMessage = language.usernameLengthError;
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
        this.checkUsernamePattern = () => {
            let failMessage = language.usernamePatternError;
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
        this.checkPasswordMinimumLength = () => {
            let passwordMinimumLengthLimit = 5;
            let failMessage = language.passwordError.replace('%s',passwordMinimumLengthLimit);

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
        this.validateInformation = () => {
            let validUsernameMinimumLength = this.checkUsernameMinimumLength();
            let validUsernamePattern = this.checkUsernamePattern();
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            if(
                validUsernameMinimumLength && validUsernamePattern && // Username
                validPasswordMinimumLength // Username
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
            let password = self.refs.password.value;
            self.refs.username.className = '';
            self.refs.password.className = '';
            self.failMessages = [];
            if(self.validateInformation()) {
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
                                'title': 'Login Succeeded!',
                                'message': 'You are successfully logged in.',
                                'affirmative': 'Done'
                            });
                            */
                        } else {
                            let failMessage = response.reason || 'We couldn\'t log you in.';
                            self.failMessages = [];
                            self.failMessages.push(failMessage);
                            self.refs.username.className = 'graphjs-error';
                            self.refs.password.className = 'graphjs-error';
                            self.refs.submit.classList.remove('graphjs-loading');
                            self.update();
                            /*
                            showAlert({
                                'title': 'Login Failed!',
                                'message': response.reason || 'Please try logging in again.',
                                'affirmative': 'Retry',
                                'negative': 'Cancel',
                                'show': 'login'
                            });
                            */
                        }
                    }
                );
            }
        }
    </script>
</graphjs-auth-login>