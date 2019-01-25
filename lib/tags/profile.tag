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
        default-avatar={opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar}
    />
    <graphjs-profile-activity
        id={id}
        minor={true}
        box={opts.box}
        target-profile={opts.targetProfile}
        target-group={opts.targetGroup}
        target-comments={opts.targetComments}
        target-feed-item={opts.targetFeedItem}
        target-forum-thread={opts.targetForumThread}
        no-activity-text={opts.noActivityText}
        callback={changeProperties}
        if={active == 'activity'}
    />
    <graphjs-profile-followers
        id={id}
        minor={true}
        no-followers-text={opts.noFollowersText}
        callback={changeProperties}
        if={active == 'followers'}
    />
    <graphjs-profile-following
        id={id}
        minor={true}
        no-following-text={opts.noFollowingText}
        callback={changeProperties}
        if={active == 'following'}
    />
    <graphjs-profile-groups
        id={id}
        minor={true}
        no-groups-text={opts.noGroupsText}
        callback={changeProperties}
        if={active == 'groups'}
    />
    <graphjs-profile-settings
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'settings'}
        default-avatar={opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar}
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