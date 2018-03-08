<graphjs-auth-login class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Login'}</div>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul>
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form onkeyup={validateForm}>
            <input ref="email" onkeyup={checkEmail} type="text" placeholder="Enter your email" />
            <input ref="password" type="password" placeholder="Enter your password" />
            <button onclick={handleLogin} disabled={!isFormReady}>Login</button>
            <div class="option double">
                <a data-link="register" onclick={opts.minor ? opts.callback : ''}>Not registered?</a>
                <a data-link="reset" onclick={opts.minor ? opts.callback : ''}>Forgot Password</a>
            </div>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth-login.less';
    </style>
    <script>
        import login from '../scripts/login.js';
        this.warningMessages = [];
        this.validEmail = false;
        this.checkEmail = () => {
            let warningMessage = 'Email is invalid.';
            let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if(emailPattern.test(this.refs.email.value)) {
                this.refs.email.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                this.validEmail = true;
            } else {
                this.refs.email.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                this.validEmail = false;
            }
        }
        this.validateForm = () => {
            if(
                this.refs.email.value.length > 0 && this.validEmail &&
                this.refs.password.value.length > 0
            ) {
                this.isFormReady = true;
            } else {
                this.isFormReady = false;
            }
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            this.isFormReady && login(
                this.refs.email.value,
                this.refs.password.value
            );
        }
    </script>
</graphjs-auth-login>