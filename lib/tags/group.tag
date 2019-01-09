<graphjs-group class="graphjs-element graphjs-root" style={
    (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
    (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
    (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
    (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
}>
    <graphjs-group-header
        id={opts.id}
        active={active}
        minor={true}
        box={opts.box}
        callback={changeProperties}
        default-avatar={opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar}
    />
    <graphjs-group-activity
        id={opts.id}
        minor={true}
        box={opts.box}
        no-activity-text={opts.noActivityText}
        callback={changeProperties}
        if={active == 'activity'}
    />
    <graphjs-group-members
        id={opts.id}
        minor={true}
        no-members-text={opts.noMembersText}
        callback={changeProperties}
        if={active == 'members'}
    />
    <graphjs-group-settings
        id={opts.id}
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'settings'}
    />
    <script>
        import analytics from '../scripts/analytics.js';
        import './group-header.tag';
        import './group-activity.tag';
        import './group-members.tag';
        import './group-settings.tag';

        analytics("group");

        this.active = opts.default || 'members';
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-group>