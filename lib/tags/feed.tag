<graphjs-feed
    class="graphjs-root"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <graphjs-feed-composer
        id={opts.id}
        minor={true}
    />
    <graphjs-feed-activity
        id={opts.id}
        minor={true}
    />
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/feed.less';
    </style>
    <script>
        import './feed-composer.tag';
        import './feed-activity.tag';
    </script>
</graphjs-feed>