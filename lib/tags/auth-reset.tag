<graphjs-auth-reset class={opts.minor != true && 'box'}>
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Reset Password'}</div>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul>
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form>
            <input ref="email" type="text" placeholder="Enter your email address"/>
            <button onclick={handleSubmit}>Reset</button>
            <div class="option single">
                <a data-link="register" onclick={opts.minor ? opts.callback : handleRegisterBox}>Not registered?</a>
            </div>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth-reset.less';
    </style>
    <script>
        import reset from '../scripts/reset.js';

        import showRegisterBox from '../scripts/showRegisterBox.js';
        this.handleRegisterBox = () => showRegisterBox();

        this.warningMessages = [];
        this.checkEmailPattern = () => {
            let warningMessage = 'Email is invalid.';
            let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if(emailPattern.test(this.refs.email.value)) {
                this.refs.email.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.email.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.validateForm = () => {
            let validEmailPattern = this.checkEmailPattern();
            return (
                validEmailPattern
            ) ? true : false;
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            this.validateForm() && reset(
                this.refs.email.value,
                function(response) {
                    if(response.success) {
                        showAlertBox({
                            title: 'Email Sent!',
                            message: 'An email sent to your email address.'
                        });
                    } else {
                        showAlertBox({
                            title: 'Reset Failed!',
                            message: response.reason || 'Please try entering your email again.',
                            customoption: 'Retry',
                            show: 'reset',
                            negativeoption: 'Cancel'
                        });
                    }
                }
            );
        }
    </script>
</graphjs-auth-reset>