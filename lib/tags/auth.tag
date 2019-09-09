<graphjs-auth
    class={'graphjs-element graphjs-root graphjs-' + position}
    style={'font-size: calc(' + height + ' * 2 / 7);'}
>
    <graphjs-auth-state
        minor={true}
        callback={changeProperties}
        box={opts.box}
        active={active}
        target={opts.target}
        height={opts.height}
        default-avatar={opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar}
        color={opts.color}
    />
    <graphjs-auth-login
        minor={true}
        title={opts.title}
        callback={changeProperties}
        style={(position == 'topleft' || position == 'topright')
            ? 'top: calc(' + height + ' + 1em);'
            : 'top: -1em'}
        refresh={refreshState}
        if={active == 'login'}
    />
    <graphjs-auth-register
        minor={true}
        title={opts.title}
        callback={changeProperties}
        style={(position == 'topleft' || position == 'topright')
            ? 'top: calc(' + height + ' + 1em);'
            : 'top: -1em'}
        refresh={refreshState}
        if={active == 'register'}
    />
    <graphjs-auth-reset
        minor={true}
        title={opts.title}
        callback={changeProperties}
        style={(position == 'topleft' || position == 'topright')
            ? 'top: calc(' + height + ' + 1em);'
            : 'top: -1em'}
        refresh={refreshState}
        if={active == 'reset'}
    />
    <graphjs-auth-verify
        minor={true}
        title={opts.title}
        callback={changeProperties}
        style={(position == 'topleft' || position == 'topright')
            ? 'top: calc(' + height + ' + 1em);'
            : 'top: -1em'}
        refresh={refreshState}
        if={active == 'verify'}
    />
    <script>
        import './auth-state.tag';
        import './auth-login.tag';
        import './auth-register.tag';
        import './auth-reset.tag';
        import './auth-verify.tag';

        this.active = opts.default || undefined;
        this.height = opts.height || '50px';
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.position = (opts.position && ['topleft', 'topright', 'bottomleft', 'bottomright'].includes(opts.position)) ? opts.position : 'topleft';
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