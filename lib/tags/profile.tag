<graphjs-profile>
    <graphjs-profile-header
        id={opts.id}
        active={this.active}
        minor={true}
        callback={changeProperties}
    />
    <graphjs-profile-activity
        minor={true}
        callback={changeProperties}
        if={this.active == 'activity'}
    />
    <graphjs-profile-followers
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'followers'}
    />
    <graphjs-profile-following
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'following'}
    />
    <graphjs-profile-groups
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'groups'}
    />
    <graphjs-profile-settings
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'settings'}
    />
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/profile.less';
    </style>
    <script>
        import './profile-header.tag';
        import './profile-activity.tag';
        import './profile-followers.tag';
        import './profile-following.tag';
        import './profile-groups.tag';
        import './profile-settings.tag';

        this.active = opts.default || 'followers';
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-profile>