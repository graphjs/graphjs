<graphjs-auth-login class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Login'}</div>
    </div>
    <div class="warning" if={warningMessage.length > 0}>
        <p>{warningMessage}</p>
    </div>
    <div class="content">
        <form onkeyup={validateForm}>
            <input ref="email" type="text" placeholder="Enter your email" />
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
        this.warningMessage = '';
        this.handleLogin = (event) => {
            event.preventDefault();
            login(
                this.refs.email.value,
                this.refs.password.value
            );
        }
        this.validateForm = () => {
            if(
                this.refs.email.value.length > 0 &&
                this.refs.password.value.length > 0
            ) {
                this.isFormReady = true;
            } else {
                this.isFormReady = false;
            }
        }
    </script>
</graphjs-auth-login>