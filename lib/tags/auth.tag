<graphjs-auth
    class={'graphjs-element graphjs-root graphjs-' + position}
    style={'height: ' + height + '; line-height: ' + height + '; '}
>
    <graphjs-auth-state
        minor={true}
        callback={changeProperties}
        box={opts.box}
        theme={opts.theme}
        active={active}
        height={opts.height}
    />
    <graphjs-auth-login
        minor={true}
        title={opts.title}
        callback={changeProperties}
        gap={(position == 'topleft' || position == 'topright') ? height : 0}
        refresh={refreshState}
        if={active == 'login'}
    />
    <graphjs-auth-register
        minor={true}
        title={opts.title}
        callback={changeProperties}
        gap={(position == 'topleft' || position == 'topright') ? height : 0}
        refresh={refreshState}
        if={active == 'register'}
    />
    <graphjs-auth-reset
        minor={true}
        title={opts.title}
        callback={changeProperties}
        gap={(position == 'topleft' || position == 'topright') ? height : 0}
        refresh={refreshState}
        if={active == 'reset'}
    />
    <script>
        import './auth-state.tag';
        import './auth-login.tag';
        import './auth-register.tag';
        import './auth-reset.tag';

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