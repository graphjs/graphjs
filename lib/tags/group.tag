<graphjs-group>
    <p>Placeholder for Group</p>
    <!--
    <graphjs-group-header
        minor={true}
        callback={changeProperties}
    />
    <graphjs-group-activity
        minor={true}
        callback={changeProperties}
        if={this.active == 'activity'}
    />
    <graphjs-group-members
        minor={true}
        callback={changeProperties}
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
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-group>