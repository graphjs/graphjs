<graphjs-profile>
    <p>Placeholder for Profile</p>
    <!--
    <graphjs-profile-header
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
    <graphjs-profile-followees
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'followees'}
    />
    <graphjs-profile-groups
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'groups'}
    />
    -->
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        /* @import '../styles/components/profile.less'; */
    </style>
    <script>
        /*
        import './graphjs-profile-header.tag';
        import './graphjs-profile-activity.tag';
        import './graphjs-profile-followers.tag';
        import './graphjs-profile-followees.tag';
        import './graphjs-profile-groups.tag';
        */

        this.active = opts.default || 'activity';
        this.changeActiveItem = (e) => {
            this.active = e.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-profile>