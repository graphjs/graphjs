<graphjs-auth-register class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Register'}</div>
    </div>
    <div class="warning" if={warningMessage.length > 0}>
        <p>{warningMessage}</p>
    </div>
    <div class="content">
        <form onkeyup={validateForm}>
            <input ref="username" type="text" placeholder="Choose a nickname"/>
            <input ref="email" type="text" placeholder="Enter email address"/>
            <input ref="password" onkeyup={confirmPassword} type="password" placeholder="Set password"/>
            <input ref="confirmation" onkeyup={confirmPassword} type="password" placeholder="Confirm password"/>
            <button ref="submit" onclick={handleRegister} disabled={!isFormReady}>Register</button>
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
        this.warningMessage = '';
        this.handleRegister = (event) => {
            event.preventDefault();
        	register(
        		this.refs.username.value,
        		this.refs.email.value,
        		this.refs.password.value
        	);
        }
        this.validateForm = () => {
            if(
                this.refs.username.value.length > 0 &&
                this.refs.email.value.length > 0 &&
                this.refs.password.value.length > 0 &&
                this.refs.confirmation.value.length > 0 &&
                this.refs.password.value == this.refs.confirmation.value
            ) {
                this.isFormReady = true;
            } else {
                this.isFormReady = false;
            }
        }
        this.confirmPassword = () => {
            if(this.refs.password.value == this.refs.confirmation.value) {
                this.refs.password.classList.remove('error');
                this.refs.confirmation.classList.remove('error');
            } else {
                this.refs.password.classList.add('error');
                this.refs.confirmation.classList.add('error');
            }
        }
    </script>
</graphjs-auth-register>