<graphjs-forum class="box">
    <graphjs-forum-list
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'list'}
    />
    <graphjs-forum-entry
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'entry'}
    />
    <graphjs-forum-compose
        minor={true}
        callback={changeActiveItem}
        if={this.active == 'compose'}
    />
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/forum.less';
    </style>
    <script>
        import './forum-list.tag'
        import './forum-entry.tag'
        import './forum-compose.tag'

        this.active = 'list';
        this.changeActiveItem = (e) => {
            this.active = e.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-forum>