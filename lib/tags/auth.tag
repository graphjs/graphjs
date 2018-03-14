<graphjs-auth class="box">
    <graphjs-auth-login
        minor={true}
        title={opts.title}
        callback={changeActiveItem}
        if={this.active == 'login'}
    />
    <graphjs-auth-register
        minor={true}
        title={opts.title}
        callback={changeActiveItem}
        if={this.active == 'register'}
    />
    <graphjs-auth-reset
        minor={true}
        title={opts.title}
        callback={changeActiveItem}
        if={this.active == 'reset'}
    />
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth.less';
    </style>
    <script>
        import './auth-login.tag';
        import './auth-register.tag';
        import './auth-reset.tag';

        this.active = opts.default || 'login';
        this.changeActiveItem = (e) => {
            this.active = e.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-auth>