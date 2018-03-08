<graphjs-auth-register class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Register'}</div>
    </div>
    <div class="warning" if={warningMessages.length > 0}>
        <ul>
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <form onkeyup={validateForm}>
            <input ref="username" onkeyup={checkUsername} type="text" placeholder="Choose a nickname"/>
            <input ref="email" onkeyup={checkEmail} type="text" placeholder="Enter email address"/>
            <input ref="password" onkeyup={checkPassword} type="password" placeholder="Set password"/>
            <input ref="confirmation" onkeyup={checkPassword} type="password" placeholder="Confirm password"/>
            <button ref="submit" onclick={handleSubmit} disabled={!isFormReady}>Register</button>
            <div class="option single">
                <a data-link="login" onclick={opts.minor ? opts.callback : ''}>Already a member?</a>
            </div>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth-register.less';
    </style>
    <script>
        import register from '../scripts/register.js';
        this.warningMessages = [];
        this.validUsername = false;
        this.validEmail = false;
        this.validPassword = false;
        this.checkUsername = () => {
            let warningMessage = 'Username is invalid.';
            let usernamePattern = /^[a-z\d\-_\s]+$/i;
            if(usernamePattern.test(this.refs.username.value) && this.refs.username.value.length > 1) {
                this.refs.username.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                this.validUsername = true;
            } else {
                this.refs.username.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                this.validUsername = false;
            }
        }
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
        this.checkPassword = () => {
            let warningMessage = 'Passwords do not match.';
            if(this.refs.password.value == this.refs.confirmation.value) {
                this.refs.password.classList.remove('error');
                this.refs.confirmation.classList.remove('error');
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                this.validPassword = true;
            } else {
                this.refs.password.classList.add('error');
                this.refs.confirmation.classList.add('error');
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                this.validPassword = false;
            }
        }
        this.validateForm = () => {
            if(
                this.refs.username.value.length > 0 && this.validUsername &&
                this.refs.email.value.length > 0 && this.validEmail &&
                this.refs.password.value.length > 0 && this.refs.confirmation.value.length > 0 && this.validPassword
            ) {
                this.isFormReady = true;
            } else {
                this.isFormReady = false;
            }
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
        	this.isFormReady && register(
        		this.refs.username.value,
        		this.refs.email.value,
        		this.refs.password.value
        	);
        }
    </script>
</graphjs-auth-register>