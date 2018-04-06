<graphjs-group class="root">
    <graphjs-group-header
        id={opts.id}
        minor={true}
        callback={changeProperties}
    />
    <graphjs-group-activity
        minor={true}
        callback={changeProperties}
        if={this.active == 'activity'}
    />
    <graphjs-group-members
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'members'}
    />
    <graphjs-group-settings
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={this.active == 'settings'}
    />
    <a class="promo" href="http://graphjs.com">
        powered by <img src="lib/images/identity/logo.svg" />
    </a>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group.less';
    </style>
    <script>
        import './group-header.tag';
        import './group-activity.tag';
        import './group-members.tag';

        this.active = opts.default || 'members';
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-group>