<graphjs-auth-reset class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Reset Password'}</div>
    </div>
    <div class="warning" if={warningMessage.length > 0}>
        <p>{warningMessage}</p>
    </div>
    <div class="content">
        <form onkeyup={validateForm}>
            <input ref="email" type="text" placeholder="Your email address"/>
            <button onclick={handleReset} disabled={!isFormReady}>Reset</button>
            <div class="option single">
                <a data-link="register" onclick={opts.minor ? opts.callback : ''}>Not registered?</a>
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
        this.warningMessage = '';
        this.handleReset = (event) => {
            event.preventDefault();
            reset(
                this.refs.email.value
            );
        }
        this.validateForm = () => {
            if(this.refs.email.value.length > 0) {
                this.isFormReady = true;
            } else {
                this.isFormReady = false;
            }
        }
    </script>
</graphjs-auth-reset>