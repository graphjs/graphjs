<graphjs-profile>
    <graphjs-profile-header
        id={opts.id}
        active={this.active}
        minor={true}
        callback={changeActiveItem}
    />
    <graphjs-profile-activity
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'activity'}
    />
    <graphjs-profile-followers
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'followers'}
    />
    <graphjs-profile-following
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'following'}
    />
    <graphjs-profile-groups
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'groups'}
    />
    <graphjs-profile-settings
        id={opts.id}
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'settings'}
    />
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        /* @import '../styles/components/profile.less'; */
        graphjs-profile {
            display: block;
            width: 48em;
            margin: 0 auto;

        }
    </style>
    <script>
        import './profile-header.tag';
        import './profile-activity.tag';
        import './profile-followers.tag';
        import './profile-following.tag';
        import './profile-groups.tag';
        import './profile-settings.tag';

        this.active = opts.default || 'activity';
        this.changeActiveItem = (e) => {
            this.active = e.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-profile>