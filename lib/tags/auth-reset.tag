<graphjs-auth-reset class={opts.minor != true && 'box'}>
    <div class="header" if={opts.header != 'disabled'}>
        <div class="title">{opts.label || 'Reset Password'}</div>
    </div>
    <div class="content">
        <form>
            <input type="text" placeholder="Your email address"/>
            <button>Reset</button>
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
</graphjs-auth-reset>