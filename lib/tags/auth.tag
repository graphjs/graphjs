<graphjs-auth>
    <graphjs-auth-state
        minor={true}
        callback={changeProperties}
        style={opts.style}
        theme={opts.theme}
    />
    <div if={active} class="box">
        <graphjs-auth-login
            minor={true}
            title={opts.title}
            callback={changeProperties}
            refresh={refreshState}
            if={active == 'login'}
        />
        <graphjs-auth-register
            minor={true}
            title={opts.title}
            callback={changeProperties}
            refresh={refreshState}
            if={active == 'register'}
        />
        <graphjs-auth-reset
            minor={true}
            title={opts.title}
            callback={changeProperties}
            refresh={refreshState}
            if={active == 'reset'}
        />
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth.less';
    </style>
    <script>
        import './auth-state.tag';
        import './auth-login.tag';
        import './auth-register.tag';
        import './auth-reset.tag';

        this.active = opts.default || undefined;
        this.changeProperties = (event) => {
            this.active = event ? event.currentTarget.dataset.link : undefined;
            this.update();
        }
        this.refreshState = () => {
            this.tags['graphjs-auth-state'].stateInformation = false;
            this.tags['graphjs-auth-state'].update();
            this.tags['graphjs-auth-state'].handleState();
        }
    </script>
</graphjs-auth>