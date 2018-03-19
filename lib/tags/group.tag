<graphjs-group>
    <p>Placeholder for Group</p>
    <!--
    <graphjs-group-header
        minor={true}
        callback={changeActiveItem}
    />
    <graphjs-group-activity
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'activity'}
    />
    <graphjs-group-members
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'followers'}
    />
    -->
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        /* @import '../styles/components/group.less'; */
    </style>
    <script>
        /*
        import './graphjs-group-header.tag';
        import './graphjs-group-activity.tag';
        import './graphjs-group-members.tag';
        */

        this.active = opts.default || 'activity';
        this.changeActiveItem = (e) => {
            this.active = e.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-group>