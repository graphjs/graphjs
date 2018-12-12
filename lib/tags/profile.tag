<graphjs-profile class="graphjs-element graphjs-root" style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <graphjs-profile-header
        id={id}
        active={active}
        minor={true}
        box={opts.box}
        callback={changeProperties}
    />
    <graphjs-profile-activity
        id={id}
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'activity'}
    />
    <graphjs-profile-followers
        id={id}
        minor={true}
        callback={changeProperties}
        if={active == 'followers'}
    />
    <graphjs-profile-following
        id={id}
        minor={true}
        callback={changeProperties}
        if={active == 'following'}
    />
    <graphjs-profile-groups
        id={id}
        minor={true}
        callback={changeProperties}
        if={active == 'groups'}
    />
    <graphjs-profile-settings
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'settings'}
    />
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import './profile-header.tag';
        import './profile-activity.tag';
        import './profile-followers.tag';
        import './profile-following.tag';
        import './profile-groups.tag';
        import './profile-settings.tag';

        analytics("profile");

        this.active = opts.default || 'activity';
        let self = this;
        if(opts.id) {
            this.id = opts.id;
        } else {
            getSession((response) => {
                if(response.success) {
                    self.id = response.id;
                    self.update();
                }
            });
        }
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-profile>