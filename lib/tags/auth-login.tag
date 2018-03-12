<graphjs-auth-login class={opts.minor != true && 'box'}>
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Login'}</div>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul>
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form>
            <input ref="username" type="text" placeholder="Enter your username" />
            <input ref="password" type="password" placeholder="Enter your password" />
            <button onclick={handleSubmit}>Login</button>
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
        this.checkUsernamePattern = () => {
            let warningMessage = 'Username is invalid. Valid characters are letters, numbers, hyphens, and underscores.';
            let usernamePattern = /^[a-zA-Z0-9-_]+$/;
            if(usernamePattern.test(this.refs.username.value)) {
                this.refs.username.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.validateForm = () => {
            let validUsernamePattern = this.checkUsernamePattern();
            return (
                validUsernamePattern
            ) ? true : false;
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            this.validateForm() && login(
                this.refs.username.value,
                this.refs.password.value
            );
        }
    </script>
</graphjs-auth-login>