<graphjs-auth-login class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Login'}</div>
    </div>
    <div class="content">
        <form>
            <input type="text" placeholder="Enter your full name" />
            <input type="text" placeholder="Enter your password" />
            <button>Login</button>
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
</graphjs-auth-login>