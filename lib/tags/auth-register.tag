<graphjs-auth-register class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Register'}</div>
    </div>
    <div class="content">
        <form>
            <input type="text" placeholder="Your full name"/>
            <input type="text" placeholder="Your email address"/>
            <input type="text" placeholder="Set password"/>
            <input type="text" placeholder="Confirm password"/>
            <button>Register</button>
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
</graphjs-auth-register>