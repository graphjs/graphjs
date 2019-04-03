<graphjs-auth-reset class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Reset Password'}</div>
    </div>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <form if={next == 'provideEmail'}>
            <b>{language.stepOneHeader}</b>
            <p>{language.stepOne}</p>
            <input ref="email" type="text" placeholder={language.emailPlaceholder}/>
            <button ref="submitEmail" onclick={handleEmailSubmit}>{language.submitEmailButton}</button>
            <div class="graphjs-option graphjs-single">
                <a data-link="register" onclick={opts.minor ? opts.callback : handleRegisterBox}>{language.registerLink}</a>
            </div>
        </form>
        <form class="graphjs-code" if={next == 'verifyCode'}>
            <b>{language.stepTwoHeader}</b>
            <p>{language.stepTwo}</p>
            <div ref="code">
                <input each={item in Array(codeCharacterCount)} onkeyup={handleCodeInput} type="text" maxlength="1" />
            </div>
            <button ref="submitCode" onclick={handleCodeSubmit}>{language.submitCodeButton}</button>
        </form>
        <form class="graphjs-code" if={next == 'updatePassword'}>
            <b>{language.stepThreeHeader}</b>
            <p>{language.stepThree}</p>
            <input ref="password" type="password" placeholder={language.passwordPlaceholder} autocomplete="off" />
            <input ref="confirmation" type="password" placeholder={language.confirmPasswordPlaceholder} autocomplete="off" />
            <button ref="submitPassword" onclick={handlePasswordSubmit}>{language.submitPasswordButton}</button>
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
        import reset from '../scripts/reset.js';
        import verify from '../scripts/verify.js';
        import showAlert from '../scripts/showAlert.js';
        import showRegister from '../scripts/showRegister.js';
        import setPassword from '../scripts/setPassword.js';
        import hideOverlay from '../scripts/hideOverlay.js';

        analytics("auth-reset");

        this.language = language('auth-reset', opts);

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';

        //this.next = 'provideEmail';
        this.next = 'provideEmail';
        this.codeCharacterCount = 6;
        this.codeTemplate = new Array(this.codeCharacterCount);
        this.failMessages = [];

        this.handleRegisterBox = () => showRegister();
        //Step 1: provideEmail
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
        this.validateEmail = () => {
            let validEmailPattern = this.checkEmailPattern();
            if(
                validEmailPattern
            ) {
                return true;
            } else {
                this.refs.submitEmail.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.handleEmailSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitEmail.classList.add('graphjs-loading');
            let email = self.refs.email.value;
            self.refs.email.className = '';
            self.failMessages = [];
            if(self.validateEmail()) {
                reset(
                    email,
                    function(response) {
                        if(response.success) {
                            self.refs.submitEmail.classList.remove('graphjs-loading');
                            self.email = email;
                            self.next = 'verifyCode';
                            self.update();
                            self.refs.code.firstElementChild.focus();
                        } else {
                            failMessage = response.reason || 'Please try entering your email again.';
                            self.refs.submitEmail.classList.remove('graphjs-loading');
                            self.refs.email.classList.add('graphjs-error');
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.update();
                        }
                    }
                );
            }
        }
        //Step 2: verifyCode
        this.handleCodeInput = (event) => {
            if(event.keyCode != 46 && event.keyCode != 8) {
                if(!isNaN(parseInt(event.target.value))) {
                    event.target.nextElementSibling && event.target.nextElementSibling.focus();
                } else {
                    event.target.value = '';
                }
            }
        }
        this.checkCodeCharacterLength = () => {
            let self = this;
            let characters = Array.from(self.refs.code.children);
            let failMessage = this.language.checkCodeError.replace('%s',self.codeCharacterCount)
            let result = true;
            characters.forEach(function(item) {
                if(item.value.length != 1) {
                    result = false;
                }
            });
            if(result == true) {
                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
            } else {
                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
            }
            return result;
        }
        this.checkCodeCharacterType = () => {
            let self = this;
            let characters = Array.from(self.refs.code.children);
            let failMessage = 'All ' + self.codeCharacterCount + ' characters must be number!';
            let result = true;
            characters.forEach(function(item) {
                if(isNaN(item.value)) {
                    result = false;
                }
            });
            if(result == true) {
                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
            } else {
                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
            }
            return result;
        }
        this.validateCode = () => {
            let characters = Array.from(this.refs.code.children);
            let validCodeCharacterLength = this.checkCodeCharacterLength();
            let validCodeCharacterType = this.checkCodeCharacterType();
            if(
                validCodeCharacterLength && validCodeCharacterType // Code
            ) {
                characters.forEach(function(item) {
                    item.classList.remove('graphjs-error');
                });
                return true;
            } else {
                this.refs.submitCode.classList.remove('graphjs-loading');
                characters.forEach(function(item) {
                    item.classList.add('graphjs-error');
                });
                return false;
            }
        }
        this.handleCodeSubmit = (event) => {
            event.preventDefault();
            let self = this;
            let characters = Array.from(self.refs.code.children);
            self.refs.submitCode.classList.add('graphjs-loading');
            let code = '';
            characters.forEach(function(item) {
                code += item.value;
                item.className = '';
            });
            self.failMessages = [];
            if(self.validateCode()) {
                verify(
                    self.email,
                    code,
                    function(response) {
                        if(response.success) {
                            self.refs.submitCode.classList.remove('graphjs-loading');
                            self.next = 'updatePassword';
                            self.update();
                        } else {
                            let failMessage = response.reason || 'Please try entering your code again.';
                            self.refs.submitCode.classList.remove('graphjs-loading');
                            let characters = Array.from(self.refs.code.children);
                            characters.forEach(function(item) {
                                item.classList.add('graphjs-error');
                            });
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.update();
                        }
                    }
                );
            }
        }
        //Step 3: updatePassword
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
            let failMessage = this.language.passwordMaxLengthError.replace('%s',passwordMaximumLengthLimit);;
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
        this.validatePassword = () => {
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            let validPasswordMaximumLength = this.checkPasswordMaximumLength();
            let validPasswordMatch = this.checkPasswordMatch();
            if(
                validPasswordMinimumLength && validPasswordMaximumLength && validPasswordMatch // Password
            ) {
                return true;
            } else {
                this.refs.submitPassword.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.handlePasswordSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitPassword.classList.add('graphjs-loading');
            let password = self.refs.password.value;
            self.refs.password.className = '';
            self.refs.confirmation.className = '';
            self.failMessages = [];
            if(self.validatePassword()) {
                setPassword(
                    password,
                    function(response) {
                        if(response.success) {
                            self.refs.submitPassword.classList.remove('graphjs-loading');
                            self.checked = true;
                            self.update();
                            setTimeout(function() {
                                if(opts.minor) {
                                    opts.callback();
                                    opts.refresh();
                                } else {
                                    hideOverlay();
                                }
                            }, 2500);
                        } else {
                            failMessage = response.reason || 'Please try entering your password again.';
                            self.refs.submitPassword.classList.remove('graphjs-loading');
                            self.refs.password.classList.add('graphjs-error');
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.update();
                        }
                    }
                );
            }
        }
    </script>
</graphjs-auth-reset>