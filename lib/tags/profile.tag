<graphjs-profile class="graphjs-element graphjs-root">
    <graphjs-profile-header
        id={opts.id}
        active={active}
        minor={true}
        callback={changeProperties}
    />
    <graphjs-profile-activity
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'activity'}
    />
    <graphjs-profile-followers
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'followers'}
    />
    <graphjs-profile-following
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'following'}
    />
    <graphjs-profile-groups
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'groups'}
    />
    <graphjs-profile-settings
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'settings'}
    />
    <script>
        import analytics from '../scripts/analytics.js';
        import './profile-header.tag';
        import './profile-activity.tag';
        import './profile-followers.tag';
        import './profile-following.tag';
        import './profile-groups.tag';
        import './profile-settings.tag';

        analytics("profile");

        this.active = opts.default || 'activity';
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-profile>