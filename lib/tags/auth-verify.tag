<graphjs-auth-verify class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}>
    <div class="graphjs-header">
        <div class="graphjs-title">{language.title}</div>
    </div>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <form class="graphjs-code">
            <b>{language.explanation}</b>
            <div ref="code">
                <input each={item in Array(codeCharacterCount)} oninput={handleCodeInput} onkeyup={handleCodeInputKeyUp} type="text" />
            </div>
            <button ref="submitCode" onclick={handleCodeSubmit}>{language.submitCodeButton}</button>
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
        import verifyEmailCode from '../scripts/verifyEmailCode.js';
        import showAlert from '../scripts/showAlert.js';
        import hideOverlay from '../scripts/hideOverlay.js';

        analytics("auth-verify");
        this.language = language('auth-verify', opts);

        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';

        this.codeCharacterCount = 6;
        this.codeTemplate = new Array(this.codeCharacterCount);
        this.failMessages = [];
        this.id = opts.id;

        //Step 1: provideEmail
        //Step 2: verifyCode
        this.handleCodeInput = (event) => {
            if(!isNaN(parseInt(event.target.value))) {
                let currentElement = event.target;
                currentElement.value.split('').forEach((char) => {
                    if(!isNaN(parseInt(char))) {
                        currentElement.value = char;
                        currentElement = currentElement.nextElementSibling;
                        currentElement && currentElement.focus();
                    }
                });
            } else {
                event.target.value = '';
            }
        }
        this.handleCodeInputKeyUp = (e) => {
            if(event.keyCode == 8 && event.target.value == '') {
               event.target.previousElementSibling && event.target.previousElementSibling.focus();
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
            let id = self.id;
            let characters = Array.from(self.refs.code.children);
            self.refs.submitCode.classList.add('graphjs-loading');
            let code = '';
            characters.forEach(function(item) {
                code += item.value;
                item.className = '';
            });
            self.failMessages = [];
            if(self.validateCode()) {
                verifyEmailCode(
                    id,
                    code,
                    function(response) {
                        if(response.success) {
                            self.refs.submitCode.classList.remove('graphjs-loading');
                            self.checked = true;
                            self.update();
                            Array.from(document.getElementsByClassName('graphjs-element')).forEach((item) => {
                                item._tag && item._tag.restart && item._tag.restart();
                            });
                            setTimeout(function() {
                                if(opts.minor) {
                                    opts.callback();
                                    opts.refresh();
                                } else {
                                    hideOverlay();
                                }
                            }, 2500);
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
    </script>
</graphjs-auth-verify>