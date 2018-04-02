<graphjs-auth-login class={opts.minor != true && 'box'}>
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Login'}</div>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul if={warningMessages.length > 0} class="fail">
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form>
            <input ref="username" type="text" placeholder="Enter your username" />
            <input ref="password" type="password" placeholder="Enter your password" />
            <button onclick={handleSubmit}>Login</button>
            <div class="option double">
                <a data-link="register" onclick={opts.minor ? opts.callback : handleRegisterBox}>Not registered?</a>
                <a data-link="reset" onclick={opts.minor ? opts.callback : handleResetBox}>Forgot Password</a>
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
        import showAlert from '../scripts/showAlert.js';
        import showRegister from '../scripts/showRegister.js';
        import showReset from '../scripts/showReset.js';

        this.handleRegisterBox = () => showRegister();
        this.handleResetBox = () => showReset();

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
                this.refs.password.value,
                function(response) {
                    if(response.success) {
                        showAlert({
                            title: 'Login Succeeded!',
                            message: 'You are successfully logged in.',
                            customoption: 'Done'
                        });
                    } else {
                        showAlert({
                            title: 'Login Failed!',
                            message: response.reason || 'Please try logging in again.',
                            customoption: 'Retry',
                            show: 'login',
                            negativeoption: 'Cancel'
                        });
                    }
                }
            );
        }
    </script>
</graphjs-auth-login>